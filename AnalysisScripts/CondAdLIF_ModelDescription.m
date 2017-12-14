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

%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-55 -55];    %reset potential (mV)
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
PopParams.IPopNum = 1;
TimeParams.SimTime = 2000;

t_ref   = [0.5 0.5 0.5 0.2 0.5 1];

PopParams.Wee   = 100;        %E->E weight
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 100;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 1;        %Expected E->E In Degree
PopParams.Kii   = 0;        %Expected I->I In Degree
PopParams.Kie   = 2;        %Expected E->I In Degree
PopParams.Kei   = 0;

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
b_s     = [0.5 0.2 0.1 1 1 1];      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
a       = [0.1 0.1 0.1 0.1 0.3 0.5 ];    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
b_w     = [0.10 0.05 0.02 0.02 0.02 0.02];   %adaptation decay rate (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
b       = [1 1 1 0.5 1 2];    %adaptation activation rate (1/ms) (spike)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Input Current Function: A step function that only effects neuron 1
stepmag = 250;
steptime = [1000 1050];
Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2));  ...
    zeros(size(t));zeros(size(t))];
PopParams.I_e = Inputfun;

clear testvals
for ii = 1:6
    PopParams.b = b(ii);
    PopParams.t_ref = t_ref(ii);
    PopParams.b_w     = b_w(ii);
    PopParams.b_s = b_s(ii);
    PopParams.a       = a(ii);
    [testvals(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%% Spiking Properties
viewwin = [990 1150];
viewwin2 = [1027.5 1035];
Ecolors = [0 0 0;0.35 0.35 0.35;0.7 0.7 0.7]; 
figure
    subplot(8,2,1)
        plot(testvals(1).t,testvals(1).Input(1,:),'k','linewidth',2)
        box off
        xlim(viewwin)
        ylim([0 stepmag+20])
        ylabel('I');xlabel('t (ms)')
    subplot(4,2,3)
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).V(1,:),'k','linewidth',2)
    end
        xlim(viewwin)
        ylim([-70 PopParams.V_th(1)])
        ylabel('V_p_r_e')
        box off
        
    subplot(4,2,5)
        hold on
        for ii = 3:-1:1
            plot(testvals(ii).t,testvals(ii).w(1,:),'color',Ecolors(ii,:),'linewidth',2)
        end
        legend(num2str(b_w(3)),num2str(b_w(2)),num2str(b_w(1)))
        xlim(viewwin);ylim([0 0.3])
        ylabel('w_p_r_e')
    subplot(4,2,7)
        hold on
        for ii = 3:-1:1
            plot(testvals(ii).t,testvals(ii).s(1,:),'color',Ecolors(ii,:),'linewidth',2)
        end
        legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        xlim(viewwin)
        ylabel('s_p_r_e')
        
    subplot(4,2,2)
        hold on
        for ii = 6:-1:4
            plot(testvals(ii).t,testvals(ii).a_w(1,:),'color',Ecolors(ii-3,:),'linewidth',2)
        end
        legend(num2str(b(6)),num2str(b(5)),num2str(b(4)),'location','west')
        xlim(viewwin2)
        ylabel('a_w')
    subplot(4,2,4)
        hold on
        for ii = 6:-1:4
            plot(testvals(ii).t,testvals(ii).V(1,:),'color',Ecolors(ii-3,:),'linewidth',2)
        end
        xlim(viewwin2);ylim([-70 PopParams.V_th(1)])
        legend(num2str(t_ref(6)),num2str(t_ref(5)),num2str(t_ref(4)),'location','west')
        ylabel('V_p_r_e')
    subplot(4,2,6)
        hold on
        for ii = 6:-1:4
            plot(testvals(ii).t,testvals(ii).w(1,:),'color',Ecolors(ii-3,:),'linewidth',2)
        end
        xlim(viewwin2)
        legend(num2str(b(6)),num2str(b(5)),num2str(b(4)),'location','west')
        ylabel('w_p_r_e')
    subplot(4,2,8)
        hold on
        for ii = 6:-1:4
            plot(testvals(ii).t,testvals(ii).s(1,:),'color',Ecolors(ii-3,:),'linewidth',2)
        end
        xlim(viewwin2)
        legend(num2str(a(6)),num2str(a(5)),num2str(a(4)),'location','west')
        ylabel('s_p_r_e')
        
NiceSave('spikeparms',figfolder,'CondAdLIF') 

