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

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/' char(names(LL))]);

%Adaptation Properties (No adaptation)
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.a       = 0;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.tau_w   = 100;     %subthreshold adaptation steepness
PopParams.gwnorm  = 0;       %magnitude of adaptation

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/UP/LogWeightSigma/';
dataname = ['logSigmaWeight_' char(weightNames(LL)) '_UP'];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',true);

end
