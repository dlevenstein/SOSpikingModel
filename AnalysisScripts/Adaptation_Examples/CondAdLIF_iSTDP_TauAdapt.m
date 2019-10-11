function CondAdLIF_iSTDP_TauAdapt(repopath,whichnet)

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
whichnet = 'Uniform';
addpath(genpath(repopath))


figfolder = fullfile(repopath,'Figures','TauAdaptation');
savedatafolder = fullfile(repopath,'SimData');
%% Set Cluster Number
%numClusters = 5; %This is if you have 5 clusters, so cluster_number inputs are 1-5 

%% Load Scripts Here 

netfolder = fullfile(repopath,'TrainedNets/');

switch whichnet
    case 'Uniform'
        load([netfolder 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat']);
        savefilename = 'SubAdaptationVCurrentSpikes.mat';
% load([netfolder 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250_starting_values.mat']);
    case 'LogN'
        savefilename = 'LogN_SubAdaptationVCurrentSpikes.mat';
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
%PopParams.tau_w   = 300;            %adaptation decay (ms)
PopParams.gwnorm  = 0;              %magnitude of adaptation

PopParams.t_syn = 0;                %Synaptic Delay

PopParams.LearningRate = 0;
PopParams.TargetRateI = nan; %Target E rate nan Hz (Turns off plasticity)
PopParams.TargetRateE = nan; %Target I rate nan Hz (Turns off plasticity)
PopParams.tauSTDP = 20;

%% Adaptation and Noise Parameters 

PopParamsAnalysis              = PopParams;
PopParamsAnalysis.LearningRate = 0;                      %Learning rate
%PopParamsAnalysis.tau_w        = 1000;    %300                %adaptation decay (ms)
PopParamsAnalysis.sigma        = 100;     %100               %Noise variance (pA) (Set to Covariance Matrix to add covariance
PopParamsAnalysis.W            = SimValues.WeightMat(:,:,end); %Synaptic Weights
PopParamsAnalysis.gwnorm       = 1;                      %Adaptation norm
PopParamsAnalysis.t_syn        = rand(PopParams.EPopNum+PopParams.IPopNum,1)*0.4+0.05;                      %Synaptic Delay (ms)
PopParamsAnalysis.I_e          = 100;
PopParamsAnalysis.a            = 0.1;
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
RecordTime = 1e3;                       %Recording Time (end of simulation)
SimTime  = UnRecordedTime+RecordTime;   %Total Simulation time

TimeParams.SimTime = SimTime;

%Ivals = linspace(0,75,16); %Current Values (pA)
%sigvals = linspace(0,100,11);
%avals = 10.^(-4:0.5:-1);       %spike-based Adaptation values (nS)
%avals = [0 10.^(-4:0.5:-1)];  %subthreshold-based Adaptation values (nS)
%taus = 100:100:2000;
taus = [100 1000];
%% Set up for parallel in cluster
pc = parcluster('local');
% store temporary files in the 'scratch' drive on the cluster, labeled by job ID
pc.JobStorageLocation = strcat(getenv('SCRATCH'), '/', getenv('SLURM_JOB_ID'));
% enable MATLAB to utilize the multiple cores allocated in the job script
% SLURM_NTASKS_PER_NODE is a variable set in the job script by the flag --tasks-per-node
% we use SLURM_NTASKS_PER_NODE - 1, because one of these tasks is the original MATLAB script itself
parpool(pc, str2num(getenv('SLURM_NTASKS_PER_NODE'))-1);

%% Loop 

spikes = cell(length(taus));
numsims = (length(taus));
%Once running: parfor on cluster.
for II = 1:numsims
    %%
    %if mod(II,5)+1 == cluster_number %cluster_number is the cluster ID used (2 clusters give cluster IDs 1 and 2)
    %ii = mod(II,length(Ivals))+1;
    %bb = ceil(II/length(Ivals));
    
    display(['Starting Sim: ',num2str(II),' of ',num2str(numsims)])
    %ii
    %nn 
    %%
    %ii=5;bb=3;
    %Set Current and adaptation value

    inloopPopParams = PopParamsAnalysis;
    inloopPopParams.tau_w       = taus(II);
    %inloopPopParams.sigma = sigvals(nn);
    save_dt = TimeParams.SimTime;
    save_dt = 5;
    %Run Simulation
    tic
    SimValuesArray = AdLIFfunction_iSTDP(inloopPopParams,TimeParams,'cellout',true,...
        'showprogress',true,'showfig',true,'save_weights',TimeParams.SimTime,...
        'save_dt',save_dt,'useGPU',false,'defaultNeuronParams',false,...
        'recordInterval',[(0:RecordTime:RecordTime) + (TimeParams.SimTime - RecordTime)]');
    %%
    spikes{II} = SimValuesArray.spikes;
    
    switch whichnet
        case 'Uniform'
    simname = ['Tau',round(num2str(taus(II)))];
        case 'LogN'
    simname = ['LogN_Tau',round(num2str(taus(II)))];
 
    end
   % NiceSave('SimFig',figfolder,simname,'figtype','jpg')
    
    
    %end
end
%%

% try
% save(fullfile(savedatafolder,savefilename),'spikes','taus',...
%     'SimTime','PopParamsAnalysis','-v7.3')
% catch
    
    save(fullfile(figfolder,savefilename),'spikes','taus',...
        'SimTime','PopParamsAnalysis','-v7.3')

%end
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
numsims = (length(taus));
for II = 1:numsims
%     ii = mod(II,length(Ivals))+1;
%     nn = ceil(II/length(Ivals));
    bz_Counter(II,numsims,'DOWN Detection')
    % Detect UP/DOWN states
    switch whichnet
        case 'Uniform'
    simname = ['Tau',round(num2str(taus(II)))];
        case 'LogN'
    simname = ['LogN_Tau',round(num2str(taus(II)))];
 
    end
    close all
    [UD,RH,DH] = DOWNdetection( spikes{II},'simdur',SimTime,...
        'SHOWFIG',simname,'savefolder',figfolder );
    UPDOWNstuff(II) = UD;
    ratehist(II) = RH;
    durhist(II) = DH;
    %Fraction of time DOWN
    UPDOWNstats.pDOWN(II) = sum(UPDOWNstuff(II).dur.DOWN)./sum(UPDOWNstuff(II).dur.UP);
    %Duraiton of DOWN
    UPDOWNstats.durDOWN(II) = mean(UPDOWNstuff(II).dur.DOWN);
    UPDOWNstats.CVDOWN(II) = std(UPDOWNstuff(II).dur.DOWN)./mean(UPDOWNstuff(II).dur.DOWN);
    %Mean Rate of UP
    UPDOWNstats.UPrate(II) = mean(UPDOWNstuff(II).UPrate);
    %Duration of UP
    UPDOWNstats.durUP(II) = mean(UPDOWNstuff(II).dur.UP);
    UPDOWNstats.CVUP(II) = std(UPDOWNstuff(II).dur.UP)./mean(UPDOWNstuff(II).dur.UP);
    UPDOWNstats.diptest(II) = ratehist(II).diptest.dip;
    UPDOWNstats.dipP(II) = ratehist(II).diptest.p_value;
end

%%

FI.rates = bz_CollapseStruct(ratehist,1);
FI.durs = bz_CollapseStruct(durhist,1);


%%
bb = 1
figure
    thisB = PopParamsAnalysis.a ;
    
    subplot(4,3,(bb-1)*3+1)
        imagesc(taus,FI.rates.linbins(1,:),FI.rates.linhist')
        alpha(single(FI.rates.linhist'>050)) %ms threshold of time in bin
        nonzero = (FI.rates.linhist(:,2:end));
        caxis([0 max(nonzero(:))])
        axis xy
        xlabel('Tau_w (ms)')
        %crameri bilbao
        ylabel({['b = ',num2str(thisB)],'Pop Rate (Hz)'})
        
    subplot(4,3,(bb-1)*3+2)
        imagesc(taus,FI.durs.bins(1,:),FI.durs.DOWN')
        alpha(single(FI.durs.DOWN'~=0 & ~isnan(FI.durs.DOWN'))) %ms threshold of time in bin
        %nonzero = (FI.linhist(:,2:end));
        %caxis([0 max(nonzero(:))])
        axis xy
        xlabel('Tau_w (ms)')
        LogScale('y',10)
        %crameri bilbao
        ylabel('DOWN Dur (ms)')
        
    subplot(4,3,(bb-1)*3+3)
        imagesc(taus,FI.durs.bins(1,:),FI.durs.UP')
        alpha(single(FI.durs.UP'~=0)) %ms threshold of time in bin
        %nonzero = (FI.linhist(:,2:end));
        %caxis([0 max(nonzero(:))])
        axis xy
        xlabel('Tau_w (ms)')
        LogScale('y',10)
        %crameri bilbao
        ylabel('UP Dur (ms)')
        

NiceSave('FICurves',figfolder,whichnet,'figtype','pdf')
%%
% figure
% subplot(3,3,1)
% imagesc(Ivals,log10(avals),log10(UPDOWNstats.pDOWN)')
% colorbar
% caxis([-2 2])
% axis xy
% LogScale('y',10)
% title('UP/DOWN Ratio')
% xlabel('Input');ylabel('Adaptation')
% 
% subplot(3,3,4)
% imagesc(Ivals,log10(avals),log10(UPDOWNstats.durUP)');
% alpha(single(~isnan(UPDOWNstats.durUP))')
% colorbar
% LogScale('c',10)
% LogScale('y',10)
% axis xy
% title('Mean UP Duration')
% xlabel('Input');ylabel('Adaptation')
% 
% subplot(3,3,2)
% imagesc(Ivals,log10(avals),(UPDOWNstats.UPrate)');
% alpha(single(~isnan(UPDOWNstats.durUP))')
% colorbar
% %LogScale('c',10)
% caxis([0 50])
% axis xy
% LogScale('y',10)
% title('Mean UP Rate')
% xlabel('Input');ylabel('Adaptation')
% 
% subplot(3,3,3)
% imagesc(Ivals,log10(avals),(UPDOWNstats.diptest)');
% %alpha(single(~isnan(UPDOWNstats.durUP))')
% colorbar
% %LogScale('c',10)
% %caxis([0 50])
% axis xy
% LogScale('y',10)
% title('Dip Test (bimodality)')
% xlabel('Input');ylabel('Adaptation')
% 
% % subplot(3,3,6)
% % imagesc(Ivals,log10(avals),(UPDOWNstats.dipP<0.05)');
% % %alpha(single(~isnan(UPDOWNstats.durUP))')
% % colorbar
% % %LogScale('c',10)
% % %caxis([0 50])
% % axis xy
% % LogScale('y',10)
% % title('Dip Test (pval)')
% % xlabel('Input');ylabel('Adaptation')
% 
% subplot(3,3,5)
% a = imagesc(Ivals,log10(avals),log10(UPDOWNstats.durDOWN)');
% alpha(single(~isnan(UPDOWNstats.durDOWN))')
% colorbar
% LogScale('c',10)
% axis xy
% LogScale('y',10)
% title('Mean DOWN Duration')
% xlabel('Input');ylabel('Adaptation')
% 
% subplot(3,3,7)
% a = imagesc(Ivals,log10(avals),(UPDOWNstats.CVUP)');
% alpha(single(~isnan(UPDOWNstats.durUP)&~isnan(UPDOWNstats.durDOWN))')
% colorbar
% caxis([0.2 1.2])
% crameri('berlin','pivot',1)
% %LogScale('c',10)
% axis xy
% LogScale('y',10)
% title('CV UP Duration')
% xlabel('Input');ylabel('Adaptation')
% 
% subplot(3,3,8)
% a = imagesc(Ivals,log10(avals),(UPDOWNstats.CVDOWN)');
% alpha(single(~isnan(UPDOWNstats.durDOWN))')
% colorbar
% caxis([0.2 1.2])
% crameri('berlin','pivot',1)
% %LogScale('c',10)
% axis xy
% LogScale('y',10)
% title('CV DOWN Duration')
% xlabel('Input');ylabel('Adaptation')
% 
% NiceSave('InputAdaptMap',figfolder,whichnet,'figtype','pdf')