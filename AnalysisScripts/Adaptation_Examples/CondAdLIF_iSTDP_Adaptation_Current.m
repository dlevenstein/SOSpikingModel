function CondAdLIF_iSTDP_Adaptation_Current(repopath,whichnet)

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%whichnet = 'Uniform';
addpath(genpath(repopath))


figfolder = fullfile(repopath,'Figures','AdaptationCurrent');
savedatafolder = fullfile(repopath,'SimData');
%% Set Cluster Number
%numClusters = 5; %This is if you have 5 clusters, so cluster_number inputs are 1-5 

%% Load Scripts Here 

netfolder = fullfile(repopath,'TrainedNets/');

switch whichnet
    case 'Uniform'
        load([netfolder 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat']);
        savefilename = 'AdaptationVCurrentSpikes.mat';
% load([netfolder 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250_starting_values.mat']);
    case 'LogN'
        savefilename = 'LogN_AdaptationVCurrentSpikes.mat';
        load([netfolder 'Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat']);
end
%load([netfolder 'Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250_initial_values.mat']);
%load([netfolder 'Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250_starting_values.mat']);

%% Network Parameters
clear PopParams

PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

%Noise Properties 
PopParams.I_e  = 0;         %External input
PopParams.sigma = 0;        %noise magnitude: variance
PopParams.theta = 0.1;      %noise time scale (1/ms)

%Neuron properties
PopParams.E_L     = [-65 -67];          %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];          %capacitance (pF)
PopParams.V_th    = [-45 -47];          %spike threshold (mV)
PopParams.V_reset = [-55 -55];          %reset potential (mV)
PopParams.t_ref   = 0.5;                %refractory period (ms)

%Synaptic Properties
PopParams.E_e     = 0;              %rev potential: E (mV)
PopParams.E_i     = -80;            %rev potential: I (mV)
PopParams.tau_s   = [5 5];          %synaptic decay timescale (1/ms)

%Adaptation Properties (loop through a or b in loop module)
PopParams.E_w     = -70;            %rev potential: adaptation (mV)
PopParams.a       = 0;              %adaptation decay timescale (1/ms)
PopParams.b       = 0;              %adaptation activation rate (1/ms)
PopParams.tau_w   = 300;            %adaptation decay (ms)
PopParams.gwnorm  = 0;              %magnitude of adaptation

PopParams.t_syn = 0;                %Synaptic Delay

PopParams.LearningRate = 0;
PopParams.TargetRateI = nan; %Target E rate nan Hz (Turns off plasticity)
PopParams.TargetRateE = nan; %Target I rate nan Hz (Turns off plasticity)
PopParams.tauSTDP = 20;

%% Adaptation and Noise Parameters 

PopParamsAnalysis              = PopParams;
PopParamsAnalysis.LearningRate = 0;                      %Learning rate
PopParamsAnalysis.tau_w        = 500;    %300                %adaptation decay (ms)
PopParamsAnalysis.sigma        = 90;     %100               %Noise variance (pA) (Set to Covariance Matrix to add covariance
PopParamsAnalysis.W            = SimValues.WeightMat(:,:,end); %Synaptic Weights
PopParamsAnalysis.gwnorm       = 1;                      %Adaptation norm
PopParamsAnalysis.t_syn        = rand(PopParams.EPopNum+PopParams.IPopNum,1)*0.4+0.05;                      %Synaptic Delay (ms)

%% Note Adaptation Equation
%dwdt =  (- w + a.*(V - E_w))./tau_w; (Line 529)
%w(spikeneurons) = w(spikeneurons) + b(spikeneurons); at time of spike (Line 559)
%g_w = gwnorm.*w; (Line 648)
%% Starting Values

%PopParamsAnalysis.V0 = PopParams_in.V0;
%PopParamsAnalysis.w0 = PopParams_in.w0;
%PopParamsAnalysis.s0 = PopParams_in.s0;

%PopParamsAnalysis.p0spike = 0.05; %start ON
PopParamsAnalysis.p0spike = -0.5; %start OFF (V random halfway to threshold)

TimeParams.dt      = 0.05;

UnRecordedTime = 0;                   %Unrecorded time
RecordTime = 10e3;                       %Recording Time (end of simulation)
SimTime  = UnRecordedTime+RecordTime;   %Total Simulation time

TimeParams.SimTime = SimTime;

Ivals = linspace(0,75,16); %Current Values (pA)
%sigvals = linspace(0,100,11);
bvals = 10.^(-2.5:0.5:1);       %spike-based Adaptation values (nS)
%avals = [0 10.^(-4:0.5:-1)];  %subthreshold-based Adaptation values (nS)

%% Set up for parallel in cluster
pc = parcluster('local');
% store temporary files in the 'scratch' drive on the cluster, labeled by job ID
pc.JobStorageLocation = strcat(getenv('SCRATCH'), '/', getenv('SLURM_JOB_ID'));
% enable MATLAB to utilize the multiple cores allocated in the job script
% SLURM_NTASKS_PER_NODE is a variable set in the job script by the flag --tasks-per-node
% we use SLURM_NTASKS_PER_NODE - 1, because one of these tasks is the original MATLAB script itself
parpool(pc, str2num(getenv('SLURM_NTASKS_PER_NODE'))-1);

%% Loop 

spikes = cell(length(Ivals),length(bvals));
numsims = (length(Ivals)*length(bvals));
%Once running: parfor on cluster.
parfor II = 1:numsims
    %if mod(II,5)+1 == cluster_number %cluster_number is the cluster ID used (2 clusters give cluster IDs 1 and 2)
    ii = mod(II,length(Ivals))+1;
    bb = ceil(II/length(Ivals));
    
    display(['Starting Sim: ',num2str(II),' of ',num2str(numsims)])
    %ii
    %nn 
    
    %Set Current and adaptation value

    inloopPopParams = PopParamsAnalysis;
    inloopPopParams.I_e       = Ivals(ii);
    inloopPopParams.b         = bvals(bb);
    %inloopPopParams.sigma = sigvals(nn);
    
    %Run Simulation
    tic
    SimValuesArray = AdLIFfunction_iSTDP(inloopPopParams,TimeParams,'cellout',true,...
        'showprogress',true,'showfig',true,'save_weights',TimeParams.SimTime,...
        'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false,...
        'recordInterval',[(0:RecordTime:RecordTime) + (TimeParams.SimTime - RecordTime)]');
    
    spikes{II} = SimValuesArray.spikes;
    
    switch whichnet
        case 'Uniform'
    simname = ['Input',round(num2str(Ivals(ii))),'_Adapt',round(num2str(bvals(bb)))];
        case 'LogN'
    simname = ['LogN_Input',round(num2str(Ivals(ii))),'_Adapt',round(num2str(bvals(bb)))];
 
    end
    NiceSave('SimFig',figfolder,simname,'figtype','jpg')
    
    
    %end
end


try
save(fullfile(savedatafolder,savefilename),'spikes','Ivals','bvals',...
    'SimTime','-v7.3')
catch
    
    save(fullfile(figfolder,savefilename),'spikes','Ivals','bvals',...
        'SimTime','-v7.3')

end
% display('Saving')
% for II = 1:(length(Ivals)*length(sigvals))
%     %if mod(II,5)+1 == cluster_number %cluster_number is the cluster ID used (2 clusters give cluster IDs 1 and 2)
%     ii = mod(II,length(Ivals))+1;
%     nn = ceil(II/length(Ivals))
%     save(fullfile(savedatafolder,['NoiseVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(nn) '.mat']),'spikes','-v7.3') 
% end

%%
load(fullfile(figfolder,savefilename))

%%
numsims = (length(Ivals)*length(bvals));
for II = 1:numsims
    ii = mod(II,length(Ivals))+1;
    nn = ceil(II/length(Ivals));
    bz_Counter(II,numsims,'DOWN Detection')
    % Detect UP/DOWN states
    switch whichnet
        case 'Uniform'
    simname = ['Input',round(num2str(Ivals(ii))),'_Adapt',round(num2str(bvals(nn)))];
        case 'LogN'
    simname = ['LogN_Input',round(num2str(Ivals(ii))),'_Adapt',round(num2str(bvals(nn)))];
 
    end
    close all
    UPDOWNstuff(ii,nn) = DOWNdetection( spikes{II},'simdur',SimTime,...
        'SHOWFIG',simname,'savefolder',figfolder );
    
    %Fraction of time DOWN
    UPDOWNstats.pDOWN(ii,nn) = sum(UPDOWNstuff(ii,nn).dur.DOWN)./sum(UPDOWNstuff(ii,nn).dur.UP);
    %Duraiton of DOWN
    UPDOWNstats.durDOWN(ii,nn) = mean(UPDOWNstuff(ii,nn).dur.DOWN);
    UPDOWNstats.CVDOWN(ii,nn) = std(UPDOWNstuff(ii,nn).dur.DOWN)./mean(UPDOWNstuff(ii,nn).dur.DOWN);
    %Mean Rate of UP
    UPDOWNstats.UPrate(ii,nn) = mean(UPDOWNstuff(ii,nn).UPrate);
    %Duration of UP
    UPDOWNstats.durUP(ii,nn) = mean(UPDOWNstuff(ii,nn).dur.UP);
    UPDOWNstats.CVUP(ii,nn) = std(UPDOWNstuff(ii,nn).dur.UP)./mean(UPDOWNstuff(ii,nn).dur.UP);
    
end

%%
figure
subplot(3,3,1)
imagesc(Ivals,log10(bvals),log10(UPDOWNstats.pDOWN)')
colorbar
caxis([-2 2])
axis xy
LogScale('y',10)
title('UP/DOWN Ratio')
xlabel('Input');ylabel('Adaptation')

subplot(3,3,4)
imagesc(Ivals,log10(bvals),log10(UPDOWNstats.durUP)');
alpha(single(~isnan(UPDOWNstats.durUP))')
colorbar
LogScale('c',10)
LogScale('y',10)
axis xy
title('Mean UP Duration')
xlabel('Input');ylabel('Adaptation')

subplot(3,3,2)
imagesc(Ivals,log10(bvals),(UPDOWNstats.UPrate)');
alpha(single(~isnan(UPDOWNstats.durUP))')
colorbar
%LogScale('c',10)
caxis([0 50])
axis xy
LogScale('y',10)
title('Mean UP Rate')
xlabel('Input');ylabel('Adaptation')

subplot(3,3,5)
a = imagesc(Ivals,log10(bvals),log10(UPDOWNstats.durDOWN)');
alpha(single(~isnan(UPDOWNstats.durDOWN))')
colorbar
LogScale('c',10)
axis xy
LogScale('y',10)
title('Mean DOWN Duration')
xlabel('Input');ylabel('Adaptation')

subplot(3,3,7)
a = imagesc(Ivals,log10(bvals),(UPDOWNstats.CVUP)');
alpha(single(~isnan(UPDOWNstats.durUP))')
colorbar
caxis([0.2 1.2])
%LogScale('c',10)
axis xy
LogScale('y',10)
title('CV UP Duration')
xlabel('Input');ylabel('Adaptation')

subplot(3,3,8)
a = imagesc(Ivals,log10(bvals),(UPDOWNstats.CVDOWN)');
alpha(single(~isnan(UPDOWNstats.durDOWN))')
colorbar
caxis([0.2 1.2])
%LogScale('c',10)
axis xy
LogScale('y',10)
title('CV DOWN Duration')
xlabel('Input');ylabel('Adaptation')

NiceSave('InputAdaptMap',figfolder,whichnet,'figtype','pdf')