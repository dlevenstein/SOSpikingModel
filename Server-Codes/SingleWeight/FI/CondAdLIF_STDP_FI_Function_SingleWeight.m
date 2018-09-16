function [] = CondAdLIF_STDP_FI_Function_SingleWeight(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/SingleWeight/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["largePopWeight01.mat","largePopWeight03.mat","largePopWeight1.mat","largePopWeight3.mat","largePopWeight10.mat"];
weightNames = ["01","03","1","3","10"];

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

load(['/scratch/jmg1030/SingleWeight/data/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

datafolder = '/scratch/jmg1030/SingleWeight/data/';
dataname = ['singleWeight_' char(weightNames(LL)) '_sim_' char(num2str(ss))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,ramp,'DOWN');

end
