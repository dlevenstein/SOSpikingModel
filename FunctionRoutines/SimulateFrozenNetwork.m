function [SimValuesTest,PopParams_in] = SimulateFrozenNetwork(SimValues,PopParams_in)

%SimulateFrozenNetwork Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS                
%   SimValues       Simulation values after a trained simulation
%   PopParams_in    population parameters structure to pass through to the
%                   simulation function

%% Default Parameters
defaulttimeparms.dt         = 0.05; %ms, time step
defaulttimeparms.SimTime    = 1e4; %ms, time to simulate

defaultinputparms.I_e       = 250;  %pA, mean input current
defaultinputparms.sigma     = 0;   %pA, noise of input current
defaultinputparms.theta     = 0; %time filtration of noise

defaultlearningparms.LearningRate   = 0; %learning rate
defaultlearningparms.TargetRateE    = nan;    %Hz, excitatory target rate
defaultlearningparms.TargetRateI    = nan;  %Hz, inhibitory target rate
defaultlearningparms.tauSTDP        = 20;   %ms, STDP curve

p = inputParser;
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
addParameter(p,'inputparms',defaultinputparms,@isstruct)
addParameter(p,'learningparms',defaultlearningparms,@isstruct)
parse(p,varargin{:})

timeparms       = p.Results.timeparms;
inputparms      = p.Results.inputparms;
learningparms   = p.Results.learningparms;

%% Learning
PopParams_in.LearningRate   = learningparms.LearningRate;
PopParams_in.TargetRateE    = learningparms.TargetRateE; %Target E rate 2Hz
PopParams_in.TargetRateI    = learningparms.TargetRateI; %Target I rate 8Hz
PopParams_in.tauSTDP        = learningparms.tauSTDP;

%% Noise
PopParams_in.I_e    = inputparms.I_e;       %External input
PopParams_in.sigma  = inputparms.sigma;        %noise magnitude: variance
PopParams_in.theta  = inputparms.theta;        %noise time scale (1/ms)

%% Weight
PopParams_in.W = SimValues.WeightMat(:,:,end);

%% Times
TimeParams.dt           = timeparms.dt;
TimeParams.SimTime      = timeparms.SimTime;

%% Simulation

SimValuesTest = AdLIFfunction_iSTDP(PopParams_in,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,'train',false,'useGPU',true);

SimValuesTest.PopParams_in = PopParams_in;

end