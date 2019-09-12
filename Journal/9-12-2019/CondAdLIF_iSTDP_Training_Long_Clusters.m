function CondAdLIF_iSTDP_Training_Long_Clusters(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
%repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%

rng(1,'twister');

%%

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degrees

PopParams.Wee   = 1;        %Expected E->E In Degree
PopParams.Wii   = 1;        %Expected I->I In Degree
PopParams.Wie   = 1;        %Expected E->I In Degree
PopParams.Wei   = 1;        %Expected I->E In Degrees

PopParams.m = 1;
PopParams.s = 10;

%% Noise

PopParams.I_e  = 250;       %External input
PopParams.sigma = 50;        %niose magnitude: variance
PopParams.theta = 1/10;        %noise time scale (1/ms)

PopParams.numClusters = 25;
PopParams.ClusterK = (2.5/(1920/79))*(250/(2.5/(1920/79)+1));
PopParams.CrossClusterK = (250/(2.5/(1920/79)+1));

%%
if index == 1
    
    %% Weights

    [W,PopParams] = CreateNetwork(PopParams,'EE_type','lognormal','CreateClusters',true);
    
    PopParams.LearningRate = 1e-2;
    PopParams.TargetRateI = nan; %Target I rate 8Hz
    PopParams.TargetRateE = 2; %Target E rate 2Hz
    PopParams.tauSTDP = 20;
    
    filename = 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250_Clusters';

    disp('L(1,10),Plastic I->E (Uniform Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 10 ms, 50 pA, Clusters')

    PopParams
    
    CreateSimulationFigure(PopParams)
    
elseif index == 2
    
    %% Weights

    [W,PopParams] = CreateNetwork(PopParams,'EE_type','lognormal','CreateClusters',true);
    
    numcells = 2000;
 
    mTR = -0.1
    sigmaTR = 0.8

    %draw the log firing rates from a normal distribution with mean mTR and std sigmaTR
    logTRs = mTR + sigmaTR.*(randn(numcells,1));  
    TRs = exp(logTRs); %convert log rate to rate
    TRs = sort(TRs); %sort the target rates so the neurons will be sorted by target rate
    meanTR = mean(TRs) %mean target rate. units: Hz!

    PopParams.LearningRate = 1e-2;
    PopParams.TargetRateI = nan; %Target I rate 8Hz
    PopParams.TargetRateE = TRs; %Target E rate 2Hz
    PopParams.tauSTDP = 20;
    
    filename = 'Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250_Clusters';

    disp('L(1,10),Plastic I->E (Lognormal Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 10 ms, 50 pA, Clusters')

    PopParams
    
    CreateSimulationFigure(PopParams)
    
end

%%
SimTime = 3.6e6;
RecordTime = 1e4;

TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime+RecordTime;

%%
SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',5e2,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime],'train',true,'useGPU',false);

SimValues.PopParams = PopParams;

%%
%disp(['/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/' filename])
save(['/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/' filename],'SimValues','-v7.3')
%save(['/home/jmg1030/Documents/spikingModel/data/iSTDPTrainedWeights/iSTDPTrainedWeights/' filename],'SimValues','-v7.3')

end