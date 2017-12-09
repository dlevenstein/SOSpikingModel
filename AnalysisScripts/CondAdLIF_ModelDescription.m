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

sigvals = [0 10 20 40];
PopParams.theta = 1/10;
for ss = 1:length(sigvals)
    PopParams.sigma = sigvals(ss);
    [sigmatest.SimValues(ss)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

thetavals = [10 1 1/10 1/100];
PopParams.sigma = 20;
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


%%
noisecolors = [0 0 0; 0.25 0.25 0.25; 0.5 0.5 0.5; 0.75 0.75 0.75];

figure
subplot(3,3,1)
hold on
    for ss = length(sigvals):-1:1
     plot(sigvals(ss),sigmatest.InputStats(ss).std,'.','color',noisecolors(ss,:),'markersize',20)
    end
 
plot([0 60],[0 60],'--')
xlabel('Sigma (pA)');ylabel('Noise Std (pA)')

subplot(3,3,2)
hold on
    for ss = 1:length(thetavals)
    plot(log10(thetavals(ss)),thetatest.InputStats(ss).std,'.','color',noisecolors(ss,:),'markersize',20)
    end
hold on
LogScale('x',10)
%plot([0 100],[0 100],'--')
ylim([0 40])
xlabel('Theta (ms^-^1)');ylabel('Noise Std (pA)')

NiceSave('noiseplots',figfolder,'CondAdLIF')  


timewin = [1000 1500];
figure
subplot(3,4,1:2)
    hold on
    for ss = length(sigvals):-1:1
        plot(sigmatest.SimValues(ss).t,sigmatest.SimValues(ss).Input(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
    xlabel('t (ms)');ylabel('Input (pA)')
subplot(3,4,3)
hold on
    for ss = length(sigvals):-1:1
        plot(sigmatest.InputStats(1).bins,sigmatest.InputStats(ss).hist,'color',noisecolors(ss,:),'Linewidth',1)
    end
    axis tight
    xlabel('Input (pA)')
subplot(3,4,4)
hold on
    for ss = length(sigvals):-1:1
        plot(log10(sigmatest.InputStats(ss).freqs),log10(sigmatest.InputStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    LogScale('xy',10)
    xlabel('f (Hz)');ylabel('Power (pA)')
    
subplot(6,4,9:10)
    hold on
    for ss = 1:length(sigvals)
        plot(sigmatest.SimValues(ss).t,sigmatest.SimValues(ss).V(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
    xlabel('t (ms)');ylabel('V (mV)')
subplot(6,4,11)
hold on
    for ss = length(sigvals):-1:1
        plot(sigmatest.VoltageStats(1).bins,sigmatest.VoltageStats(ss).hist,'color',noisecolors(ss,:))
    end
    axis tight
    
subplot(6,4,12)
hold on
    for ss = 1:length(sigvals)
        plot(log10(sigmatest.VoltageStats(ss).freqs),log10(sigmatest.VoltageStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    LogScale('x',10)
    
 
    

subplot(3,4,9:10)
    hold on
    for ss = 1:length(thetavals)
        plot(thetatest.SimValues(ss).t,thetatest.SimValues(ss).Input(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
    xlabel('t (ms)');ylabel('Input (pA)')
subplot(3,4,11)
hold on
    for ss = length(thetavals):-1:1
        plot(thetatest.InputStats(1).bins,thetatest.InputStats(ss).hist,'color',noisecolors(ss,:))
    end
    axis tight
    xlabel('Input (pA)')
subplot(3,4,12)
hold on
    for ss = length(thetavals):-1:1
        plot(log10(thetatest.InputStats(ss).freqs),log10(thetatest.InputStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    LogScale('xy',10)
    xlabel('f (Hz)');ylabel('Power (pA)')
    
subplot(6,4,13:14)
    hold on
    for ss = 1:length(thetavals)
        plot(thetatest.SimValues(ss).t,thetatest.SimValues(ss).V(1,:),'color',noisecolors(ss,:),'linewidth',1)
    end
    xlim(timewin)
    
subplot(6,4,15)
hold on
    for ss = length(thetavals):-1:1
        plot(thetatest.VoltageStats(1).bins,thetatest.VoltageStats(ss).hist,'color',noisecolors(ss,:))
    end
    axis tight
    
subplot(6,4,16)
hold on
    for ss = 1:length(thetavals)
        plot(log10(thetatest.VoltageStats(ss).freqs),log10(thetatest.VoltageStats(ss).fft),'color',noisecolors(ss,:))
    end
    axis tight
    LogScale('x',10)
    
NiceSave('noiseIllustration',figfolder,'CondAdLIF')    
    
%% Spiking/Synaptic Properties
%refreactory period, step current
PopParams.sigma = 0;
PopParams.EPopNum = 2;
TimeParams.SimTime = 2000;

t_ref   = [0.5 0.5 0.5 0.2 0.5 1];

PopParams.Wee   = 100;        %E->E weight
PopParams.Wii   = 1;        %I->I weight
PopParams.Wie   = 1;        %E->I weight
PopParams.Wei   = 1;        %I->E weight
PopParams.Kee   = 2;        %Expected E->E In Degree
PopParams.Kii   = 1;        %Expected I->I In Degree
PopParams.Kie   = 1;        %Expected E->I In Degree
PopParams.Kei   = 1;

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
b_s     = [1 1 1 0.5 1 2];      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
a       = [0.5 1 1.5 0.5 0.5 0.5];    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
b_w     = [0.1 0.03 0.01 0.01 0.01 0.01];   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
b       = [1 1 1 0.5 1 2];    %adaptation activation rate (1/ms) (spike)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Input Current Function: A step function that only effects neuron 1
stepmag = 301;
steptime = [1000 1100];
Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2))  ;zeros(size(t))];
PopParams.I_e = Inputfun;

for ii = 1:6
PopParams.b = b(ii);
PopParams.t_ref = t_ref(ii);
PopParams.b_w     = b_w(ii);
PopParams.b_s = b_s(ii);
PopParams.a       = a(ii);
[testvals(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end
%% Spiking Properties
viewwin = [990 1200];
viewwin2 = [1050 1060];
figure
    subplot(4,2,1)
        plot(testvals(1).t,testvals(1).Input(1,:),'k')
        xlim(viewwin)
        ylabel('I')
    subplot(4,2,3)
        plot(testvals(1).t,testvals(1).V(1,:),'k')
        xlim(viewwin)
        ylabel('V_p_r_e')
    subplot(4,2,5)
    hold on
    for ii = 1:3
        plot(testvals(ii).t,testvals(ii).w(1,:),'k')
    end
        xlim(viewwin)
        ylabel('w_p_r_e')
    subplot(4,2,7)
    hold on
    for ii = 1:3
        plot(testvals(ii).t,testvals(ii).s(1,:),'k')
    end
        xlim(viewwin)
        ylabel('s_p_r_e')
        
    subplot(4,2,2)
    hold on
    for ii = 4:6
        plot(testvals(ii).t,testvals(ii).a_w(1,:),'k')
    end
        xlim(viewwin2)
        ylabel('a_w')
    subplot(4,2,4)
    hold on
    for ii = 4:6
        plot(testvals(ii).t,testvals(ii).V(1,:),'k')
    end
        xlim(viewwin2)
        ylabel('V_p_r_e')
    subplot(4,2,6)
    hold on
    for ii = 4:6
        plot(testvals(ii).t,testvals(ii).w(1,:),'k')
    end
        xlim(viewwin2)
        ylabel('w_p_r_e')
    subplot(4,2,8)
    hold on
    for ii = 4:6
        plot(testvals(ii).t,testvals(ii).s(1,:),'k')
    end
        xlim(viewwin2)
        ylabel('s_p_r_e')
        
NiceSave('spikeparms',figfolder,'CondAdLIF') 

%% Synaptic Properties
viewwin = [1025 1150];
figure
    subplot(4,2,1)
        plot(testvals(1).t,testvals(1).Input(1,:),'k')
        xlim(viewwin)
        ylabel('I')
    subplot(4,2,3)
        plot(testvals(1).t,testvals(1).V(1,:),'k')
        xlim(viewwin)
        ylabel('V_p_r_e')
    subplot(4,2,5)
        plot(testvals(1).t,testvals(1).w(1,:),'k')
        xlim(viewwin)
        ylabel('w_p_r_e')
    subplot(4,2,7)
        plot(testvals(1).t,testvals(1).s(1,:),'k')
        xlim(viewwin)
        ylabel('s_p_r_e')
        
    subplot(4,2,2)
    hold on
    for ii = 4:6
        plot(testvals(ii).t,testvals(ii).g_e(2,:),'k')
    end
    axis tight
    xlim(viewwin)
        ylabel('g_e_,_p_o_s_t')
    subplot(4,2,4)
    hold on
    for ii = 4:6
        plot(testvals(ii).t,testvals(ii).V(2,:),'k')
        
    end
    axis tight
    xlim(viewwin)
        ylabel('v_p_o_s_t')
    subplot(4,2,6)
        plot(testvals(1).t,testvals(1).w(2,:),'k')
        xlim(viewwin)
        ylabel('w_p_o_s_t')
%     subplot(4,2,8)
%         plot(testvals.t,testvals.s(2,:),'k')
%         xlim(viewwin)
%         ylabel('w_p_o_s_t')
       NiceSave('synparms',figfolder,'CondAdLIF')  
     %% Adaptation Function
     w_r = 0.1;
     b_w = 0.01;
     E_L = -65;
     delta_T = 10;
     V = linspace(-70,-55,100);
     a_w = w_r.*b_w./(1 - w_r).*exp((V-E_L).*delta_T);
     plot(V,a_w)
%% Adaptation - 


%subthreshold, superthreshold.  show E cell under low mag step current? w
%variable, gW.  membrane potential with reversal potential.
%step currents for sub,super,of diff't values.  sub+super for a select
%intermediate zone
TimeParams.SimTime = 2000;

%Input 
PopParams.I_e  = 0;
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 0;

%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-48 -50];    %reset potential (mV)
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
PopParams.b       = 1;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
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

stepmags = -100:50:400;
for ii = 1:length(stepmags)
%Input Current Function: A step function that only effects neuron 1
stepmag = (stepmags(ii));
steptime = [1000 1500];
Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2))];
PopParams.I_e = Inputfun;
[testvals(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%%
viewwin = [900 1600];
figure
subplot(3,2,1)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).V,'k')
    end
    xlim(viewwin)
    
subplot(3,2,3)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).w,'k')
    end
    xlim(viewwin)
    
subplot(3,2,5)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).a_w,'k')
    end
    xlim(viewwin)
    
    
    %%
    
    %Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
PopParams.b       = 1;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0.5;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 10; 


for ii = 1:length(stepmags)
%Input Current Function: A step function that only effects neuron 1
stepmag = (stepmags(ii));
steptime = [1000 1500];
Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2))];
PopParams.I_e = Inputfun;
[testvals(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%%
viewwin = [900 1600];
figure
subplot(3,2,1)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).V,'k')
    end
    xlim(viewwin)
    
subplot(3,2,3)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).w,'k')
    end
    xlim(viewwin)
    
subplot(3,2,5)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).a_w,'k')
    end
    xlim(viewwin)
    
subplot(2,2,2)
     V = linspace(-70,-55,100);
     a_w = PopParams.w_r.*PopParams.b_w./(1 - PopParams.w_r).*exp((V-PopParams.E_L(1)).*PopParams.delta_T);
     plot(V,a_w,'k')
     hold on
     plot(V(end)+[0 5],PopParams.b.*[1 1],'k')
     xlabel('V')
     ylabel('Alpha(V)')
%% Synaptic properties and variables

%Show: E spike effect on I,E
% Vm, S, (A?) of presynaptic cell
% Vm of postsynaptic E,I cell at different holding voltages
% same for I spike effect on I,E
%plot membrance potential with reversal potentials?