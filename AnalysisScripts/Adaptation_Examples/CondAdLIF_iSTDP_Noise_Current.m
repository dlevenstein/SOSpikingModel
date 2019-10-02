function CondAdLIF_iSTDP_Noise_Current(repopath)

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 

addpath(genpath(repopath))


figfolder = fullfile(repopath,'Figures','NoiseBistability');
savedatafolder = fullfile(repopath,'SimData');
%% Set Cluster Number
%numClusters = 5; %This is if you have 5 clusters, so cluster_number inputs are 1-5 

%% Load Scripts Here 

netfolder = fullfile(repopath,'TrainedNets/');

 load([netfolder 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat']);
% load([netfolder 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250_starting_values.mat']);

%load([netfolder 'Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat']);
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
PopParamsAnalysis.tau_w        = 300;                    %adaptation decay (ms)
PopParamsAnalysis.sigma        = 10;                     %Noise variance (pA) (Set to Covariance Matrix to add covariance
PopParamsAnalysis.W            = SimValues.WeightMat(:,:,end); %Synaptic Weights
PopParamsAnalysis.gwnorm       = 1;                      %Adaptation norm
PopParamsAnalysis.t_syn        = 0;%rand(PopParams.EPopNum+PopParams.IPopNum,1)*0.5;                      %Synaptic Delay (ms)

%% Note Adaptation Equation
%dwdt =  (- w + a.*(V - E_w))./tau_w; (Line 529)
%w(spikeneurons) = w(spikeneurons) + b(spikeneurons); at time of spike (Line 559)
%g_w = gwnorm.*w; (Line 648)
%% Starting Values

%PopParamsAnalysis.V0 = PopParams_in.V0;
%PopParamsAnalysis.w0 = PopParams_in.w0;
%PopParamsAnalysis.s0 = PopParams_in.s0;
PopParamsAnalysis.p0spike = 0.05;

TimeParams.dt      = 0.05;

UnRecordedTime = 0;                   %Unrecorded time
RecordTime = 0.5e3;                       %Recording Time (end of simulation)
SimTime  = UnRecordedTime+RecordTime;   %Total Simulation time

TimeParams.SimTime = SimTime;

Ivals = linspace(100,300,6); %Current Values (pA)
sigvals = linspace(0,50,6);
%bvals = 10.^(-2:0.5:4);       %spike-based Adaptation values (nS)
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

spikes = cell(length(Ivals),length(sigvals));
%Once running: parfor on cluster.
parfor II = 1:(length(Ivals)*length(sigvals))
    %if mod(II,5)+1 == cluster_number %cluster_number is the cluster ID used (2 clusters give cluster IDs 1 and 2)
    ii = mod(II,length(Ivals))+1;
    nn = ceil(II/length(Ivals));

    ii
    nn 
    
    %Set Current and adaptation value

    inloopPopParams = PopParamsAnalysis;
    inloopPopParams.I_e       = Ivals(ii);
    %PopParamsAnalysis.b         = b;
    inloopPopParams.sigma = sigvals(nn);
    
    %Run Simulation
    tic
    SimValuesArray = AdLIFfunction_iSTDP(inloopPopParams,TimeParams,'cellout',true,...
        'showprogress',true,'showfig',true,'save_weights',TimeParams.SimTime,...
        'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false,...
        'recordInterval',[(0:RecordTime:RecordTime) + (TimeParams.SimTime - RecordTime)]');
    
    spikes{II} = SimValuesArray.spikes;
    
    simname = ['Input',round(num2str(Ivals(ii))),'_Noise',round(num2str(sigvals(nn)))];
    NiceSave('SimFig',figfolder,simname,'figtype','jpg')
    
    %end
end

save(fullfile(savedatafolder,'NoiseVCurrentSpikes.mat'),'spikes','-v7.3')

% display('Saving')
% for II = 1:(length(Ivals)*length(sigvals))
%     %if mod(II,5)+1 == cluster_number %cluster_number is the cluster ID used (2 clusters give cluster IDs 1 and 2)
%     ii = mod(II,length(Ivals))+1;
%     nn = ceil(II/length(Ivals))
%     save(fullfile(savedatafolder,['NoiseVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(nn) '.mat']),'spikes','-v7.3') 
% end
end