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
PopParams.tau_w   = 200;     %subthreshold adaptation steepness
PopParams.gwnorm  = PopParams.g_L(1);       %magnitude of adaptation

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
TimeParams.SimTime = 1e3;

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

%%
TimeParams.SimTime = 1e3;

PopParams.I_e = @(t) 250.*(heaviside(t-100)-heaviside(t-900));
PopParams.b = 1;
PopParams.a = 0;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',TimeParams.dt);

%%
figure

pos = [0.1 0.68 0.8 0.25];
subplot('Position',pos)

t0 = find(single(SimValues.t) == SimValues.spikes(end-1,1));
t1 = find(single(SimValues.t) == SimValues.spikes(end,1));

plot(SimValues.t,SimValues.g_w,'k','LineWidth',2)
hold on
plot(SimValues.t(t0),SimValues.g_w(t0),'.r','MarkerSize',25);
hold on
plot(SimValues.t(t1),SimValues.g_w(t1),'.r','MarkerSize',25);

set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',16)

pos = [0.1 0.39 0.8 0.25];
subplot('Position',pos)

plot(SimValues.t,SimValues.V,'k','LineWidth',2)

set(gca,'xticklabel',[])

ylabel('Voltage (mV)','FontSize',16)

pos = [0.1 0.3 0.8 0.05];
subplot('Position',pos)

plot(SimValues.t,SimValues.Input,'k','LineWidth',2)

ylim([0 400])

set(gca,'yticklabel',[])
xlabel('Time (ms)','FontSize',16);%ylabel('Current (pA)','FontSize',16)

