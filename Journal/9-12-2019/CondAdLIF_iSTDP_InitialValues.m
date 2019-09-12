function CondAdLIF_iSTDP_InitialValues()

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%

load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat');

%%
clear PopParams

PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.I_e  = 0;       %External input
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

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
PopParams.tau_w   = 300;     %subthreshold adaptation steepness
PopParams.gwnorm  = 0;       %magnitude of adaptation

PopParams.t_syn = 0;

PopParams.LearningRate = 0;
PopParams.TargetRateI = nan; %Target E rate 1Hz
PopParams.TargetRateE = nan; %Target I rate 1Hz
PopParams.tauSTDP = 20;

%%

PopParams_in = PopParams;
PopParams_in.tau_w = 300;
PopParams_in.LearningRate = 0;
PopParams_in.sigma = 10;
PopParams_in.W = SimValues.WeightMat(:,:,end);
PopParams_in.t_syn = 0;

PopParams_in.V0 = min(PopParams_in.E_L) + (min(PopParams_in.V_th)-min(PopParams_in.E_L)).*rand(PopParams_in.EPopNum + PopParams_in.IPopNum,1);

TimeParams.dt      = 0.05;
TimeParams.SimTime = 3e4;

PopParams_in.I_e = 250;
PopParams_in.gwnorm = 0;

SimValuesTest = AdLIFfunction_iSTDP(PopParams_in,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',TimeParams.SimTime,'save_dt',1,'useGPU',true,'defaultNeuronParams',false);

save('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250_initial_values.mat','SimValuesTest','-v7.3') 

end