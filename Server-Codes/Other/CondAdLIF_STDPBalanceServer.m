function CondAdLIF_STDPBalanceServer(llrr)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';
repopath = '/home/jmg1030/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

%Input
PopParams.I_e  = 250;       %External input
PopParams.sigma = 50;        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1000;
PopParams.IPopNum = 250;

%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-55 -55];    %reset potential (mV)
PopParams.t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.tau_s   = [5 5];      %synaptic decay timescale (1/ms)

%Adaptation Properties (No adaptation)
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 3;        %E->E weight (nS)
PopParams.Wii   = 3;        %I->I weight
PopParams.Wie   = 3;        %E->I weight
PopParams.Wei   = 2;        %I->E weight
PopParams.Kee   = 100;        %Expected E->E In Degree
PopParams.Kii   = 100;        %Expected I->I In Degree
PopParams.Kie   = 100;        %Expected E->I In Degree
PopParams.Kei   = 100;        %Expected I->E In Degree

TimeParams.dt      = 0.05;

close all

%PopParams.p0spike = 0.1; %Proportion of neurons spiking in the beginning of the simulation

%%

TimeParams.SimTime = 1e6 + 1e4;
%STDP Properties

LearningRates = [1e-2 1e-1];
LearningRateNames = ["1e-2", "1e-1"];

%%

PopParams.LearningRate = LearningRates(llrr);
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

tic
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',1e4,'save_dt',1e5,...
    'recordInterval',[0:2e5:1e6;(0:2e5:1e6) + 1e4]);
toc

if SAVESIM==true
    save(['/scratch/jmg1030/longinhSTDP_fastrate-' char(LearningRateNames(llrr))],'-v7.3')
end

end