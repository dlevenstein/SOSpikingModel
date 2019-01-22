function [] = CondAdLIF_STDP_Testing_ExperimentRateMean(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["ExperimentRate_m_01.mat","ExperimentRate_m_03.mat","ExperimentRate_m_1.mat","ExperimentRate_m_3.mat","ExperimentRate_m_10.mat"];
weightNames = ["01","03","1","3","10"];

%%

LL = index;

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

TimeParams.SimTime = 1e4;

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/UP/ExperimentRateMean/';
dataname = ['ExperimentRate_m_' char(weightNames(LL)) '_testing'];

disp([datafolder dataname]);

SimValues = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);

save([datafolder dataname],'SimValues','-v7.3');

end
