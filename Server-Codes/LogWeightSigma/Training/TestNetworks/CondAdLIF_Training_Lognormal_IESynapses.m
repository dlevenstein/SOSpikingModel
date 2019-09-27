
ss = 4;

vals = [0.01,0.1,1,10];
names = ["001","01","1","10"];

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

%Network Properties
PopParams.Wee   = 1;        %E->E weight (nS)
PopParams.Wii   = 1;        %I->I weight
PopParams.Wie   = 1;        %E->I weight
PopParams.Wei   = 1;        %I->E weight
PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degrees

%%

m = 1;
s = vals(ss);

mu = log((m^2)/sqrt(s+m^2));
sigma = sqrt(log((s/m^2)+1));

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

W(IcellidX,IcellidX) = rand(IPopNum,IPopNum) <= Pii;
W(IcellidX,IcellidX) = PopParams.Wii.*W(IcellidX,IcellidX);

W(EcellidX,IcellidX) = rand(EPopNum,IPopNum) <= Pei;
W(EcellidX,IcellidX) = PopParams.Wei.*W(EcellidX,IcellidX);

W(EcellidX,EcellidX) = rand(EPopNum,EPopNum) <= Pee;
W(EcellidX,EcellidX) = W(EcellidX,EcellidX);

W(IcellidX,EcellidX) = rand(IPopNum,EPopNum) <= Pie;
W(IcellidX,EcellidX) = W(IcellidX,EcellidX);

W(EcellidX,EcellidX) = lognrnd(mu,sigma,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(mu,sigma,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

%W(W > 50) = 50;

W(diag(diag(true(size(W)))))=0;

PopParams.W = W;

%%
SimTime = 0;
RecordTime = 1e3;

TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime+RecordTime;

%%

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = 8; %Target E rate 1Hz
PopParams.TargetRateE = 2; %Target I rate 1Hz
PopParams.tauSTDP = 20;

%%
SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',10,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime],'train',true);

SimValues.t_syn = PopParams.t_syn;

%%
save('/home/jmg1030/Documents/spikingModel/data/refractorySynapse/LognormalE_iSTDPI','-v7.3')