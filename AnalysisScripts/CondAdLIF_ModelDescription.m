%CondAdLIF_ModelDescription.m
%A script for illustrating the properties of the Conductance-based Adaptive
%LIF model.
%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures'];
%% Example Neuron Properties

%Input 
PopParams.I_e  = 0;
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 0;

%Neuron properties
PopParams.E_L     = -65;    %rev potential: leak (mV)
PopParams.g_L     = 30;     %leak conductance (nS)
PopParams.C       = 281;    %capacitance (pF)
PopParams.V_th    = -55;    %spike threshold (mV)
PopParams.V_reset = -85;    %reset potential (mV)
PopParams.t_ref   = 0.2;    %refractory period (ms)

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.b_s     = 1;      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
PopParams.a       = 0.5;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
PopParams.b       = 0.1;    %adaptation activation rate (1/ms)
PopParams.delta_T = 10;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 0;        %E->E weight
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 0;        %Expected E->E In Degree
PopParams.Kii   = 0;        %Expected I->I In Degree
PopParams.Kie   = 0;        %Expected E->I In Degree
PopParams.Kei   = 0;        %Expected I->E In Degree

%% Noise Input Properties
TimeParams.dt      = 0.1;
TimeParams.SimTime = 50000;
sf = 1./(TimeParams.dt./1000); %sampling frequency of the simulation (Hz)

sigvals = [0 10 20];
PopParams.theta = 1/10;
for ss = 1:length(sigvals)
    PopParams.sigma = sigvals(ss);
    [SimValues.sigma(ss)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

thetavals = [1 1/10 1/100];
PopParams.sigma = 10;
for ss = 1:length(sigvals)
    PopParams.theta = thetavals(ss);
    [SimValues.theta(ss)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%close all
%Magnitude, time scale - of input
%show distribution, frequency spectrum of input, and voltage, and
%adaptation? (diff't levels)
%%

clear InputStats
clear VoltageStats
InputStats.bins = linspace(-200,200,51);
VoltageStats.bins = linspace(-70,-60,51);
for ss = 1:length(sigvals)
    InputStats(ss).hist = hist(SimValues.sigma(ss).Input,InputStats.bins);
    InputStats(ss).hist = InputStats(:,ss).hist./max(InputStats(ss).hist);
    InputStats(ss).std = std(SimValues.sigma(ss).Input);
    [InputStats(ss).fft,InputStats(ss).freqs] =  pwelch(SimValues.sigma(ss).Input,sf,[],[],sf);
    
    VoltageStats(ss).hist = hist(SimValues.sigma(ss).V,VoltageStats.bins);
    VoltageStats(ss).hist = VoltageStats(:,ss).hist./max(VoltageStats(ss).hist);
    VoltageStats(ss).std = std(SimValues.sigma(ss).V);
    [VoltageStats(ss).fft,VoltageStats(ss).freqs] = pwelch(SimValues.sigma(ss).V,sf,[],[],sf);
end
%%
noisecolors = [0 0 0; 0.35 0.35 0.35; 0.7 0.7 0.7];
timewin = [1000 2000];
figure
subplot(3,4,1:2)
    hold on
    for ss = length(sigvals):-1:1
        plot(SimValues.sigma(ss).t,SimValues.sigma(ss).Input(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
subplot(3,4,3)
hold on
    for ss = length(sigvals):-1:1
        bar(InputStats(1).bins,InputStats(ss).hist,'edgecolor',noisecolors(ss,:),'facecolor','w')
    end
    axis tight
subplot(3,4,4)
hold on
    for ss = length(sigvals):-1:1
        plot(log10(InputStats(ss).freqs),log10(InputStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    LogScale('x',10)
    
subplot(3,4,5:6)
    hold on
    for ss = 1:length(sigvals)
        plot(SimValues.sigma(ss).t,SimValues.sigma(ss).V(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
subplot(3,4,7)
hold on
    for ss = length(sigvals):-1:1
        bar(VoltageStats(1).bins,VoltageStats(ss).hist,'edgecolor',noisecolors(ss,:),'facecolor','w')
    end
    axis tight
    
subplot(3,4,8)
hold on
    for ss = 1:length(sigvals)
        plot(log10(VoltageStats(ss).freqs),log10(VoltageStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    LogScale('x',10)
    
    
    
%% Voltage Reset
%refreactory period, step current

%% Adaptation - 
%subthreshold, superthreshold.  show E cell under low mag step current? w
%variable, gW.  membrane potential with reversal potential.
%step currents for sub,super,of diff't values.  sub+super for a select
%intermediate zone

%% Synaptic properties and variables

%Show: E spike effect on I,E
% Vm, S, (A?) of presynaptic cell
% Vm of postsynaptic E,I cell at different holding voltages
% same for I spike effect on I,E
%plot membrance potential with reversal potentials?