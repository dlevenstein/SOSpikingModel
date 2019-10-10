function [] = CondAdLIF_STDP_FI_Function_LogWeightSigmaM1(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%

names = ["logWeight_m_1_s_01.mat","logWeight_m_1_s_1.mat","logWeight_m_1_s_10.mat"];
weightNames = ["01","1","10"];

LL = index;

load(['/scratch/jmg1030/FIcurve/data/trainedWeights/LogWeightSigmaM1/' char(names(LL))]);

%%

for simnum = 1:100
   
rng(simnum,'twister');

PopParamsAnalysis = SimValues.PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)

PopParamsAnalysis.V0 = min(PopParams.E_L) + (min(PopParams.V_th)-min(PopParams.E_L)).*rand(PopParamsAnalysis.EPopNum + PopParamsAnalysis.IPopNum,1);

datafolder = '/scratch/jmg1030/FIcurve/data/bistabilityTest/DOWN/LogWeightSigmaM1/';
dataname = ['logSigmaWeight_m_1_' char(weightNames(LL)) '_sim_' char(num2str(simnum))];

disp([datafolder dataname]);

SimulateFICurve(PopParamsAnalysis,[0 400],21,datafolder,dataname,'up',false);

end
end
