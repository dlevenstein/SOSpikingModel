function CondAdLIF_iSTDP_Training(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
%repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%

sVals = [0.01,0.1,1,10];
names = ["001","01","1","10"];

%%

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 500;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degrees

PopParams.Wee   = 1;        %Expected E->E In Degree
PopParams.Wii   = 1;        %Expected I->I In Degree
PopParams.Wie   = 1;        %Expected E->I In Degree
PopParams.Wei   = 1;        %Expected I->E In Degrees

PopParams.m = 1;
PopParams.s = sVals(index);

%% Noise

PopParams.I_e  = 250;       %External input
PopParams.sigma = 50;        %niose magnitude: variance
PopParams.theta = 1/10;        %noise time scale (1/ms)
    
    %% Weights

    [W,PopParams] = CreateNetwork(PopParams,'EE_type','lognormal');
    
    PopParams.LearningRate = 1e-2;
    PopParams.TargetRateI = nan; %Target I rate 8Hz
    PopParams.TargetRateE = 2; %Target E rate 2Hz
    PopParams.tauSTDP = 20;
    
    filename = 'Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA';

    disp('L(1,10),Plastic I->E (Uniform Targets), Indegree 250 E->E, 250 I->I, 500 E->I, 250 I->E, Noise 10 ms, 50 pA')

    PopParams
    
    CreateSimulationFigure(PopParams)
    
%%
SimTime = 5e5;
RecordTime = 1e4;

TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime+RecordTime;

%%
SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',5e2,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime],'train',true,'useGPU',true);

SimValues.PopParams = PopParams;

%%
save(['/scratch/jmg1030/FIcurve/data/trainedWeights/LogWeightSigmaM1/logWeight_m_1_s_' char(names(index))],'-v7.3')

end