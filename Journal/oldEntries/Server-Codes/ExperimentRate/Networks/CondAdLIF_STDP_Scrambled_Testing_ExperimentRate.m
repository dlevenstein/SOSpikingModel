function [] = CondAdLIF_STDP_Scrambled_Testing_ExperimentRate(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["ExperimentRate_s_001.mat","ExperimentRate_s_01.mat","ExperimentRate_s_1.mat","ExperimentRate_s_10.mat"];
weightNames = ["001","01","1","10"];

%%

LL = index;

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;

%%
W = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,end);

Wscrambled = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));

idInitial   = find(W ~= 0);
idScrambled = idInitial(randperm(length(idInitial)));

Wscrambled(idInitial) = W(idScrambled);

W = SimValues.WeightMat(:,:,end);

W(SimValues.EcellIDX,SimValues.IcellIDX) = Wscrambled;

PopParamsAnalysis.W = W;

%%

clear SimValues

TimeParams.SimTime = 1e4;

datafolder = '/scratch/jmg1030/FIcurve/data/TestRun/ExperimentRate/';
dataname = ['ExperimentRate_Scrambled_' char(weightNames(LL)) '_testing'];

disp([datafolder dataname]);

SimValues = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);

save([datafolder dataname],'SimValues','-v7.3');

end
