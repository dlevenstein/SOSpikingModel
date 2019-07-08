%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%

load('/home/jmg1030/Documents/spikingModel/data/refractorySynapse/LognormalE_iSTDPI.mat');

for simnum = 1:100
        
rng(simnum,'twister');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = gather(SimValues.WeightMat(:,:,end));

PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (min(PopParamsAnalysis.V_th)-min(PopParamsAnalysis.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

datafolder = '/home/jmg1030/Documents/spikingModel/data/FI/';
dataname = ['logSigmaWeightESynapses_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurveServer(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',false);

end
