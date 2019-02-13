%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/spikingModel/SOSpikingModel';
addpath(genpath(repopath))

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
PopParams.tau_w   = 1000;     %subthreshold adaptation steepness
PopParams.gwnorm  = PopParams.g_L(1);       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 0;        %E->E weight (nS)
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degree

TimeParams.dt      = 0.05;

%%
SimTime = 3e3;

PopParams.I_e = @(t) (250 - Ivals(ii)).*heaviside(1000 - t)+Ivals(ii);

TimeParams.SimTime = SimTime;

%%

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

%%

Ivals = linspace(0,400,21);

parfor ii = 1:length(Ivals)
   
PopParamsAnalysis = PopParams;
PopParamsAnalysis.I_e = @(t) (250 - Ivals(ii)).*heaviside(1000 - t)+Ivals(ii);

SimValuesArray(ii) = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',1,'save_weights',TimeParams.SimTime);

end

for ii = 1:length(Ivals)

    spikes = SimValuesArray(ii).spikes;
    save(['/home/jmg1030/Documents/spikingModel/data/sUniform_w_0_FI_ii_' char(num2str(ii)) '_spikes.mat'],'spikes','-v7.3');

end
