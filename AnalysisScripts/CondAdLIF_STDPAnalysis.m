addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/RunCodes')
addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/FunctionRoutines')
addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/MiscUtilities')

%% Example Neuron Properties

%Input 
PopParams.I_e  = 500;
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 10;
PopParams.IPopNum = 10;


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
PopParams.tau_s     = [2 2];      %synaptic decay timescale (1/ms)
PopParams.a       = 10;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 10;        %E->E weight
PopParams.Wii   = 10;        %I->I weight
PopParams.Wie   = 10;        %E->I weight
PopParams.Wei   = 10;        %I->E weight
PopParams.Kee   = 5;        %Expected E->E In Degree
PopParams.Kii   = 5;        %Expected I->I In Degree
PopParams.Kie   = 5;        %Expected E->I In Degree
PopParams.Kei   = 5;        %Expected I->E In Degree

%STDP Properties

PopParams.EELearningRate = 1;
PopParams.IILearningRate = 1;
PopParams.IELearningRate = 1;
PopParams.EILearningRate = 1;

PopParams.EEtau = 1;
PopParams.IItau = 1;
PopParams.IEtau = 0.1;
PopParams.EItau = 0.1;

%% Noise Input Properties
TimeParams.dt      = 0.05;
TimeParams.SimTime = 500;

%%

close all
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true)
