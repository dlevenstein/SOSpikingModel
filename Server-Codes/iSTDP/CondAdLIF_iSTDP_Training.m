function CondAdLIF_iSTDP_Training(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%

if index == 1 %U(1)

clear PopParams

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

filename = 'Uniform_w_1_iSTDP';

disp('U(1),Plastic I->I and I->E, Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

elseif index == 2 %U(10)

clear PopParams

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
w = 10

W(EcellidX,EcellidX) = w.*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = w.*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = 8; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Uniform_w_10_iSTDP';

disp('U(10),Plastic I->I and I->E, Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

elseif index == 3 %L(1,10)

clear PopParams

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
m = 1
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = 8; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_1_s_10_iSTDP';

disp('L(1,10),Plastic I->I and I->E, Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

elseif index == 4 %L(10,10)

clear PopParams

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
m = 10
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = 8; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_10_s_10_iSTDP';

disp('L(10,10),Plastic I->I and I->E, Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

elseif index == 5 %U(1), Static I->I

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 500;        %Expected E->I In Degree
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
PopParams.TargetRateI = nan; %static I->I
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Uniform_w_1_iSTDP_IE_indegree_500';

disp('U(1),Plastic I->E, Indegree 250 E->E, 250 I->I, 500 E->I, 250 I->E')

PopParams

elseif index == 6 %L(1,10) Indegree 500

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 500;        %Expected E->I In Degree
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
m = 1
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = nan; %static I->I
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_1_s_10_iSTDP_IE_indegree_500';

disp('L(1,10),Plastic I->E, Indegree 250 E->E, 250 I->I, 500 E->I, 250 I->E')

PopParams

elseif index == 7 %L(1,10) Indegree 500

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 500;        %Expected E->I In Degree
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
m = 1
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = 8; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_1_s_10_iSTDP_IE_indegree_500_plastic';

disp('L(1,10),Plastic I->I and I->E, Indegree 250 E->E, 250 I->I, 500 E->I, 250 I->E')

PopParams

elseif index == 8 %L(1,10) Indegree 500

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 500;        %Expected E->I In Degree
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
m = 1
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

numcells = 2000;
 
mTR = -0.1
sigmaTR = 0.8
 
%draw the log firing rates from a normal distribution with mean mTR and std sigmaTR
logTRs = mTR + sigmaTR.*(randn(numcells,1));  
TRs = exp(logTRs); %convert log rate to rate
TRs = sort(TRs); %sort the target rates so the neurons will be sorted by target rate
meanTR = mean(TRs) %mean target rate. units: Hz!

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = nan; %static I->I
PopParams.TargetRateE = TRs; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_1_s_10_iSTDP_IE_indegree_500_Experimental';

disp('L(1,10),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 500 E->I, 250 I->E')

PopParams

elseif index == 9 %U(1)

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 1000;        %Expected E->I In Degree
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
PopParams.TargetRateI = nan; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Uniform_w_1_K_IE_1000';

disp('U(1),Plastic I->E, Indegree 250 E->E, 250 I->I, 1000 E->I, 250 I->E')

PopParams

elseif index == 10 %L(1,10) for E->E and E->I

clear PopParams

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

m = 1
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = nan; %Target I rate 8Hz
PopParams.TargetRateE = 2; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_1_s_10_EE_IE';

disp('L(1,10),Plastic I->E, Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

elseif index == 11 %U(1)

clear PopParams

% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 1000;        %Expected E->I In Degree
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

numcells = 2000;
 
mTR = -0.1
sigmaTR = 0.8
 
%draw the log firing rates from a normal distribution with mean mTR and std sigmaTR
logTRs = mTR + sigmaTR.*(randn(numcells,1));  
TRs = exp(logTRs); %convert log rate to rate
TRs = sort(TRs); %sort the target rates so the neurons will be sorted by target rate
meanTR = mean(TRs) %mean target rate. units: Hz!

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = nan; %Target I rate 8Hz
PopParams.TargetRateE = TRs; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Uniform_w_1_K_IE_1000_ExperimentalRates';

disp('U(1),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 1000 E->I, 250 I->E')

PopParams

elseif index == 12 %L(1,10) Experimental Rates

clear PopParams

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
m = 1
s = 10

M = log((m^2)/sqrt(s+m^2));
S = sqrt(log((s/m^2)+1));

W(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*W(EcellidX,EcellidX);
W(IcellidX,EcellidX) = lognrnd(M,S,[IPopNum,EPopNum]).*W(IcellidX,EcellidX);

numcells = 2000;
 
mTR = -0.1
sigmaTR = 0.8
 
%draw the log firing rates from a normal distribution with mean mTR and std sigmaTR
logTRs = mTR + sigmaTR.*(randn(numcells,1));  
TRs = exp(logTRs); %convert log rate to rate
TRs = sort(TRs); %sort the target rates so the neurons will be sorted by target rate
meanTR = mean(TRs) %mean target rate. units: Hz!

PopParams.LearningRate = 1e-2;
PopParams.TargetRateI = nan; %Target I rate 8Hz
PopParams.TargetRateE = TRs; %Target E rate 2Hz
PopParams.tauSTDP = 20;

filename = 'Lognormal_m_1_s_10_EE_IE_ExperimentalRates';

disp('L(1,10),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E')

PopParams

end   

W(diag(diag(true(size(W)))))=0;

PopParams.W = W;

%%
SimTime = 5e5;
RecordTime = 1e4;

TimeParams.dt   = 0.05;
TimeParams.SimTime = SimTime+RecordTime;

%%
SimValues = AdLIFfunction_iSTDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',5e2,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime],'train',true,'useGPU',true);

%%
%disp(['/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/' filename])
%save(['/scratch/jmg1030/FIcurve/data/iSTDPTrainedWeights/' filename],'SimValues','-v7.3')
save(['/home/jmg1030/Documents/spikingModel/data/iSTDPTrainedWeights/iSTDPTrainedWeights/' filename],'SimValues','-v7.3')

end