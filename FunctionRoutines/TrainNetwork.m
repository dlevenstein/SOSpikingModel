function [SimValues,PopParams_in] = TrainNetwork(PopParams,varargin)

%TrainNetwork Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS                
%   SimValues       Simulation values after a trained simulation
%   PopParams_in    population parameters structure to pass through to the
%                   simulation function

%% Default Parameters
defaulttimeparms.dt         = 0.05; %ms, time step
defaulttimeparms.SimTime    = 3.6e6; %ms, time to simulate
defaulttimeparms.RecordTime = 1e4; %ms, time of recorded values before and after training

defaultinputparms.I_e       = 250;  %pA, mean input current
defaultinputparms.sigma     = 50;   %pA, noise of input current
defaultinputparms.theta     = 1/10; %time filtration of noise

defaultlearningparms.LearningRate   = 1e-2; %learning rate
defaultlearningparms.TargetRateE    = 2;    %Hz, excitatory target rate
defaultlearningparms.TargetRateI    = nan;  %Hz, inhibitory target rate
defaultlearningparms.tauSTDP        = 20;   %ms, STDP curve

p = inputParser;
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
addParameter(p,'inputparms',defaultinputparms,@isstruct)
addParameter(p,'learningparms',defaultlearningparms,@isstruct)
addParameter(p,'showfig',false,@islogical)
parse(p,varargin{:})

timeparms       = p.Results.timeparms;
inputparms      = p.Results.inputparms;
learningparms   = p.Results.learningparms;
SHOWFIG         = p.Results.showfig;

%% Transfer values for Training

PopParams_in = PopParams;

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
PopParams_in.W = PopParams.W;

%% Times
SimTime         = timeparms.SimTime;
RecordTime      = timeparms.RecordTime;

TimeParams.dt           = timeparms.dt;
TimeParams.RecordTime   = RecordTime;
TimeParams.SimTime      = SimTime+RecordTime;

%% Simulation

SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',5e2,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime],'train',true,'useGPU',true);

SimValues.PopParams = PopParams_in;
SimValues.TimeParams = TimeParams;

if SHOWFIG
    makeTrainingFigure(SimValues);
end
    
end