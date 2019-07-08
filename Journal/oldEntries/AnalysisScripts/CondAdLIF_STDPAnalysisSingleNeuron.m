addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/RunCodes')
addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/FunctionRoutines')
addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/MiscUtilities')

%% Example Neuron Properties

%Input 
PopParams.I_e  = 250;
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 1;

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
PopParams.tau_s   = [2 2];      %synaptic decay timescale (1/ms)
PopParams.a       = 10;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 1;        %E->E weight
PopParams.Wii   = 1;        %I->I weight
PopParams.Wie   = 1;        %E->I weight
PopParams.Wei   = 1;        %I->E weight
PopParams.Kee   = 1;        %Expected E->E In Degree
PopParams.Kii   = 1;        %Expected I->I In Degree
PopParams.Kie   = 1;        %Expected E->I In Degree
PopParams.Kei   = 1;        %Expected I->E In Degree

%% Noise Input Properties
TimeParams.dt      = 0.05;
TimeParams.SimTime = 500;

close all

%%

%STDP Properties

PopParams.EELearningRate = 1;
PopParams.IILearningRate = 0;
PopParams.IELearningRate = 0;
PopParams.EILearningRate = 0;

PopParams.EEtau = 0.1;
PopParams.IItau = 0.1;
PopParams.IEtau = 0.1;
PopParams.EItau = 0.1;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true);

timebins = 10:10:TimeParams.SimTime;
rate = zeros(1,length(timebins));

for tt = 1:length(timebins)

    rate(tt) = length(find(SimValues.spikes(:,1) >= timebins(tt) - 10 & SimValues.spikes(:,1) < timebins(tt)))./(10*(PopParams.EPopNum+PopParams.IPopNum));
    
end

figure
subplot(3,1,1)
scatter(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('EE STDP')
subplot(3,1,2)
plot(timebins,rate)
xlabel('Time (ms)');ylabel('Firing Rate');title('EE STDP')
subplot(3,1,3)
plot(SimValues.t,SimValues.EELoss);
xlabel('Time (ms)');ylabel('Synaptic Change');title('Synaptic Changes')

%%

%STDP Properties

PopParams.EELearningRate = 0;
PopParams.IILearningRate = 1;
PopParams.IELearningRate = 0;
PopParams.EILearningRate = 0;

PopParams.EEtau = 0.1;
PopParams.IItau = 0.1;
PopParams.IEtau = 0.1;
PopParams.EItau = 0.1;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true);

timebins = 10:10:TimeParams.SimTime;
rate = zeros(1,length(timebins));

for tt = 1:length(timebins)

    rate(tt) = length(find(SimValues.spikes(:,1) >= timebins(tt) - 10 & SimValues.spikes(:,1) < timebins(tt)))./(10*(PopParams.EPopNum+PopParams.IPopNum));
    
end

figure
subplot(3,1,1)
scatter(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('II STDP')
subplot(3,1,2)
plot(timebins,rate)
xlabel('Time (ms)');ylabel('Firing Rate');title('II STDP')
subplot(3,1,3)
plot(SimValues.t,SimValues.IILoss);
xlabel('Time (ms)');ylabel('Synaptic Change');title('Synaptic Changes')

%%

%STDP Properties

PopParams.EELearningRate = 0;
PopParams.IILearningRate = 0;
PopParams.IELearningRate = 1;
PopParams.EILearningRate = 0;

PopParams.EEtau = 0.1;
PopParams.IItau = 0.1;
PopParams.IEtau = 0.1;
PopParams.EItau = 0.1;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true);

timebins = 10:10:TimeParams.SimTime;
rate = zeros(1,length(timebins));

for tt = 1:length(timebins)

    rate(tt) = length(find(SimValues.spikes(:,1) >= timebins(tt) - 10 & SimValues.spikes(:,1) < timebins(tt)))./(10*(PopParams.EPopNum+PopParams.IPopNum));
    
end

figure
subplot(3,1,1)
scatter(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('IE STDP')
subplot(3,1,2)
plot(timebins,rate)
xlabel('Time (ms)');ylabel('Firing Rate');title('IE STDP')
subplot(3,1,3)
plot(SimValues.t,SimValues.IELoss);
xlabel('Time (ms)');ylabel('Synaptic Change');title('Synaptic Changes')

%%

%STDP Properties

PopParams.EELearningRate = 0;
PopParams.IILearningRate = 0;
PopParams.IELearningRate = 0;
PopParams.EILearningRate = 1;

PopParams.EEtau = 0.1;
PopParams.IItau = 0.1;
PopParams.IEtau = 0.1;
PopParams.EItau = 0.1;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true);

timebins = 10:10:TimeParams.SimTime;
rate = zeros(1,length(timebins));

for tt = 1:length(timebins)

    rate(tt) = length(find(SimValues.spikes(:,1) >= timebins(tt) - 10 & SimValues.spikes(:,1) < timebins(tt)))./(10*(PopParams.EPopNum+PopParams.IPopNum));
    
end

figure
subplot(3,1,1)
scatter(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('EI STDP')
subplot(3,1,2)
plot(timebins,rate)
xlabel('Time (ms)');ylabel('Firing Rate');title('EI STDP')
subplot(3,1,3)
plot(SimValues.t,SimValues.EILoss);
xlabel('Time (ms)');ylabel('Synaptic Change');title('Synaptic Changes')
