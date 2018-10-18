function [] = CondAdLIF_STDP_FI_Function_LogWeightMuUP(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/LogWeightMu/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["logWeight_m_03.mat","logWeight_m_01.mat","logWeight_m_1.mat"];
weightNames = ["01","03","1"];

%%

LL = index;

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/';
dataname = ['logMuWeight_' char(weightNames(LL)) '_sim_' char(num2str(ss)) '_UP'];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',true);

end
