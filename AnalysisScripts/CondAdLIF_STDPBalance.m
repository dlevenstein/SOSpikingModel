%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

dropboxpath = '/Users/dlevenstein/Dropbox/Share Folders/DLJG'; 

figfolder = [repopath,'/Figures'];
simfolder = [dropboxpath,'/Simulation_Data'];
SAVESIM = false;
%% Example Neuron Properties

clear PopParams

%Input 
PopParams.I_e  = 250;       %External input
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
PopParams.Wee   = 5;        %E->E weight (nS)
PopParams.Wii   = 5;        %I->I weight
PopParams.Wie   = 5;        %E->I weight
PopParams.Wei   = 5;        %I->E weight
PopParams.Kee   = 100;        %Expected E->E In Degree
PopParams.Kii   = 100;        %Expected I->I In Degree
PopParams.Kie   = 100;        %Expected E->I In Degree
PopParams.Kei   = 100;        %Expected I->E In Degree


TimeParams.dt      = 0.05;

close all
%PopParams.p0spike = 0; %Proportion of neurons spiking in the beginning of the simulation
%% Test Simulation before STDP
%WARNING - THIS SIMULATION TAKES V LONG (or completely fails) if population
%is too unbalanced (i.e. Wei is too low).
TimeParams.SimTime = 1000;
%STDP Properties
PopParams.LearningRate = 0;
PopParams.TargetRate = 1; %Target E rate 1Hz
PopParams.tauSTDP = 20;
SimValues_pre = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,...
    'save_weights',1000,'save_dt',1);

%% Check balance 
timewin = TimeParams.SimTime + [-1000 0];
[ corrhist,condx,currx,currPETH ] = CheckBalance( SimValues_pre,PopParams,timewin);


%%

TimeParams.SimTime = 5000;
%STDP Properties
PopParams.LearningRate = 0.05;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;


tic
SimValues = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,...
    'save_weights',1000,'save_dt',1);
toc

if SAVESIM==true
    save(fullfile(simfolder,'longinhSTDP_fastrate'),'-v7.3')
end

%% Check balance 
timewin = TimeParams.SimTime + [-1000 0];
[ corrhist,condx,currx,currPETH ] = CheckBalance( SimValues,PopParams,timewin);

%% Change in I->E Synaptic Statistics 

EImat = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,:);
AllEIweights = reshape(EImat,[],size(EImat,3));
nosyns = sum(AllEIweights,2)==0;
AllEIweights(nosyns,:) = [];
%Input Mean/Variance
Iinstats.mean = squeeze(mean(EImat,2));
Iinstats.std = squeeze(std(EImat,[],2));

%Output Mean/Variance
Ioutstats.mean = squeeze(mean(EImat,1));
Ioutstats.std = squeeze(std(EImat,[],1));

Iallstats.mean = mean(AllEIweights,1);
Iallstats.std = std(AllEIweights,1);

Iallstats.distbins = linspace(0,75,75);
Iallstats.dist = hist(AllEIweights,Iallstats.distbins);

%Change in weights dw/dt
Iallstats.dwbins = linspace(-20,100,121);
dw = diff(AllEIweights,1,2);

Iallstats.dwhist = hist(dw,Iallstats.dwbins);
Iallstats.dwmean = mean(dw,1);
Iallstats.dwstd = std(dw,1);

%%
figure
    subplot(4,1,1)
        plot(Iinstats.mean')
    subplot(4,1,2)
        plot(Iinstats.std')
    subplot(4,1,3)
        plot(Ioutstats.mean')
    subplot(4,1,4)
        plot(Ioutstats.std')
        
figure
    subplot(4,2,1)
        plot(Iallstats.mean)
        ylabel('Mean I->E Weight')
        axis tight
    subplot(4,2,3)
        plot(Iallstats.std)
        ylabel('Std I->E Weight')
        axis tight
    subplot(2,2,3)
        imagesc(Iallstats.dist)
        axis xy
        %colorbar
        caxis([0 0.5e4])
        xlabel('t')
        ylabel('I->E Weight Distribution')
        
    subplot(1,2,2)
        plot(Iallstats.distbins,Iallstats.dist(:,1))
        hold on
        plot(Iallstats.distbins,Iallstats.dist(:,11))
        plot(Iallstats.distbins,Iallstats.dist(:,21))
        plot(Iallstats.distbins,Iallstats.dist(:,31))
        plot(Iallstats.distbins,Iallstats.dist(:,41))
        legend('t=0','t=10','t=20','t=30','t=40','location','northeast')
        xlabel('I->E Weight');ylabel('# Synapses')

%%
figure
subplot(2,2,1)
    imagesc(log10(Iallstats.dwhist))
    axis xy
subplot(4,2,2)
    plot(Iallstats.dwmean)
subplot(4,2,4)
    plot(Iallstats.dwstd)


%%
figure
plot(dw')
%%
figure
subplot(3,1,1)
    plot(squeeze(SimValues.WeightMat(1,SimValues.IcellIDX,:))','r')
    title('Example Exc Cell')
    ylabel('I->E Input Weights')
    axis tight
subplot(3,1,2)
    plot(SimValues.g_e(1,:),'k')
    hold on
    plot(SimValues.g_i(1,:),'r')
    axis tight
    ylabel('Input Conductances')
subplot(3,1,3)
    plot(SimValues.V(1,:),'k')
    ylabel('Vm')
    %ylim([-80 0])
axis tight



figure
subplot(3,1,1)
    plot(squeeze(SimValues.WeightMat(SimValues.EcellIDX,end,:))','r')
    title('Example Inh Cell')
    ylabel('I->E Output Weights')
    axis tight
subplot(3,1,2)
    plot(SimValues.g_e(end,:),'k')
    hold on
    plot(SimValues.g_i(end,:),'r')
    axis tight
    ylabel('Input Conductances')
subplot(3,1,3)
    plot(SimValues.V(end,:),'k')
    %ylim([-80 0])
    axis tight
    ylabel('Vm')


%%
timewin = TimeParams.SimTime+[-1000 0];
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