%% Synaptic Properties
viewwin = [1025 1120];
vrange = [-68 -55];
Ecolors = [0 0.2 0;0.35 0.55 0.35;0.7 0.9 0.7]; 
Icolors = [0.2 0 0;0.55 0.35 0.35;0.9 0.7 0.7]; 
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
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).s(1,:),'color',Ecolors(ii,:),'linewidth',2)
    end
        xlim(viewwin)
        legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('s_p_r_e')
        
    subplot(4,2,2)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).g_e(2,:),'color',Ecolors(ii,:),'linewidth',2)
    end
    axis tight
    xlim(viewwin);
    legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('g_e_,_p_o_s_t')
    subplot(4,2,4)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).V(2,:),'color',Ecolors(ii,:),'linewidth',2)      
    end
    axis tight
    %legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
    xlim(viewwin);ylim(vrange)
        ylabel('v_p_o_s_t')
        
        
    subplot(4,2,6)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).g_e(3,:),'color',Icolors(ii,:),'linewidth',2)
    end
    axis tight
    xlim(viewwin);
    legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('g_e_,_p_o_s_t')
    subplot(4,2,8)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).V(3,:),'color',Icolors(ii,:),'linewidth',2)   
    end
    axis tight
    xlim(viewwin);ylim(vrange)
    %legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('v_p_o_s_t')

 NiceSave('postsynparms',figfolder,'CondAdLIF')        
        
 
 
 
%% Spiking/Synaptic Properties
%refreactory period, step current
PopParams.sigma = 0;
PopParams.EPopNum = 1;
PopParams.IPopNum = 2;
TimeParams.SimTime = 2000;

t_ref   = [0.5 0.5 0.5 0.2 0.5 1];

PopParams.Wee   = 0;        %E->E weight
PopParams.Wii   = 100;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 100;        %I->E weight
PopParams.Kee   = 0;        %Expected E->E In Degree
PopParams.Kii   = 1;        %Expected I->I In Degree
PopParams.Kie   = 0;        %Expected E->I In Degree
PopParams.Kei   = 2;

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
b_s     = [0.5 0.2 0.1 1 1 1];      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
a       = [0.1 0.1 0.1 0.1 0.3 0.5 ];    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
b_w     = [0.10 0.05 0.02 0.02 0.02 0.02];   %adaptation decay rate (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
b       = [1 1 1 0.5 1 2];    %adaptation activation rate (1/ms) (spike)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Input Current Function: A step function that only effects neuron 1
stepmag = 305;
steptime = [1000 1050];
Inputfun = @(t) [zeros(size(t));zeros(size(t));...
    stepmag.*(t>steptime(1) & t<steptime(2))];
PopParams.I_e = Inputfun;

clear testvals
for ii = 1:6
    PopParams.b = b(ii);
    PopParams.t_ref = t_ref(ii);
    PopParams.b_w     = b_w(ii);
    PopParams.b_s = b_s(ii);
    PopParams.a       = a(ii);
    [testvals(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%% Spiking Properties
spikeneuron = 3;
vrange = [-70 -64];
viewwin = [990 1150];
viewwin2 = [1027.5 1035];
precolors = [0 0 0;0.35 0.35 0.35;0.7 0.7 0.7]; 
figure
    subplot(8,2,1)
        plot(testvals(1).t,testvals(1).Input(spikeneuron,:),'k','linewidth',2)
        box off
        xlim(viewwin)
        ylim([0 stepmag+20])
        ylabel('I');xlabel('t (ms)')
    subplot(4,2,3)
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).V(spikeneuron,:),'k','linewidth',2)
    end
        xlim(viewwin)
        ylim([-70 PopParams.V_th(1)])
        ylabel('V_p_r_e')
        box off
        
    subplot(4,2,5)
        hold on
        for ii = 3:-1:1
            plot(testvals(ii).t,testvals(ii).s(spikeneuron,:),'color',precolors(ii,:),'linewidth',2)
        end
        legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        xlim(viewwin)
        ylabel('s_p_r_e')
        

    subplot(4,2,7)
        hold on
        for ii = 6:-1:4
            plot(testvals(ii).t,testvals(ii).s(spikeneuron,:),'color',precolors(ii-3,:),'linewidth',2)
        end
        xlim(viewwin2)
        legend(num2str(a(6)),num2str(a(5)),num2str(a(4)),'location','west')
        ylabel('s_p_r_e')
        
        
    subplot(4,2,2)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).g_i(1,:),'color',Ecolors(ii,:),'linewidth',2)
    end
    axis tight
    xlim(viewwin);
    legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('g_i_,_p_o_s_t')
    subplot(4,2,4)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).V(1,:),'color',Ecolors(ii,:),'linewidth',2)      
    end
    axis tight
    %legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
    xlim(viewwin);ylim(vrange)
        ylabel('v_p_o_s_t')
        
        
    subplot(4,2,6)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).g_i(2,:),'color',Icolors(ii,:),'linewidth',2)
    end
    axis tight
    xlim(viewwin);
    legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('g_i_,_p_o_s_t')
    subplot(4,2,8)
    hold on
    for ii = 3:-1:1
        plot(testvals(ii).t,testvals(ii).V(2,:),'color',Icolors(ii,:),'linewidth',2)   
    end
    axis tight
    xlim(viewwin);ylim(vrange)
    %legend(num2str(b_s(3)),num2str(b_s(2)),num2str(b_s(1)))
        ylabel('v_p_o_s_t')
        
