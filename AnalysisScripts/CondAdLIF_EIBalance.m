

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures/EIBalance'];

%% Define the Population Parameters to feed the FI Cuve function

%Input Noise
PopParams.sigma = 200;        %niose magnitude: variance
PopParams.theta = 1/5;     %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1600;
PopParams.IPopNum = 400;


%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-55 -55];    %reset potential (mV)
PopParams.t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -70;    %rev potential: I (mV)
PopParams.b_s     = [0.5 0.5];      %synaptic decay timescale (1/ms)
PopParams.a       = 0.3;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
K = 300;
PopParams.Kee   = K;        %Expected E->E In Degree
PopParams.Kii   = K;        %Expected I->I In Degree
PopParams.Kie   = K;        %Expected E->I In Degree
PopParams.Kei   = K;        %Expected I->E In Degree

Jee = 1.1;
Jei = 1.05;
Jie = 1.0;
Jii = 0.9;
synscalefactor = 1000; %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

PopParams.p0spike = 0.000;

%%
TimeParams.dt      = 0.05;
TimeParams.SimTime = 40000;
PopParams.I_e = 350;
[SimValues] = EMAdLIFfunction(PopParams,TimeParams,...
    'showprogress',true,'onsettime',100,'cellout',true,...
    'save_dt',1);


%%
timewin=[1000 1500];
[ corrhist,condx,currx,currPETH ] = CheckBalance( SimValues,PopParams,timewin );
%%
GetSpikeStats( SimValues,PopParams,timewin );
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

%% Calculate E-I input correlation for each cell

eicorr = corr(SimValues.g_e',  SimValues.g_i');

figure
imagesc(eicorr(sortrate.all,sortrate.all))
colorbar
    
%% Run the FI Curve function to calculate single neuron FI curves
simfunction = @EMAdLIFfunction;

Irange = [100 400];
numI = 20;

[ Ivals,rate(ss),voltagemean(ss) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','CondAdLIF_EITest','figfolder',figfolder);

%% Regimes
PopParams.I_e = 225;
[SimValues] = EMAdLIFfunction(PopParams,TimeParams,...
    'showprogress',true,'onsettime',100);

%%
PopParams.I_e = 300;
[SimValues] = EMAdLIFfunction(PopParams,TimeParams,...
    'showprogress',true,'onsettime',100);



%%
sfacts = [50 250 500];
for ss = 1:length(sfacts)
synscalefactor = sfacts(ss); %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

[ Ivals,rate(ss),voltagemean(ss) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',['CondAdLIF_EITest_scale',num2str(synscalefactor)],'figfolder',figfolder);
end

%%
test =CollapseStruct(rate,1);

%%
figure
plot(Ivals,test.E,'k','linewidth',2)

%%
PopParams.I_e = 350;
for ss = 1:length(sfacts)
    synscalefactor = sfacts(ss); %Puts J in order 1
    [SimValues] = EMAdLIFfunction(PopParams,TimeParams,...
        'showprogress',true,'onsettime',100);
end

%% Check some different K values.