function [] = CondAdLIF_STDP_FI_Function(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/newFI/SOSpikingModel';

addpath(genpath(repopath))

%%
logNames = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];

%%
numI = 20;
Ivals = linspace(0,500,numI);

if index <= numI
    
load(['/scratch/jmg1030/FIcurve/data/' char(logNames(1))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

SimulateFICurveServer(PopParamsAnalysis,Ivals,index,'/scratch/jmg1030/newFI/','sigmaVal_0.01')

end

if index > numI && index <= 2*numI
    
load(['/scratch/jmg1030/FIcurve/data/' char(logNames(2))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

SimulateFICurveServer(PopParamsAnalysis,Ivals,index,'/scratch/jmg1030/newFI/','sigmaVal_0.1')

end

if index > 2*numI && index <= 3*numI
    
load(['/scratch/jmg1030/FIcurve/data/' char(logNames(3))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

SimulateFICurveServer(PopParamsAnalysis,Ivals,index,'/scratch/jmg1030/newFI/','sigmaVal_0.5')

end

if index > 3*numI && index <= 4*numI
    
load(['/scratch/jmg1030/FIcurve/data/' char(logNames(4))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

SimulateFICurveServer(PopParamsAnalysis,Ivals,index,'/scratch/jmg1030/newFI/','sigmaVal_1')

end

end
