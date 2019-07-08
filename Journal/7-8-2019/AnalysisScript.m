%% Journal Entry 

addpath(genpath('/scratch/jmg1030/FIcurve/SOSpikingModel'));
addpath(genpath('/scratch/jmg1030/FIcurve/buzcode'));

path = '/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/LognormalEE_UniformRates/';
Irange = [150 300];
numI = 46;
barray = -2:0.2:4;

analyzedVals = AdaptationAnalysis(path,Irange,numI,barray);

save([path 'AnalyzedAdaptationValues'],'analyzedVals','-v7.3');

