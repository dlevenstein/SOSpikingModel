function CondAdLIF_STDPWeightServer(w)

Weights = [0.1, 0.3, 1, 3, 10];
WeightNames = ["01","03","1","3","10"];

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';
repopath = '/scratch/jmg1030/LogWeight/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

%Input
PopParams.I_e  = 250;       %External input
PopParams.sigma = 50;        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

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
PopParams.Wee   = Weights(w);        %E->E weight (nS)
PopParams.Wii   = Weights(w);        %I->I weight
PopParams.Wie   = Weights(w);        %E->I weight
PopParams.Wei   = Weights(w);        %I->E weight
PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degree

TimeParams.dt      = 0.05;

close all

%PopParams.p0spike = 0.1; %Proportion of neurons spiking in the beginning of the simulation

%%

TimeParams.SimTime = 5e5+1e4;

%%

PopParams.LearningRate = 1e-2;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

%%
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',5e5,'save_dt',5e5,...
    'recordInterval',[0:5e5:5e5;(0:5e5:5e5) + 1e4]);

if SAVESIM==true
    save(['/scratch/jmg1030/LogWeight/largePopWeight' char(WeightNames(w))],'-v7.3')
end

end