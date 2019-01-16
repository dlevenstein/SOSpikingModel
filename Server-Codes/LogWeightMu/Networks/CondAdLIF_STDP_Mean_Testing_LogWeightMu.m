function [] = CondAdLIF_STDP_Mean_Testing_LogWeightMu(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["logWeight_m_03.mat","logWeight_m_01.mat","logWeight_m_1.mat","logWeight_m_3.mat","logWeight_m_10.mat"];
weightNames = ["01","03","1","3","10"];

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

datafolder = '/scratch/jmg1030/FIcurve/data/TestRun/LogWeightMu/';
dataname = ['logMuWeight_Mean_' char(weightNames(LL)) '_testing'];

disp([datafolder dataname]);

SimValues = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);

save([datafolder dataname],'SimValues','-v7.3');

end
