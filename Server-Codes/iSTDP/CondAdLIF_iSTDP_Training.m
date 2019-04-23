%function CondAdLIF_iSTDP_Training(index)

index = 1;

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

SAVESIM = true;
%% Example Neuron Properties

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degrees

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
W(IcellidX,IcellidX) = W(IcellidX,IcellidX);

W(EcellidX,IcellidX) = rand(EPopNum,IPopNum) <= Pei;
W(EcellidX,IcellidX) = W(EcellidX,IcellidX);

W(EcellidX,EcellidX) = rand(EPopNum,EPopNum) <= Pee;
W(EcellidX,EcellidX) = W(EcellidX,EcellidX);

W(IcellidX,EcellidX) = rand(IPopNum,EPopNum) <= Pie;
W(IcellidX,EcellidX) = W(IcellidX,EcellidX);

%%

if index == 1 %U(1)

W(EcellidX,EcellidX) = W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = W(IcellidX,EcellidX);

filename = 'Uniform_w_1_iSTDP';

elseif index == 2 %U(10)

W(EcellidX,EcellidX) = 10.*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = 10.*W(IcellidX,EcellidX);

filename = 'Uniform_w_10_iSTDP';

elseif index == 3 %L(1,10)

m = 1;
s = 10;

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

filename = 'Lognormal_m_1_s_10_iSTDP';

elseif index == 4 %L(10,10)

m = 10;
s = 10;

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

filename = 'Lognormal_m_10_s_10_iSTDP';

end   

W(diag(diag(true(size(W)))))=0;

PopParams.W = W;

%%
SimTime = 1e2;
RecordTime = 0;

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

%%
disp(['/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/' filename])
%save(['/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/' filename],'SimValues','-v7.3')

%end