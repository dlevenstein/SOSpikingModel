function [] = CondAdLIF_STDP_FI_Function_LogWeightSigmaUP(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];
weightNames = ["001","01","05","1"];

%%
LL = index;

disp(['index: ' char(num2str(index))]);

disp(['Sim Number: ' char(num2str(simnum))]);
disp(['File Name: ' char(names(LL))]);

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/';
dataname = ['logSigmaWeight_' char(weightNames(LL)) '_sim_' char(num2str(simnum)) '_UP'];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',true);

end
