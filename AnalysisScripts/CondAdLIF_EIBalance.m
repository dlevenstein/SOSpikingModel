

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures/EIBalance'];

%% Define the Population Parameters to feed the FI Cuve function

%Input Noise
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 800;
PopParams.IPopNum = 200;

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
PopParams.b_s     = 0.5;      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
PopParams.a       = 0.3;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Network Properties
K = 50;
PopParams.Kee   = K;        %Expected E->E In Degree
PopParams.Kii   = K;        %Expected I->I In Degree
PopParams.Kie   = K;        %Expected E->I In Degree
PopParams.Kei   = K;        %Expected I->E In Degree

Jee = 1;
Jei = 1;
Jie = 1;
Jii = 1;
synscalefactor = 100; %Puts J in order 1 (rigorize this, should relate to synaptic effect magnitude)
PopParams.Wee   = synscalefactor.*Jee./sqrt(K);        %E->E weight
PopParams.Wii   = synscalefactor.*Jei./sqrt(K);        %I->I weight
PopParams.Wie   = synscalefactor.*Jie./sqrt(K);        %E->I weight
PopParams.Wei   = synscalefactor.*Jii./sqrt(K);        %I->E weight

PopParams.p0spike = 0.1;

%%
TimeParams.dt      = 0.01;
TimeParams.SimTime = 500;
PopParams.I_e = 200;
[SimValues] = EMAdLIFfunction(PopParams,TimeParams,'showprogress',true);

%%
Excellidx = {SimValues.EcellIDX(1),SimValues.IcellIDX(1)};
Excelltype = {'E','I'};
for ee = 1:length(Excellidx)
    exNeu.(Excelltype{ee}).I = SimValues.Input(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).V = SimValues.V(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).g_e = SimValues.g_e(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).g_i = SimValues.g_i(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).I_syne = -exNeu.E.g_e.*(exNeu.E.V-PopParams.E_e);
    exNeu.(Excelltype{ee}).I_syni = -exNeu.E.g_i.*(exNeu.E.V-PopParams.E_i);
end


figure
subplot(3,1,1)
    plot(SimValues.t,exNeu.E.g_e,'k')
    hold on
    plot(SimValues.t,exNeu.E.g_i,'r')
    ylabel('Synaptic Conductance')
subplot(3,1,2)
    plot(SimValues.t,exNeu.E.I_syne,'k')
    hold on
    plot(SimValues.t,exNeu.E.I_syni,'r')
    plot(SimValues.t,exNeu.E.I,'k')
    ylabel('Synaptic Currents')
subplot(3,1,3)
    plot(SimValues.t,exNeu.E.V,'k')
    ylabel('Vm')
    xlabel('t (ms)')



%% Run the FI Curve function to calculate single neuron FI curves
simfunction = @EMAdLIFfunction;

Irange = [100 300];
numI = 10;

[ Ivals,rate(ss),voltagemean(ss) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','CondAdLIF_EITest','figfolder',figfolder);


