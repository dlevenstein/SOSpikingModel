function CondAdLIF_iSTDP_PSpikeOnset()

I_e = 150;

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%savedatafolder = fullfile(repopath,'SimData');
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
PopParams.tau_w   = 500;            %adaptation decay (ms)
PopParams.gwnorm  = 0;              %magnitude of adaptation

PopParams.t_syn = 0;                %Synaptic Delay

PopParams.LearningRate = 0;
PopParams.TargetRateI = nan; %Target E rate nan Hz (Turns off plasticity)
PopParams.TargetRateE = nan; %Target I rate nan Hz (Turns off plasticity)
PopParams.tauSTDP = 20;

%% Adaptation and Noise Parameters 

PopParamsAnalysis              = PopParams;
PopParamsAnalysis.LearningRate = 0;                      %Learning rate
PopParamsAnalysis.tau_w        = 500;                    %adaptation decay (ms)
PopParamsAnalysis.sigma        = 0;                     %Noise variance (pA) (Set to Covariance Matrix to add covariance
PopParamsAnalysis.W            = SimValues.WeightMat(:,:,end); %Synaptic Weights
PopParamsAnalysis.gwnorm       = 0;                      %Adaptation norm

%% Note Adaptation Equation
%dwdt =  (- w + a.*(V - E_w))./tau_w; (Line 529)
%w(spikeneurons) = w(spikeneurons) + b(spikeneurons); at time of spike (Line 559)
%g_w = gwnorm.*w; (Line 648)
%% Starting Values

%PopParamsAnalysis.V0 = PopParams_in.V0;
%PopParamsAnalysis.w0 = PopParams_in.w0;
%PopParamsAnalysis.s0 = PopParams_in.s0;
PopParamsAnalysis.p0spike = 0.02;

TimeParams.dt      = 0.05;

UnRecordedTime = 0;                   %Unrecorded time
RecordTime = 0.25e3;                       %Recording Time (end of simulation)
SimTime  = UnRecordedTime+RecordTime;   %Total Simulation time

TimeParams.SimTime = SimTime;

%Ivals = linspace(50,250,9); %Current Values (pA)
%sigvals = linspace(0,40,9);
p0vals = linspace(0,0.2,41);
%bvals = 10.^(-2:0.5:4);       %spike-based Adaptation values (nS)
%avals = [0 10.^(-4:0.5:-1)];  %subthreshold-based Adaptation values (nS)
PopParamsAnalysis.I_e = I_e;
PopParamsAnalysis.sigma = 0;
%% Set up for parallel in cluster
pc = parcluster('local');
% store temporary files in the 'scratch' drive on the cluster, labeled by job ID
pc.JobStorageLocation = strcat(getenv('SCRATCH'), '/', getenv('SLURM_JOB_ID'));
% enable MATLAB to utilize the multiple cores allocated in the job script
% SLURM_NTASKS_PER_NODE is a variable set in the job script by the flag --tasks-per-node
% we use SLURM_NTASKS_PER_NODE - 1, because one of these tasks is the original MATLAB script itself
parpool(pc, str2num(getenv('SLURM_NTASKS_PER_NODE'))-1);

%% Loop: p0 
numsims = length(p0vals);
numrepeats = 25;
clear spikes
%spikes = cell(length(Ivals),length(sigvals));
spikes = cell(numsims,numrepeats);
%Once running: parfor on cluster.
for II = 1:numsims
    display(['Starting Sim: ',num2str(II),' of ',num2str(numsims)])
    for n = 1:numrepeats
    %if mod(II,5)+1 == cluster_number %cluster_number is the cluster ID used (2 clusters give cluster IDs 1 and 2)
    %II
    
    %ii
    %nn 
    
    %Set Current and adaptation value

    inloopPopParams = PopParamsAnalysis;
    inloopPopParams.p0spike = p0vals(II);

    
    %Run Simulation
    tic
    SimValuesArray = AdLIFfunction_iSTDP(inloopPopParams,TimeParams,'cellout',true,...
        'showprogress',false,'showfig',false,'save_weights',TimeParams.SimTime,...
        'save_dt',TimeParams.SimTime,'useGPU',true,'defaultNeuronParams',false,...
        'recordInterval',[(0:RecordTime:RecordTime) + (TimeParams.SimTime - RecordTime)]');
    
    spikes{II,n} = SimValuesArray.spikes;
    
    end
end

save('/scratch/jmg1030/FIcurve/data/testingFolder/10-13-2019/p0onsets.mat','spikes','-v7.3')

end