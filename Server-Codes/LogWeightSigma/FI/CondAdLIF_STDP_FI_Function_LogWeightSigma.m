function [] = CondAdLIF_STDP_FI_Function_LogWeightSigma(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/LogWeightSigma/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];
weightNames = ["001","01","05","1"];

%%
numI = 20;
numS = 100;
numL = length(names);

ss = mod(index,numS);
LL = ceil(index/numS);

if ss == 0
    ss = numS;
end

disp(['index: ' char(num2str(index))]);

disp(['Sim Number: ' char(num2str(ss))]);
disp(['File Name: ' char(names(LL))]);

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/';
dataname = ['logSigmaWeight_' char(weightNames(LL)) '_sim_' char(num2str(ss))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'ramp','DOWN');

end
