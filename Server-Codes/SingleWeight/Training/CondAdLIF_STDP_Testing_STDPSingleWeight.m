function [] = CondAdLIF_STDP_Testing_STDPSingleWeight(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/spikingModel/SOSpikingModel';

addpath(genpath(repopath))

%%
names = ["UniformWeight_w_1.mat","UniformWeight_w_03.mat","UniformWeight_w_1.mat","UniformWeight_w_3.mat","UniformWeight_w_10.mat","UniformWeight_w_30.mat"];
weightNames = ["01","03","1","3","10","30"];

%%

LL = index;

load(['/home/jmg1030/Documents/spikingModel/data/' char(names(LL))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

TimeParams.SimTime = 1e4;

datafolder = '/home/jmg1030/Documents/spikingModel/data/';
dataname = ['UniformWeight_w_' char(weightNames(LL)) '_testing'];

disp([datafolder dataname]);

SimValues = AdLIFfunction_STDP_GPU(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);

save([datafolder dataname],'SimValues','-v7.3');

end
