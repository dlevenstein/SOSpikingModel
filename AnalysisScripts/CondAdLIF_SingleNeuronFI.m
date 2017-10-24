%A script for analysis of single neuron input-output properties in the
%Conductance-based adapting LIF model
%DLevenstein and JGornet

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository
repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = repopath

%% Define the Population Parameters to feed the FI Cuve function

%Input Noise
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 1;

%Neuron properties
PopParams.E_L     = -65;    %rev potential: leak (mV)
PopParams.g_L     = 30;     %leak conductance (nS?)
PopParams.C       = 281;    %capacitanve (pF?)
PopParams.V_th    = -55;    %spike threshold (mV)
PopParams.V_reset = -85;    %reset potential (mV)
PopParams.t_ref   = 0.2;    %refractory period (ms)

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.b_s     = 1;      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
PopParams.a       = 0.5;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
PopParams.b       = 0.1;    %adaptation activation rate (1/ms)
PopParams.delta_T = 10;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 0;        %E->E weight
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 0;        %Expected E->E In Degree
PopParams.Kii   = 0;        %Expected I->I In Degree
PopParams.Kie   = 0;        %Expected E->I In Degree
PopParams.Kei   = 0;        %Expected I->E In Degree



%% Run the FI Curve function
simfunction = @EMAdLIFfunction;
Irange = [150 450];
numI = 26;
[ Ivals,rate ] = SimulateFICurve(simfunction,PopParams,Irange,numI);