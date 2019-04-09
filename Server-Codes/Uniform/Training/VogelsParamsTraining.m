%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

%Input
PopParams.I_e  = 200;       %External input
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 8000;
PopParams.IPopNum = 2000;

%Neuron properties
PopParams.E_L     = -60;    %rev potential: leak (mV)
PopParams.g_L     = 10;     %leak conductance (nS)
PopParams.C       = 200;    %capacitance (pF)
PopParams.V_th    = -50;    %spike threshold (mV)
PopParams.V_reset = -60;    %reset potential (mV)
PopParams.t_ref   = 5;    %refractory period (ms)

%Synaptic Properties
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.tau_s   = [5 10];      %synaptic decay timescale (1/ms)

%Adaptation Properties (No adaptation)
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.a       = 0;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.tau_w   = 100;     %subthreshold adaptation steepness
PopParams.gwnorm  = PopParams.g_L(1);       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 3;        %E->E weight (nS)
PopParams.Wii   = 3;        %I->I weight
PopParams.Wie   = 3;        %E->I weight
PopParams.Wei   = 3;        %I->E weight
PopParams.Kee   = 160;        %Expected E->E In Degree
PopParams.Kii   = 40;        %Expected I->I In Degree
PopParams.Kie   = 160;        %Expected E->I In Degree
PopParams.Kei   = 40;        %Expected I->E In Degree

TimeParams.dt      = 0.05;

%%
SimTime = 1e5;
RecordTime = 1e4;

TimeParams.SimTime = SimTime+RecordTime;

%%

PopParams.LearningRate = 1e-4;
PopParams.TargetRate = 3; %Target E rate 1Hz
PopParams.tauSTDP = 20;

%%
SimValues = AdLIFfunction_STDP_GPU(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime]);

save('/home/jmg1030/Documents/spikingModel/data/VogelsParams','-v7.3')
