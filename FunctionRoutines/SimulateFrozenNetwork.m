function [SimValuesTest,PopParams_in] = SimulateFrozenNetwork(SimValues,PopParams_in)

%SimulateFrozenNetwork Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS                
%   SimValues       Simulation values after a trained simulation
%   PopParams_in    population parameters structure to pass through to the
%                   simulation functionx

%% Learning
PopParams_in.LearningRate = 0;
PopParams_in.TargetRateI = nan; %Target I rate 8Hz
PopParams_in.TargetRateE = nan; %Target E rate 2Hz
PopParams_in.tauSTDP = 20;

%% Noise
PopParams_in.I_e  = 250;       %External input
PopParams_in.sigma = 0;        %niose magnitude: variance
PopParams_in.theta = 1/10;        %noise time scale (1/ms)

%% Weight
PopParams_in.W = SimValues.WeightMat(:,:,end);

%% Times
SimTime = 5e4;
TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime;

%% Simulation

SimValuesTest = AdLIFfunction_iSTDP(PopParams_in,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,'train',false,'useGPU',true);

SimValuesTest.PopParams_in = PopParams_in;

end