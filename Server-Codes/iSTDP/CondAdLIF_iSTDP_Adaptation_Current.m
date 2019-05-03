function CondAdLIF_iSTDP_Adaptation_Current(modnum)

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
PopParams.TargetRateI = 8; %Target E rate 1Hz
PopParams.TargetRateE = 2; %Target I rate 1Hz
PopParams.tauSTDP = 20;

%%

load('/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/Lognormal_m_1_s_10_EE_IE.mat');

PopParams_in = PopParams;
PopParams_in.tau_w = 300;
PopParams_in.LearningRate = 0;
PopParams_in.sigma = 25;
PopParams_in.W = SimValues.WeightMat(:,:,end);
PopParams_in.gwnorm = PopParams_in.g_L(1);
PopParams_in.t_syn = 0;

PopParams_in.V0 = min(PopParams_in.E_L) + (min(PopParams_in.V_th)-min(PopParams_in.E_L)).*rand(PopParams_in.EPopNum + PopParams_in.IPopNum,1);

TimeParams.dt      = 0.05;

TimeParams.SimTime = 1e4;

Ivals = linspace(100,300,21);
bvals = logspace(-2,2,11);

for II = 1:(length(Ivals)*length(bvals))
    
if mod(II,4)+1 == modnum
ii = mod(II,length(Ivals))+1;
bb = ceil(II/length(Ivals));
    
ii
bb 
    
PopParamsAnalysis = PopParams_in;

I_e = Ivals(ii);
b = bvals(bb);

PopParamsAnalysis.I_e = I_e;
PopParamsAnalysis.b = b;

SimValuesArray = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false);

spikes = SimValuesArray.spikes;

save(['/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/LognormalEE_IE/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'],'spikes','-v7.3') 
%disp(['/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/Uniform_w_1/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat']) 

end

end

end