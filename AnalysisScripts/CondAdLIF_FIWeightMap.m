%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures/EIBalance'];
datafolder = [repopath,'/Data/FImapData'];

%% Define the Population Parameters to feed the FI Cuve function

%Input Noise
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

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
K = 100;
PopParams.Kee   = K;        %Expected E->E In Degree
PopParams.Kii   = K;        %Expected I->I In Degree
PopParams.Kie   = K;        %Expected E->I In Degree
PopParams.Kei   = K;        %Expected I->E In Degree

PopParams.p0spike = 0.15;

%%
TimeParams.dt      = 5;
TimeParams.SimTime = 500;
PopParams.I_e = 250;

%% Run the FI Curve function to calculate single neuron FI curves
simfunction = @EMAdLIFfunction;

Irange = [0 400];
numI = 36;

%Simulate FI for 20 Weight levels
Jvals = 0:1:20;

%% Jee
for jj = 1:length(Jvals)
    
Jee = Jvals(jj);
Jei = 0;
Jie = 0;
Jii = 0;
synscalefactor = 300; %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

[ Ivals,rate(jj),voltagemean(jj) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',['CondAdLIF_JeeFI',num2str(Jvals(jj))],'figfolder',figfolder);
end
save([datafolder,'/CondAdLIF_JeeFI'],'-struct','rate');
%% Jei
for jj = 1:length(Jvals)
    
Jee = 0;
Jei = Jvals(jj);
Jie = 0;
Jii = 0;
synscalefactor = 300; %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

[ Ivals,rate(jj),voltagemean(jj) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',['CondAdLIF_JeiFI',num2str(Jvals(jj))],'figfolder',figfolder);
end
save([datafolder,'/CondAdLIF_JeiFI'],'-struct','rate');

%% Jie
for jj = 1:length(Jvals)
    
Jee = 0;
Jei = 0;
Jie = Jvals(jj);
Jii = 0;
synscalefactor = 300; %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

[ Ivals,rate(jj),voltagemean(jj) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',['CondAdLIF_JieFI',num2str(Jvals(jj))],'figfolder',figfolder);
end
save([datafolder,'/CondAdLIF_JieFI'],'-struct','rate');

%% Jii
for jj = 1:length(Jvals)
    
Jee = 0;
Jei = 0;
Jie = 0;
Jii = Jvals(jj);
synscalefactor = 300; %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

[ Ivals,rate(jj),voltagemean(jj) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',['CondAdLIF_JiiFI',num2str(Jvals(jj))],'figfolder',figfolder);
end
save([datafolder,'/CondAdLIF_JiiFI'],'-struct','rate');