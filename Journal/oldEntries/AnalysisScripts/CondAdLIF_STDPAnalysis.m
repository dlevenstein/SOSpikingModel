%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures'];
%% Example Neuron Properties

clear all

%Input 
PopParams.I_e  = 250;
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1000;
PopParams.IPopNum = 250;

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
PopParams.Wee   = 50;        %E->E weight
PopParams.Wii   = 50;        %I->I weight
PopParams.Wie   = 50;        %E->I weight
PopParams.Wei   = 10;        %I->E weight
PopParams.Kee   = 100;        %Expected E->E In Degree
PopParams.Kii   = 100;        %Expected I->I In Degree
PopParams.Kie   = 100;        %Expected E->I In Degree
PopParams.Kei   = 100;        %Expected I->E In Degree

%% Noise Input Properties

disp('parallel computing')

TimeParams.dt      = 0.05;
TimeParams.SimTime = 1000;

close all

%%

%STDP Properties

PopParams.EELearningRate = 0;
PopParams.IILearningRate = 0;
PopParams.IELearningRate = 0;
PopParams.EILearningRate = 1e-2;

PopParams.EEtau = 1;
PopParams.IItau = 1;
PopParams.IEtau = 1;
PopParams.EItau = 1;

tic
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true);
toc

timebins = 0.05:0.05:TimeParams.SimTime;
rate = zeros(1,length(timebins));

for tt = 1:length(timebins)

    rate(tt) = length(find(SimValues.spikes(:,1) >= timebins(tt) - 10 & SimValues.spikes(:,1) < timebins(tt)))./(10*(PopParams.EPopNum+PopParams.IPopNum));
    
end
%%

figure
subplot(2,1,1)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot')
subplot(2,1,2)
plot(timebins,rate,'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Firing Rate');title('Firing Rate')

figure

subplot(3,1,1)
plot(SimValues.t,SimValues.IILoss,'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Synaptic Change');title('II Synaptic Changes')
subplot(3,1,2)
plot(SimValues.t,log10(SimValues.IIMeanWeight),'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Synaptic Change LogScale');title('II Weight Mean')
subplot(3,1,3)
plot(SimValues.t,log10(SimValues.IIVarWeight),'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Synaptic Change LogScale');title('II Weight Variance')

figure

subplot(3,1,1)
plot(SimValues.t,SimValues.EILoss,'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Synaptic Change');title('EI Synaptic Changes')
subplot(3,1,2)
plot(SimValues.t,log10(SimValues.EIMeanWeight),'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Synaptic Change LogScale');title('EI Weight Mean')
subplot(3,1,3)
plot(SimValues.t,log10(SimValues.EIVarWeight),'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Synaptic Change LogScale');title('EI Weight Variance')

figure
subplot(2,1,1)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot')
subplot(2,1,2)
imagesc(SimValues.V)
xlabel('Time (ms)');ylabel('Membrane Potential');title('Membrane Potential')

