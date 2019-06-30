function [] = CondAdLIF_STDP_FI_Function_iSTDP_Reconfig(modnum)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
%repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%

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

%% Scrambled High -> Low

%load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat');
load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat');

% Scramble network weights
W = SimValues.WeightMat(:,:,end);

W_EI = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,end);
connections = find(W_EI > 0);
W_EI(connections) = W_EI(connections(randperm(length(connections))));
W(SimValues.EcellIDX,SimValues.IcellIDX) = W_EI;

for simnum = 1:100
   
if mod(simnum,5)+1 == modnum
    
mod(simnum,5)+1
modnum

rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = W;

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

%datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/LognormalEE_LognormalRates_Scrambled/';
datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/LognormalEE_UniformRates_Scrambled/';
dataname = ['Scrambled_Lognormal_m_1_s_10_EE_IE_KIE_250_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'bistability',true);

end
end

%% Scrambled Low -> High

%load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat');
load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat');

% Scramble network weights
W = SimValues.WeightMat(:,:,end);

W_EI = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,end);
connections = find(W_EI > 0);
W_EI(connections) = W_EI(connections(randperm(length(connections))));
W(SimValues.EcellIDX,SimValues.IcellIDX) = W_EI;

for simnum = 1:25
   
if mod(simnum,5)+1 == modnum
    
mod(simnum,5)+1
modnum

rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 10;
PopParamsAnalysis.W = W;

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

%datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/UP/LognormalEE_LognormalRates_Scrambled/';
datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/UP/LognormalEE_UniformRates_Scrambled/';
dataname = ['Scrambled_Lognormal_m_1_s_10_EE_IE_KIE_250_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'bistability',false);

end
end

%% Mean Matched High -> Low

%load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat');
load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat');

W_EI = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,end);
connections = find(W_EI > 0);
W_EI(connections) = mean(W_EI(connections));
W(SimValues.EcellIDX,SimValues.IcellIDX) = W_EI;

for simnum = 1:100
   
if mod(simnum,5)+1 == modnum
    
mod(simnum,5)+1
modnum

rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

%datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/LognormalEE_LognormalRates_Mean/';
datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/LognormalEE_UniformRates_Mean/';
dataname = ['Mean_Lognormal_m_1_s_10_EE_IE_KIE_250_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'bistability',true);

end
end

%% Mean Matched Low -> High

%load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_LognormalRates_Noise_10ms_50pA_K_IE_250.mat');
load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_UniformRates_Noise_10ms_50pA_K_IE_250.mat');

W_EI = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,end);
connections = find(W_EI > 0);
W_EI(connections) = mean(W_EI(connections));
W(SimValues.EcellIDX,SimValues.IcellIDX) = W_EI;

for simnum = 1:100
   
if mod(simnum,5)+1 == modnum
    
mod(simnum,5)+1
modnum

rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 10;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

%datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/UP/LognormalEE_LognormalRates_Mean/';
datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/UP/LognormalEE_UniformRates_Mean/';
dataname = ['Mean_Lognormal_m_1_s_10_EE_IE_KIE_250_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'bistability',false);

end
end
end
