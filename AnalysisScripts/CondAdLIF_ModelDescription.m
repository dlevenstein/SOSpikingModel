%CondAdLIF_ModelDescription.m
%A script for illustrating the properties of the Conductance-based Adaptive
%LIF model.
%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
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

sigvals = [0 10 20 40];
PopParams.theta = 1/10;
for ss = 1:length(sigvals)
    PopParams.sigma = sigvals(ss);
    [sigmatest.SimValues(ss)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

thetavals = [1 1/10 1/100];
PopParams.sigma = 10;
for ss = 1:length(thetavals)
    PopParams.theta = thetavals(ss);
    [thetatest.SimValues(ss)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%close all
%Magnitude, time scale - of input
%show distribution, frequency spectrum of input, and voltage, and
%adaptation? (diff't levels)
%%

clear InputStats
clear VoltageStats
sigmatest.InputStats.bins = linspace(-200,200,51);
sigmatest.VoltageStats.bins = linspace(-70,-60,51);
for ss = 1:length(sigvals)
    sigmatest.InputStats(ss).hist = hist(sigmatest.SimValues(ss).Input,sigmatest.InputStats.bins);
    sigmatest.InputStats(ss).hist = sigmatest.InputStats(:,ss).hist./max(sigmatest.InputStats(ss).hist);
    sigmatest.InputStats(ss).std = std(sigmatest.SimValues(ss).Input);
    [sigmatest.InputStats(ss).fft,sigmatest.InputStats(ss).freqs] =  pwelch(sigmatest.SimValues(ss).Input,sf,[],[],sf);
    
    sigmatest.VoltageStats(ss).hist = hist(sigmatest.SimValues(ss).V,sigmatest.VoltageStats.bins);
    sigmatest.VoltageStats(ss).hist = sigmatest.VoltageStats(:,ss).hist./max(sigmatest.VoltageStats(ss).hist);
    sigmatest.VoltageStats(ss).std = std(sigmatest.SimValues(ss).V);
    [sigmatest.VoltageStats(ss).fft,sigmatest.VoltageStats(ss).freqs] = pwelch(sigmatest.SimValues(ss).V,sf,[],[],sf);
end

thetatest.InputStats.bins = linspace(-200,200,51);
thetatest.VoltageStats.bins = linspace(-70,-60,51);
for ss = 1:length(thetavals)
    thetatest.InputStats(ss).hist = hist(thetatest.SimValues(ss).Input,thetatest.InputStats.bins);
    thetatest.InputStats(ss).hist = thetatest.InputStats(:,ss).hist./max(thetatest.InputStats(ss).hist);
    thetatest.InputStats(ss).std = std(thetatest.SimValues(ss).Input);
    [thetatest.InputStats(ss).fft,thetatest.InputStats(ss).freqs] =  pwelch(thetatest.SimValues(ss).Input,sf,[],[],sf);
    
    thetatest.VoltageStats(ss).hist = hist(thetatest.SimValues(ss).V,thetatest.VoltageStats.bins);
    thetatest.VoltageStats(ss).hist = thetatest.VoltageStats(:,ss).hist./max(thetatest.VoltageStats(ss).hist);
    thetatest.VoltageStats(ss).std = std(thetatest.SimValues(ss).V);
    [thetatest.VoltageStats(ss).fft,thetatest.VoltageStats(ss).freqs] = pwelch(thetatest.SimValues(ss).V,sf,[],[],sf);
end
%%
figure
subplot(2,2,1)
plot(sigvals,[sigmatest.InputStats.std],'o')
hold on 
plot([0 100],[0 100],'--')
xlabel('Sigma');ylabel('Noise Std')

subplot(2,2,2)
plot(thetavals,[thetatest.InputStats.std],'o')
hold on
%plot([0 100],[0 100],'--')
xlabel('Theta');ylabel('Noise Std')

%%
noisecolors = [0 0 0; 0.2 0.2 0.2; 0.4 0.4 0.4; 0.6 0.6 0.6];
timewin = [1000 2000];
figure
subplot(3,4,1:2)
    hold on
    for ss = length(sigvals):-1:1
        plot(sigmatest.SimValues(ss).t,sigmatest.SimValues(ss).Input(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
subplot(3,4,3)
hold on
    for ss = length(sigvals):-1:1
        bar(sigmatest.InputStats(1).bins,sigmatest.InputStats(ss).hist,'edgecolor',noisecolors(ss,:),'facecolor','w')
    end
    axis tight
subplot(3,4,4)
hold on
    for ss = length(sigvals):-1:1
        plot(log10(sigmatest.InputStats(ss).freqs),log10(sigmatest.InputStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    %LogScale('x',10)
    
subplot(6,4,9:10)
    hold on
    for ss = 1:length(sigvals)
        plot(sigmatest.SimValues(ss).t,sigmatest.SimValues(ss).V(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
subplot(6,4,11)
hold on
    for ss = length(sigvals):-1:1
        bar(sigmatest.VoltageStats(1).bins,sigmatest.VoltageStats(ss).hist,'edgecolor',noisecolors(ss,:),'facecolor','w')
    end
    axis tight
    
subplot(6,4,12)
hold on
    for ss = 1:length(sigvals)
        plot(log10(sigmatest.VoltageStats(ss).freqs),log10(sigmatest.VoltageStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    %LogScale('x',10)
    
 
    

subplot(6,4,[13:14 17:18])
    hold on
    for ss = length(thetavals):-1:1
        plot(thetatest.SimValues(ss).t,thetatest.SimValues(ss).Input(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
subplot(6,4,[15 19])
hold on
    for ss = length(thetavals):-1:1
        bar(thetatest.InputStats(1).bins,thetatest.InputStats(ss).hist,'edgecolor',noisecolors(ss,:),'facecolor','w')
    end
    axis tight
subplot(6,4,[16 20])
hold on
    for ss = length(thetavals):-1:1
        plot(log10(thetatest.InputStats(ss).freqs),log10(thetatest.InputStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    %LogScale('x',10)
    
subplot(6,4,21:22)
    hold on
    for ss = 1:length(thetavals)
        plot(thetatest.SimValues(ss).t,thetatest.SimValues(ss).V(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
subplot(6,4,23)
hold on
    for ss = length(thetavals):-1:1
        bar(thetatest.VoltageStats(1).bins,thetatest.VoltageStats(ss).hist,'edgecolor',noisecolors(ss,:),'facecolor','w')
    end
    axis tight
    
subplot(6,4,24)
hold on
    for ss = 1:length(thetavals)
        plot(log10(thetatest.VoltageStats(ss).freqs),log10(thetatest.VoltageStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    %LogScale('x',10)
    
    
    
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