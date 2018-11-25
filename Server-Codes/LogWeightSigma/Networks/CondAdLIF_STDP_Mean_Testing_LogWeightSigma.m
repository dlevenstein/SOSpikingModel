function [] = CondAdLIF_STDP_Mean_Testing_LogWeightSigma(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_1.mat","logWeight_s_10.mat"];
weightNames = ["001","01","1","10"];

%%

LL = index;

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;

%%
W = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,end);

Wmean = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));

idInitial   = find(W ~= 0);

Wmean(idInitial) = mean(W(idInitial));

W = SimValues.WeightMat(:,:,end);

W(SimValues.EcellIDX,SimValues.IcellIDX) = Wmean;

PopParamsAnalysis.W = W;

%%

clear SimValues

TimeParams.SimTime = 1e4;

datafolder = '/scratch/jmg1030/FIcurve/data/TestRun/LogWeightSigma/';
dataname = ['logSigmaWeight_Mean_' char(weightNames(LL)) '_testing'];

disp([datafolder dataname]);

SimValues = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);

save([datafolder dataname],'SimValues','-v7.3');

end
