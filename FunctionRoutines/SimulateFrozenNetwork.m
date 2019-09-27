function SimValuesTest = SimulateFrozenNetwork(SimValues)

PopParams = SimValues.PopParams;

%% Learning
PopParams.LearningRate = 0;
PopParams.TargetRateI = nan; %Target I rate 8Hz
PopParams.TargetRateE = nan; %Target E rate 2Hz
PopParams.tauSTDP = 20;

%% Noise
PopParams.I_e  = 250;       %External input
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;        %noise time scale (1/ms)

%% Weight
PopParams.W = SimValues.WeightMat(:,:,end);

%% Times
SimTime = 5e4;
TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime;

%% Simulation

SimValuesTest = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,'train',false,'useGPU',true);

SimValuesTest.PopParams = PopParams;

end