function [] = CondAdLIF_STDP_FI_Function_ExperimentRateM1(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
% names = ["ExperimentRate_s_001.mat","ExperimentRate_s_01.mat","ExperimentRate_s_1.mat","ExperimentRate_s_10.mat",];
% weightNames = ["001","01","1","10"];

names = ["ExperimentRate_m_1_s_01.mat","ExperimentRate_m_1_s_1.mat","ExperimentRate_m_1_s_10.mat",];
weightNames = ["01","1","10"];

%%
numI = 20;
numS = 100;
numL = length(names);

simnum = mod(index,numS);
LL = ceil(index/numS);

if simnum == 0
    simnum = numS;
end

disp(['index: ' char(num2str(index))]);

disp(['Sim Number: ' char(num2str(simnum))]);
disp(['File Name: ' char(names(LL))]);

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/ExperimentRate/' char(names(LL))]);

rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/ExperimentRateM1/';
dataname = ['ExperimentRate_m_1_' char(weightNames(LL)) '_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',false);

end
