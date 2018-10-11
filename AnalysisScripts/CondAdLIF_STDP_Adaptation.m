%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';
%repopath = '/scratch/jmg1030/LogWeightSigma/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

%Input
PopParams.I_e   = 250;       %External input
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 0;

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
PopParams.tau_w   = 100;     %subthreshold adaptation steepness
PopParams.gwnorm  = 1;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 0;        %E->E weight (nS)
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 0;        %Expected E->E In Degree
PopParams.Kii   = 0;        %Expected I->I In Degree
PopParams.Kie   = 0;        %Expected E->I In Degree
PopParams.Kei   = 0;        %Expected I->E In Degree

PopParams.V0    = -65;

TimeParams.dt      = 0.05;
TimeParams.SimTime = 1e4;

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

a = 0:0.001:0.08;
b = 0:1:100;

Ivals = 0:10:1000;

ISI_a = zeros(length(a),length(Ivals));
ISI_b = zeros(length(b),length(Ivals));

w_a = zeros(length(a),length(Ivals));
w_b = zeros(length(b),length(Ivals));

%%
for aa = 2:length(a)
for ii = 1:length(Ivals)
    
PopParams.I_e = Ivals(ii);
PopParams.a = a(aa);
PopParams.b = 0;
    
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false);

ISI_a(aa,ii) = 1./mean(diff(SimValues.spikes(SimValues.spikes(:,1) > 1.5e3)));

if isempty(SimValues.spikes(SimValues.spikes(:,1) > 1e3))
    ISI_a(aa,ii) = 0;
end

w_a(aa,ii) = mean(SimValues.w(2001:end));

% figure
% subplot(2,1,1)
% plot(SimValues.t,SimValues.V)
% xlabel('Time (ms)');ylabel('Voltage (mV)');title(['Current ' num2str(Ivals(ii))])
% subplot(2,1,2)
% plot(SimValues.t,SimValues.w)
% xlabel('Time (ms)');ylabel('Adaptation (nS)')

end
end


%%
for bb = 2:length(b)
for ii = 1:length(Ivals)
    
PopParams.I_e = Ivals(ii);

PopParams.a = 0;
PopParams.b = b(bb);
    
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false);

ISI_b(bb,ii) = 1./mean(diff(SimValues.spikes(SimValues.spikes(:,1) > 1e3)));

if isnan(ISI_b(bb,ii))
    ISI_b(bb,ii) = 0;
end

w_b(bb,ii) = mean(SimValues.w(2001:end));

if isnan(w_b(bb,ii))
    w_b(bb,ii) = 0;
end

% figure
% subplot(2,1,1)
% plot(SimValues.t,SimValues.V)
% xlabel('Time (ms)');ylabel('Voltage (mV)')
% subplot(2,1,2)
% plot(SimValues.t,SimValues.w)
% xlabel('Time (ms)');ylabel('Adaptation (nS)')

end
end

%%

for aa = 1:length(a)
    
figure
plot(ISI_a(aa,:),w_a(aa,:),'.k')
xlabel('1/ISI');ylabel('Adaptation');title(['Subthreshold Adaptation a: ' num2str(a(aa))])

NiceSave(['Subthreshold_Based_Adaptation_a_' num2str(a(aa))],'~/Desktop/TrainedWeights/figures/',[])

close all

end

%%

for bb = 1:length(b)
    
figure
plot(ISI_b(bb,:),w_b(bb,:),'.k')
xlabel('1/ISI');ylabel('Adaptation');title(['Spike-Based Adaptation b: ' num2str(b(bb))])

NiceSave(['Spike_Based_Adaptation_b_' num2str(b(bb))],'~/Desktop/TrainedWeights/figures/',[])

close all

end

