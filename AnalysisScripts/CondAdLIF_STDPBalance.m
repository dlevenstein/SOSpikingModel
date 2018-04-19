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
PopParams.tau_s   = [5 5];      %synaptic decay timescale (1/ms)

%Adaptation Properties (No adaptation)
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 3;        %E->E weight (nS)
PopParams.Wii   = 3;        %I->I weight
PopParams.Wie   = 3;        %E->I weight
PopParams.Wei   = 3;        %I->E weight
PopParams.Kee   = 50;        %Expected E->E In Degree
PopParams.Kii   = 50;        %Expected I->I In Degree
PopParams.Kie   = 50;        %Expected E->I In Degree
PopParams.Kei   = 50;        %Expected I->E In Degree

%% Noise Input Properties
TimeParams.dt      = 0.05;
TimeParams.SimTime = 6000;

close all

%%

%STDP Properties
PopParams.LearningRate = 1e-2;
PopParams.TargetRate = 1; %Target E rate 1Hz
PopParams.tauSTDP = 20;


tic
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true);
toc


%%
figure
subplot(3,1,1)
plot(squeeze(SimValues.WeightMat(1,SimValues.EcellIDX,:))','k')
hold on
plot(squeeze(SimValues.WeightMat(1,SimValues.IcellIDX,:))','r')
subplot(3,1,2)
plot(SimValues.g_e(1,:),'k')
hold on
plot(SimValues.g_i(1,:),'r')
subplot(3,1,3)
plot(SimValues.V(1,:),'k')
%ylim([-80 0])


%%
timewin = TimeParams.SimTime+[-500 0];
GetSpikeStats(SimValues,PopParams,timewin)
%%
dt = 5; %ms
[spikemat,t_spikemat] = SpktToSpkmat(SimValues.spikesbycell,[],5);
poprate.E = sum(spikemat(:,SimValues.EcellIDX),2)./length(SimValues.EcellIDX)./(dt./1000);
poprate.I = sum(spikemat(:,SimValues.IcellIDX),2)./length(SimValues.IcellIDX)./(dt./1000);

%%

figure
subplot(2,1,1)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot')
subplot(2,1,2)
plot(t_spikemat,poprate.E,'k', 'Markersize' , 1)
xlabel('Time (ms)');ylabel('Firing Rate (Spks/cell/s)');title('Firing Rate')

