
repopath = input('Input the directory path of the SOSpikingModel folder: ','s');

addpath(genpath(repopath))

%%

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degrees

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
W(IcellidX,IcellidX) = W(IcellidX,IcellidX);

W(EcellidX,IcellidX) = rand(EPopNum,IPopNum) <= Pei;
W(EcellidX,IcellidX) = W(EcellidX,IcellidX);

W(EcellidX,EcellidX) = rand(EPopNum,EPopNum) <= Pee;
W(EcellidX,EcellidX) = W(EcellidX,EcellidX);

W(IcellidX,EcellidX) = rand(IPopNum,EPopNum) <= Pie;
W(IcellidX,EcellidX) = W(IcellidX,EcellidX);

%% Weights
w = 1

W(EcellidX,EcellidX) = w.*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = w.*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = 8; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

disp('U(1),Plastic I->I and I->E, Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

W(diag(diag(true(size(W)))))=0;

PopParams.W = W;

%%
SimTime = 1e3;

TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime;

%%
SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',true,...
    'save_weights',SimTime,'save_dt',5e2,'train',true,'useGPU',true);