NiceSave('Ispikeparms',figfolder,'CondAdLIF') 

     %% Adaptation Function
%      w_r = 0.1;
%      b_w = 0.01;
%      E_L = -65;
%      delta_T = 10;
%      V = linspace(-70,-55,100);
%      a_w = w_r.*b_w./(1 - w_r).*exp((V-E_L).*delta_T);
%      plot(V,a_w)
%% Adaptation - gbar


%subthreshold, superthreshold.  show E cell under low mag step current? w
%variable, gW.  membrane potential with reversal potential.
%step currents for sub,super,of diff't values.  sub+super for a select
%intermediate zone
TimeParams.SimTime = 2500;

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

stepmags = 200:10:500;

gvals = [0 7.5 15];
clear w_ss; clear rate_ss; clear rate_0; clear ISIs
for gg = 1:length(gvals)
    PopParams.gwnorm = gvals(gg);
    %Simulate steps (maybe add step option to EMAdLIFfunction?
    for ii = 1:length(stepmags)
        %Input Current Function: A step function that only effects neuron 1
        stepmag = (stepmags(ii));
        steptime = [1000 2000];
        Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2))];
        PopParams.I_e = Inputfun;
        [testvals(ii,gg)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
    end

    % Calculations
    sswin = [1500 2000];
    
    for ii = 1:length(stepmags)
        w_ss(ii,gg) = mean(testvals(ii,gg).w(testvals(ii,gg).t>sswin(1) & testvals(ii,gg).t<sswin(2)));
        ISIs{ii,gg} = diff(testvals(ii,gg).spikes(:,1));
        if isempty(ISIs{ii,gg})
            rate_ss(ii,gg) = 0; rate_0(ii,gg) = 0;
            continue
        end
        rate_ss(ii,gg) = 1./(ISIs{ii,gg}(end)./1000);
        rate_0(ii,gg) = 1./(ISIs{ii,gg}(1)./1000);
    end
    
end
%% Gbar figure
viewwin = [900 2100];
figure
for gg = 1:length(gvals)
    subplot(4,3,gg)
        hold on
        for ii = round(linspace(1,length(stepmags),8))
        plot(testvals(ii,gg).t,testvals(ii,gg).V,'k')
        end
        ylabel('v');%xlabel('t')
        xlim(viewwin)

    subplot(4,3,3+gg)
        hold on
        for ii = round(linspace(1,length(stepmags),8))
        plot(testvals(ii,gg).t,testvals(ii,gg).w,'k')
        end
        ylabel('w');xlabel('t')
        xlim(viewwin)
end    
    
 subplot(4,4,13)
    hold on
    plot(log10([1 300]),log10([1 300]),'k')
    plot(log10(rate_0),log10(rate_ss),'o')
    LogScale('xy',10)
    xlabel('ISI^-^1_0 (Hz)');ylabel('ISI^-^1_s_s (Hz)')
    
subplot(4,4,14)
    plot(stepmags,w_ss,'.-')
    xlabel('Input');ylabel('w_s_s')
    
subplot(4,4,15)
    plot(log10(rate_ss),w_ss,'.-')
    LogScale('x',10)
    xlabel('Rate_s_s (Hz)');ylabel('w_s_s')
    
subplot(4,4,16)
    plot(stepmags,log10(rate_ss),'o')
    hold on
    plot(stepmags,log10(rate_0),'.')
    LogScale('y',10)
    xlabel('Input');ylabel('Rate (Hz)')
    
NiceSave('Adaptation_gbar',figfolder,'CondAdLIF') 


%% Adaptation - b
PopParams.gwnorm = gvals(2);
bvals = [0 1 2];
clear w_ss; clear rate_ss; clear rate_0; clear ISIs
for bb = 1:length(bvals)
    PopParams.b = bvals(bb);
    %Simulate steps (maybe add step option to EMAdLIFfunction?
    for ii = 1:length(stepmags)
        %Input Current Function: A step function that only effects neuron 1
        stepmag = (stepmags(ii));
        steptime = [1000 2000];
        Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2))];
        PopParams.I_e = Inputfun;
        [testvals(ii,bb)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
    end

    % Calculations
    sswin = [1500 2000];
    
    for ii = 1:length(stepmags)
        w_ss(ii,bb) = mean(testvals(ii,bb).w(testvals(ii,bb).t>sswin(1) & testvals(ii,bb).t<sswin(2)));
        ISIs{ii,bb} = diff(testvals(ii,bb).spikes(:,1));
        if isempty(ISIs{ii,bb})
            rate_ss(ii,bb) = 0; rate_0(ii,bb) = 0;
            continue
        end
        rate_ss(ii,bb) = 1./(ISIs{ii,bb}(end)./1000);
        rate_0(ii,bb) = 1./(ISIs{ii,bb}(1)./1000);
    end
    
end
%% b figure
viewwin = [900 2100];
figure
for bb = 1:length(bvals)
    subplot(4,3,bb)
        hold on
        for ii = round(linspace(1,length(stepmags),8))
        plot(testvals(ii,bb).t,testvals(ii,bb).V,'k')
        end
        ylabel('v');%xlabel('t')
        xlim(viewwin)

    subplot(4,3,3+bb)
        hold on
        for ii = round(linspace(1,length(stepmags),8))
        plot(testvals(ii,bb).t,testvals(ii,bb).w,'k')
        end
        ylabel('w');xlabel('t')
        xlim(viewwin)
        
    subplot(4,3,6+bb)
        hold on
        for ii = round(linspace(1,length(stepmags),8))
        plot(testvals(ii,bb).t,testvals(ii,bb).a_w,'k')
        end
        ylabel('w');xlabel('t')
        xlim(viewwin)
end    
    
 subplot(4,4,13)
    hold on
    plot(log10([1 300]),log10([1 300]),'k')
    plot(log10(rate_0),log10(rate_ss),'o')
    LogScale('xy',10)
    xlabel('ISI^-^1_0 (Hz)');ylabel('ISI^-^1_s_s (Hz)')
    
subplot(4,4,14)
    plot(stepmags,w_ss,'.-')
    xlabel('Input');ylabel('w_s_s')
    
subplot(4,4,15)
    plot(log10(rate_ss),w_ss,'.-')
    LogScale('x',10)
    xlabel('Rate_s_s (Hz)');ylabel('w_s_s')
    
subplot(4,4,16)
    plot(stepmags,log10(rate_ss),'o')
    hold on
    plot(stepmags,log10(rate_0),'.')
    LogScale('y',10)
    xlabel('Input');ylabel('Rate (Hz)')
    
NiceSave('Adaptation_jumpb',figfolder,'CondAdLIF') 
    %%
    
    %Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
PopParams.b       = 1;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0.3;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 30; 


for ii = 1:length(stepmags)
%Input Current Function: A step function that only effects neuron 1
stepmag = (stepmags(ii));
steptime = [1000 1500];
Inputfun = @(t) [stepmag.*(t>steptime(1) & t<steptime(2))];
PopParams.I_e = Inputfun;
[testvals(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end



%%

%%
viewwin = [900 1800];
figure
subplot(3,2,1)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).V,'k')
    end
    xlim(viewwin)
    ylabel('V')
    
subplot(3,2,3)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).w,'k')
    end
    xlim(viewwin)
    ylabel('w')
    
subplot(3,2,5)
    hold on
    for ii = 1:length(stepmags)
    plot(testvals(ii).t,testvals(ii).a_w,'k')
    end
    xlim(viewwin)
    ylabel('alpha_w')
    
subplot(2,2,2)
     V = linspace(-70,PopParams.V_th(1),100);
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