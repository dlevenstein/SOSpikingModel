function CondAdLIF_STDP_GPU_Analysis()

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';
%repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

%Input
PopParams.I_e  = 250;       %External input
PopParams.sigma = 0;        %niose magnitude: variance
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
PopParams.a       = 0;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.tau_w   = 100;     %subthreshold adaptation steepness
PopParams.gwnorm  = 1;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 1;        %E->E weight (nS)
PopParams.Wii   = 1;        %I->I weight
PopParams.Wie   = 1;        %E->I weight
PopParams.Wei   = 1;        %I->E weight
PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degree

TimeParams.dt      = 0.05;

%%
SimTime = 1e4;

TimeParams.SimTime = SimTime;

%%

PopParams.LearningRate = 1e-2;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

%%
rng(1,'twister');

PopParams.V0 = min(PopParams.E_L) + (min(PopParams.V_th)-min(PopParams.E_L)).*rand(PopParams.EPopNum + PopParams.IPopNum,1);

%%

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',100,'save_dt',1);

save('/home/jmg1030/Documents/Networks/GPUAnalysis/CPUSimValues.mat','-struct','SimValues','-v7.3')

SimValues = AdLIFfunction_STDP_GPU(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',100,'save_dt',1);

save('/home/jmg1030/Documents/Networks/GPUAnalysis/GPUSimValues.mat','-struct','SimValues','-v7.3')

end