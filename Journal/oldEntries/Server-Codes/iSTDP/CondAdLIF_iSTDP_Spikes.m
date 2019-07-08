function CondAdLIF_iSTDP_Spikes(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
%repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%
if index == 1
    
    filename = '/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat';
    savefilename = '/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250_Spikes.mat';
    disp('L(1,10),Plastic I->E (Uniform Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 10 ms, 50 pA')
    load(filename);
    
    PopParams = SimValues.PopParams;
    
    PopParams.W = SimValues.WeightMat(:,:,end);
    
    PopParams.I_e  = 250;       %External input
    PopParams.sigma = 0;        %niose magnitude: variance
    PopParams.theta = 1/10;        %noise time scale (1/ms)

    PopParams.LearningRate = 0;
    PopParams.TargetRateI = nan; %Target I rate 8Hz
    %PopParams.TargetRateE = nan; %Target E rate 2Hz
    PopParams.tauSTDP = 20;
    
    PopParams
    
    %CreateSimulationFigure(PopParams)
    
elseif index == 2
    
    filename = '/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat';
    savefilename = '/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250_Spikes.mat';
    disp('L(1,10),Plastic I->E (Lognormal Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 10 ms, 50 pA')
    load(filename);
    
    PopParams = SimValues.PopParams;
    
    PopParams.W = SimValues.WeightMat(:,:,end);
    
    PopParams.I_e  = 250;       %External input
    PopParams.sigma = 0;        %niose magnitude: variance
    PopParams.theta = 1/10;        %noise time scale (1/ms)

    PopParams.LearningRate = 0;
    PopParams.TargetRateI = nan; %Target I rate 8Hz
    %PopParams.TargetRateE = nan; %Target E rate 2Hz
    PopParams.tauSTDP = 20;
    
    PopParams

    %CreateSimulationFigure(PopParams)
    
end

%%
SimTime = 5e4;

TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime;

%%
SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,'train',false,'useGPU',false);

SimValues.PopParams = PopParams;

%%
save(savefilename,'SimValues','-v7.3')

end