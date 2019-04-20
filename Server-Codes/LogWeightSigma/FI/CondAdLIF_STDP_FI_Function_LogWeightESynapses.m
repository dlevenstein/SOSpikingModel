function [] = CondAdLIF_STDP_FI_Function_LogWeightESynapses(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%

load('/scratch/jmg1030/FIcurve/data/trainedWeights/LogWeightSigma/LognormalE_iSTDPI.mat');

for simnum = 1:100
    
if mod(simnum,4)+1 == index
    
rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = gather(SimValues.WeightMat(:,:,end));

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/LogWeightESynapses/';
dataname = ['logSigmaWeightESynapses_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',false);

end
end
end
