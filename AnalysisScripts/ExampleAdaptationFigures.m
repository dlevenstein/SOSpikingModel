
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
for ii = 1:21
for bb = 1:10
    
    name = ['AdaptationVCurrent_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'];
    data = dir(name);
    
    if length(data) > 0
    if log10(data.bytes) < 9
    
    %%
    load(name)
    
    EcellIDX = 1:2000;
    IcellIDX = 2001:2500;

    spikesbycell = spikeSorter(SimValuesSave.spikes,1,2500);

    dt = 5;   overlap = 5;   winsize = dt.*overlap;
    [spikemat,t_rate,~] = SpktToSpkmat(spikesbycell, [], dt,overlap);
    poprate.E = sum(spikemat(:,EcellIDX),2)./(winsize./1000)./length(EcellIDX);
    poprate.I = sum(spikemat(:,IcellIDX),2)./(winsize./1000)./length(IcellIDX);

    meanAdaptation = mean(SimValuesSave.g_w(EcellIDX,:));
    AdaptationExample = SimValuesSave.g_w(500,:);
    
    CurrentE = SimValuesSave.g_e(500,:).*(SimValuesSave.V(500,:)-PopParams.E_e);
    CurrentI = SimValuesSave.g_i(500,:).*(SimValuesSave.V(500,:)-PopParams.E_i);
    CurrentA = SimValuesSave.g_w(500,:).*(SimValuesSave.V(500,:)-PopParams.E_w);

    t = 0:1e4;

    figure

    pos = [0.08,0.54,0.4,0.20];
    subplot('position',pos)
    plot(SimValuesSave.spikes(:,1)./1e3,SimValuesSave.spikes(:,2),'.k','MarkerSize',1)
    xlim([8 10]);ylim([0 2500])

    set(gca,'XTickLabel',[]);set(gca,'YTickLabel',[])
    pos = [0.08,0.32,0.4,0.20];
    subplot('position',pos)
    plot(t_rate./1e3,poprate.E,'b')
    hold on
    plot(t_rate./1e3,poprate.I,'r')
    ylabel('Rate (Hz)')
    xlim([8 10])
    
    set(gca,'XTickLabel',[]);set(gca,'YTickLabel',[])
    pos = [0.08,0.1,0.4,0.20];
    subplot('position',pos)
    plot(t./1e3,meanAdaptation,'k')
    ylabel('Rate (Hz)')
    xlim([8 10])
    xlabel('Time (sec)')

    pos = [0.58,0.54,0.4,0.20];
    subplot('position',pos)
    plot(t./1e3,AdaptationExample,'k')
    ylabel('Conductance (nS)')
    xlim([8 10])

    set(gca,'XTickLabel',[])
    pos = [0.58,0.32,0.4,0.20];
    subplot('position',pos)
    plot(t./1e3,CurrentA,'k')
    ylabel('Current (pA)')
    xlim([8 10])

    set(gca,'XTickLabel',[])
    pos = [0.58,0.1,0.4,0.20];
    subplot('position',pos)
    plot(t./1e3,CurrentE,'b')
    hold on
    plot(t./1e3,CurrentI,'r')
    ylabel('Current (pA)')
    xlim([8 10])
    xlabel('Time (sec)')
    
%     NiceSave(['AdaptationExampleFigure_ii_' num2str(ii) '_bb_' num2str(bb)],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/01-31-2019/figures',[])
%     close all
%     
%     clearvars -except bb ii PopParams
    
    end
    end
    
end
end

