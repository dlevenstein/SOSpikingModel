function CondAdLIF_iSTDP_Adaptation_Current(modnum)

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%

load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat');
load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250_initial_values.mat');

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

PopParams_in              = PopParams;
PopParams_in.tau_w        = 300;
PopParams_in.LearningRate = 0;
PopParams_in.sigma        = 10;
PopParams_in.W            = SimValues.WeightMat(:,:,end);
PopParams_in.gwnorm       = 1;

PopParams_in.t_syn = 0;

PopParams_in.V0 = SimValuesTest.V(:,end);
PopParams_in.w0 = SimValuesTest.w(:,end);
PopParams_in.s0 = SimValuesTest.s(:,end);

TimeParams.dt      = 0.05;

SimTime = 3e4;
RecordTime = 2e4;

TimeParams.SimTime = SimTime+RecordTime;

Ivals = linspace(150,300,20);
avals = [0 10.^(-4:0.5:-1)];

%%
for II = 1:(length(Ivals)*length(avals))
    if mod(II,5)+1 == modnum
    ii = mod(II,length(Ivals))+1;
    aa = ceil(II/length(Ivals));

    ii
    aa 

    PopParamsAnalysis = PopParams_in;

    I_e = Ivals(ii);
    a = avals(aa);

    PopParamsAnalysis.I_e       = I_e;
    PopParamsAnalysis.a         = a;

    SimValuesArray = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
        'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false,...
        'recordInterval',[(0:RecordTime:RecordTime) + (TimeParams.SimTime - RecordTime)]');

    spikes = SimValuesArray.spikes;

    save(['/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/LognormalEE_UniformRates/Avals/AdaptationVCurrentSpikes_ii_' num2str(ii) '_aa_' num2str(aa) '.mat'],'spikes','-v7.3') 

    end
end

end