function CondAdLIF_iSTDP_Adaptation_Current()

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

PopParams_in.t_syn = 0;

PopParams_in.V0 = SimValuesTest.V(:,end);
PopParams_in.w0 = SimValuesTest.w(:,end);
PopParams_in.s0 = SimValuesTest.s(:,end);

TimeParams.dt      = 0.05;
TimeParams.SimTime = 1e4;

Ivals = linspace(150,300,20);
bvals = 10.^(-2:0.5:4);

%% Set Indices

Iindex = 1:length(Ivals);
bindex = 1:length(bvals);

I_indices = zeros(1,5);
b_indices = zeros(1,5);

ii = find(Iindex == 4);
bb = find(bindex == 4);

I_indices(1) = ii;
b_indices(1) = bb;

ii = find(Iindex == 8);
bb = find(bindex == 4);

I_indices(2) = ii;
b_indices(2) = bb;

ii = find(Iindex == 8);
bb = find(bindex == 8);

I_indices(3) = ii;
b_indices(3) = bb;

ii = find(Iindex == 10);
bb = find(bindex == 7);

I_indices(4) = ii;
b_indices(4) = bb;

ii = find(Iindex == 18);
bb = find(bindex == 9);

I_indices(5) = ii;
b_indices(5) = bb;

ii = find(Iindex == 6);
bb = find(bindex == 12);

I_indices(6) = ii;
b_indices(6) = bb;

ii = find(Iindex == 10);
bb = find(bindex == 13);

I_indices(7) = ii;
b_indices(7) = bb;

ii = find(Iindex == 19);
bb = find(bindex == 13);

I_indices(8) = ii;
b_indices(8) = bb;

%% Run loop
for II = 1:8
    ii = I_indices(II);
    bb = b_indices(II);

    ii
    bb 

    PopParamsAnalysis = PopParams_in;

    I_e = Ivals(ii);
    b = bvals(bb);

    PopParamsAnalysis.I_e       = I_e;
    PopParamsAnalysis.gwnorm    = b;

    SimValuesArray = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
        'save_weights',TimeParams.SimTime,'save_dt',10,'useGPU',false,'defaultNeuronParams',false);

    save(['/scratch/jmg1030/FIcurve/data/testingFolder/8-17-2019/AdaptationVCurrent/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'],'-struct','SimValuesArray','-v7.3') 
end

end