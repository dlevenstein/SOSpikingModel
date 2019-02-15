%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
repopath = '/home/jmg1030/SOSpikingModel';

addpath(genpath(repopath))

figfolder = [repopath,'/Figures/Bistability'];
datafolder = [repopath,'/Data/Bistability/FImap'];

%%

load([repopath '/Data/Bistability/bistability_weight-1.mat');

simfunction = @AdLIFfunction_STDP;
PopParams.W = SimValues.WeightMat(:,:,end);

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

Irange = [0 400];
numI = 36;

[ Ivals,rate,voltagemean ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','bistability_weight-1','figfolder',figfolder);

%%
load([repopath '/Data/Bistability/bistability_weight-3.mat');

simfunction = @AdLIFfunction_STDP;
PopParams.W = SimValues.WeightMat(:,:,end);

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

Irange = [0 400];
numI = 36;

[ Ivals,rate,voltagemean ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','bistability_weight-3','figfolder',figfolder);

%%
load([repopath '/Data/Bistability/bistability_weight-10.mat');

simfunction = @AdLIFfunction_STDP;
PopParams.W = SimValues.WeightMat(:,:,end);

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

Irange = [0 400];
numI = 36;

[ Ivals,rate,voltagemean ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','bistability_weight-10','figfolder',figfolder);