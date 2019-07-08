%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/spikingModel/SOSpikingModel/';

addpath(genpath(repopath))

%%
names = ["ExperimentRate_s_01.mat","ExperimentRate_s_1.mat","ExperimentRate_s_10.mat"];
weightNames = ["01","1","10"];

%%

for index = 1:3

load(['/home/jmg1030/Documents/spikingModel/data/' char(names(index))]);

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

TimeParams.SimTime = 5e4;

datafolder = '/home/jmg1030/Documents/spikingModel/data/';
dataname = ['ExperimentRate_s_' char(weightNames(index)) '_testing'];

disp([datafolder dataname]);

SimValues = AdLIFfunction_STDP_GPU(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime,'save_dt',1);

spikes = SimValues.spikes;

save([datafolder dataname],'spikes','-v7.3');

end