NiceSave('AdaptationExample','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
TimeParams.SimTime = 1e4;

Ivals = linspace(0,400,21);

Rate = zeros(1,length(Ivals));
Adaptation = zeros(1,length(Ivals));

for ii = 1:length(Ivals)

PopParams.I_e = Ivals(ii);
PopParams.b = 1;
PopParams.a = 0;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',TimeParams.dt);

if length(SimValues.spikes(:,1)) > 1
    
    Rate(ii) = 1000./(SimValues.spikes(end,1) - SimValues.spikes(end-1,1));

    t0 = find(single(SimValues.t) == SimValues.spikes(end-1,1));
    t1 = find(single(SimValues.t) == SimValues.spikes(end,1));
    
    Adaptation(ii) = mean(SimValues.g_w(t0:t1));
    CurrentAdaptation(ii) = mean(SimValues.g_w(t0:t1).*(SimValues.V(t0:t1)-PopParams.E_w));

end
    
end

%%
figure

pos = [0.1 0.54 0.8 0.4];
subplot('Position',pos)

plot(Ivals,Adaptation,'.-k','LineWidth',2,'MarkerSize',10)

set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',20)

pos = [0.1 0.1 0.8 0.4];
subplot('Position',pos)

plot(Ivals,Rate,'.-k','LineWidth',2,'MarkerSize',10)

xlabel('Current (pA)','FontSize',20);ylabel('Rate (Hz)','FontSize',20)

NiceSave('CurrentvAdaptation','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
TimeParams.SimTime = 1e4;

avals = 0:0.01:0.1;

Rate = zeros(1,length(avals));
Adaptation = zeros(1,length(avals));
CurrentAdaptation = zeros(1,length(avals));

for aa = 1:length(avals)

PopParams.I_e = 250;
PopParams.b = 0;
PopParams.a = avals(aa);

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',TimeParams.dt);

if length(SimValues.spikes(:,1)) > 1
    
    if SimValues.spikes(end,1) > 5000
        
        Rate(aa) = 1000./(SimValues.spikes(end,1) - SimValues.spikes(end-1,1));

        t0 = find(single(SimValues.t) == SimValues.spikes(end-1,1));
        t1 = find(single(SimValues.t) == SimValues.spikes(end,1));

        Adaptation(aa) = mean(SimValues.g_w(t0:t1));
        CurrentAdaptation(aa) = mean(SimValues.g_w(t0:t1).*(SimValues.g_w(t0:t1)-PopParams.E_w));
        
    else
        
        Rate(aa) = 0;

        t0 = find(single(SimValues.t) == 5000);

        Adaptation(aa) = mean(SimValues.g_w(t0:end));
        CurrentAdaptation(aa) = mean(SimValues.g_w(t0:end).*(SimValues.g_w(t0:end)-PopParams.E_w));
        
    end
    
end
    
end

%%
figure

pos = [0.1 0.54 0.8 0.4];
subplot('Position',pos)

plot(avals,Adaptation,'.-k','LineWidth',2,'MarkerSize',10)

set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',20);title('Subthreshold Adaptation','FontSize',20)

pos = [0.1 0.1 0.8 0.4];
subplot('Position',pos)

plot(avals,Rate,'.-k','LineWidth',2,'MarkerSize',10)

xlabel('Adaptation a','FontSize',20);ylabel('Rate (Hz)','FontSize',20)

NiceSave('SubthresholdAdaptation','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
figure
plot(Rate,Adaptation,'.-k','LineWidth',2,'MarkerSize',10)
xlabel('Rate (Hz)','FontSize',20);ylabel('Adaptation (nS)','FontSize',20)
NiceSave('SubthresholdNullcline','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
figure
plot(Rate,CurrentAdaptation,'.-k','LineWidth',2,'MarkerSize',10)
xlabel('Rate (Hz)','FontSize',20);ylabel('Adaptation (nS)','FontSize',20)

%%

TimeParams.SimTime = 2e4;

bvals = 0:0.1:1;

Rate = zeros(1,length(bvals));
Adaptation = zeros(1,length(bvals));
CurrentAdaptation = zeros(1,length(bvals));

PopParams.tau_w = 200;

for bb = 1:length(bvals)

PopParams.I_e = 250;
PopParams.b = bvals(bb);
PopParams.a = 0;

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',TimeParams.dt);

% figure
% subplot(2,1,1)
% plot(SimValues.t,SimValues.g_w,'k')
% subplot(2,1,2)
% plot(SimValues.t,SimValues.V,'k')

if length(SimValues.spikes(:,1)) > 1
    
    Rate(bb) = 1000./(SimValues.spikes(end,1) - SimValues.spikes(end-1,1));

    t0 = find(single(SimValues.t) == SimValues.spikes(end-1,1));
    t1 = find(single(SimValues.t) == SimValues.spikes(end,1));
    
    Adaptation(bb) = mean(SimValues.g_w(t0:t1));
    CurrentAdaptation(bb) = mean(SimValues.g_w(t0:t1).*(SimValues.g_w(t0:t1)-PopParams.E_w));

end
    
end

%%
figure

pos = [0.1 0.54 0.8 0.4];
subplot('Position',pos)

plot(bvals,log10(Adaptation),'.-k','LineWidth',2,'MarkerSize',10)
LogScale('y',10)
set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',20);title('Spike-Based Adaptation','FontSize',20)

pos = [0.1 0.1 0.8 0.4];
subplot('Position',pos)

plot(bvals,log10(Rate),'.-k','LineWidth',2,'MarkerSize',10)
LogScale('y',10)
xlabel('Adaptation b','FontSize',20);ylabel('Rate (Hz)','FontSize',20)

NiceSave('Spike-BasedAdaptation','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
figure

pos = [0.1 0.54 0.8 0.4];
subplot('Position',pos)

plot(bvals,log10(CurrentAdaptation),'.-k','LineWidth',2,'MarkerSize',10)
LogScale('y',10)
set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',20);title('Spike-Based Adaptation','FontSize',20)

pos = [0.1 0.1 0.8 0.4];
subplot('Position',pos)

plot(bvals,log10(Rate),'.-k','LineWidth',2,'MarkerSize',10)
LogScale('y',10)
xlabel('Adaptation b','FontSize',20);ylabel('Rate (Hz)','FontSize',20)

%NiceSave('Spike-BasedAdaptation','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
figure
plot(Rate,Adaptation,'.-k','LineWidth',2,'MarkerSize',10)
xlabel('Rate (Hz)','FontSize',20);ylabel('Adaptation (nS)','FontSize',20)
%NiceSave('Spike-BasedNullcline','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
figure
plot(Rate,CurrentAdaptation,'.-k','LineWidth',2,'MarkerSize',10)
xlabel('Rate (Hz)','FontSize',20);ylabel('Adaptation (pA)','FontSize',20)
%NiceSave('Spike-BasedNullcline','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%

tau_vals = logspace(-1,3,10);

Rate = zeros(1,length(tau_vals));
Adaptation = zeros(1,length(tau_vals));

TimeParams.SimTime = 1e4;

for tt = 1:length(tau_vals)

PopParams.I_e = 250;
PopParams.b = 1;
PopParams.a = 0;

PopParams.tau_w = tau_vals(tt);

SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',TimeParams.dt);

% figure
% subplot(2,1,1)
% plot(SimValues.t,SimValues.g_w,'k')
% subplot(2,1,2)
% plot(SimValues.t,SimValues.V,'k')

if length(SimValues.spikes(:,1)) > 1
    
    Rate(tt) = 1000./(SimValues.spikes(end,1) - SimValues.spikes(end-1,1));

    t0 = find(single(SimValues.t) == SimValues.spikes(end-1,1));
    t1 = find(single(SimValues.t) == SimValues.spikes(end,1));
    
    Adaptation(tt) = mean(SimValues.g_w(t0:t1));

end
    
end

%%
figure

pos = [0.1 0.54 0.8 0.4];
subplot('Position',pos)

plot(tau_vals,Adaptation,'.-k','LineWidth',2,'MarkerSize',10)

set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',20)

pos = [0.1 0.1 0.8 0.4];
subplot('Position',pos)

plot(tau_vals,log10(Rate),'.-k','LineWidth',2,'MarkerSize',10)
LogScale('y',10)
xlabel('Adaptation Decay (ms)','FontSize',20);ylabel('Rate (Hz)','FontSize',20)

NiceSave('AdaptationDecayAdaptation','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])

%%
figure
plot(Rate,Adaptation,'.-k','LineWidth',2,'MarkerSize',10)
xlabel('Rate (Hz)','FontSize',20);ylabel('Adaptation (nS)','FontSize',20)
NiceSave('TimeDecayNullcline','/Users/jonathangornet/Google Drive/Computational_Neuroscience/Report/Figures/Adaptation',[])
