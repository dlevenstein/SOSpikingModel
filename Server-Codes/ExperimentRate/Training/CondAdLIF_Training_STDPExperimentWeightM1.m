function CondAdLIF_Training_STDPExperimentWeightM1(mm)

vals = [0.01,0.1,1,10];
names = ["001","01","1","10"];

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';
repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

%Input
PopParams.I_e  = 250;       %External input
PopParams.sigma = 50;        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

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
PopParams.tau_w   = 100;     %subthreshold adaptation steepness
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 1;        %E->E weight (nS)
PopParams.Wii   = 1;        %I->I weight
PopParams.Wie   = 1;        %E->I weight
PopParams.Wei   = 1;        %I->E weight
PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degree

TimeParams.dt      = 0.05;

%%

m = 1;
s = vals(mm);

mu = log((m^2)/sqrt(s+m^2));
sigma = sqrt(log((s/m^2)+1));

%%

numcells = 2000;
 
mTR = -0.1;
sigmaTR = 0.8;
 
%draw the log firing rates from a normal distribution with mean mTR and std sigmaTR
logTRs = mTR + sigmaTR.*(randn(numcells,1));  
TRs = exp(logTRs); %convert log rate to rate
TRs = sort(TRs); %sort the target rates so the neurons will be sorted by target rate
meanTR = mean(TRs) %mean target rate. units: Hz!

%%

EPopNum = PopParams.EPopNum;
IPopNum = PopParams.IPopNum;
PopNum = EPopNum + IPopNum;

EcellidX = 1:EPopNum;
IcellidX = EPopNum+1:PopNum;

W = zeros(PopNum,PopNum);

Pee = PopParams.Kee/(EPopNum-1);
Pii = PopParams.Kii/(IPopNum-1);
Pie = PopParams.Kie/EPopNum;
Pei = PopParams.Kei/IPopNum;

W(EcellidX,EcellidX) = rand(EPopNum,EPopNum) <= Pee;
W(EcellidX,EcellidX) = W(EcellidX,EcellidX);

W(IcellidX,IcellidX) = rand(IPopNum,IPopNum) <= Pii;
W(IcellidX,IcellidX) = PopParams.Wii.*W(IcellidX,IcellidX);

W(IcellidX,EcellidX) = rand(IPopNum,EPopNum) <= Pie;
W(IcellidX,EcellidX) = PopParams.Wie.*W(IcellidX,EcellidX);

W(EcellidX,IcellidX) = rand(EPopNum,IPopNum) <= Pei;
W(EcellidX,IcellidX) = PopParams.Wei.*W(EcellidX,IcellidX);

W(EcellidX,EcellidX) = lognrnd(mu,sigma,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);

W(diag(diag(true(size(W)))))=0;

PopParams.W = W;

%%
SimTime = 5e5;
RecordTime = 1e4;

TimeParams.SimTime = SimTime+RecordTime;

%%

PopParams.LearningRate = 1e-2;
PopParams.TargetRate = TRs; %Target E rate 1Hz
PopParams.tauSTDP = 20;

%%
SimValues = AdLIFfunction_STDP_GPU(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime]);

if SAVESIM==true
    save(['/scratch/jmg1030/FIcurve/data/trainedWeights/ExperimentRate_m_1_s_' char(names(mm))],'-v7.3')
end

end
