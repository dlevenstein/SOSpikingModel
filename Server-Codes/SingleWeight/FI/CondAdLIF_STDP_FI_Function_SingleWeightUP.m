function [] = CondAdLIF_STDP_FI_Function_SingleWeightUP(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["largePopWeight01.mat","largePopWeight03.mat","largePopWeight1.mat","largePopWeight3.mat","largePopWeight10.mat"];
weightNames = ["01","03","1","3","10"];

%%
LL = index;

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);
PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (max(PopParamsAnalysis.E_L)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/';
dataname = ['singleWeight_' char(weightNames(LL)) '_sim_' char(num2str(simnum)) '_UP'];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',true);

end
