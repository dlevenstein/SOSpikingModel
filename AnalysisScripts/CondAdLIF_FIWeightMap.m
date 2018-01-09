function [] = CondAdLIF_FIWeightMap(ii)
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
TimeParams.dt      = 0.05;
TimeParams.SimTime = 1000;
PopParams.I_e = 0;

%% Run the FI Curve function to calculate single neuron FI curves
simfunction = @EMAdLIFfunction;

Irange = [0 400];
numI = 36;

%Simulate FI for 20 Weight levels
Jvals = 0:0.5:10;

Jarray = [[1,0,0,0];
          [0,1,0,0];
          [0,0,1,0];
          [0,0,0,1]];
      
Jnames = ['CondAdLIF_JeeFI','CondAdLIF_JeiFI','CondAdLIF_JieFI','CondAdLIF_JiiFI'];

%% Jee
for jj = 1:length(Jvals)
    
Jee = Jarray(ii,1).*Jvals(jj);
Jei = Jarray(ii,2).*Jvals(jj);
Jie = Jarray(ii,3).*Jvals(jj);
Jii = Jarray(ii,4).*Jvals(jj);
synscalefactor = 250; %Puts J in order 1
%(rigorize this, should relate to synaptic effect magnitude)
%synscalefactor should be a synaptic weight value such that with K=1 an
%excitatory synapse is just strong enough to bring a cell to threshold
PopParams.Wee   = Jee.*synscalefactor./sqrt(K);        %E->E weight
PopParams.Wii   = Jii.*synscalefactor./sqrt(K);        %I->I weight
PopParams.Wie   = Jie.*synscalefactor./sqrt(K);        %E->I weight
PopParams.Wei   = Jei.*synscalefactor./sqrt(K);        %I->E weight

[ Ivals,rate,voltagemean ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',[Jnames(ii),'_Jval_',num2str(Jvals(jj))],'figfolder',figfolder);
save([datafolder,'/',Jnames(ii),'_Jval_',num2str(Jvals(jj))],'-struct','rate');
end