function [] = CondAdLIF_STDP_AdaptvCurrent(index)

repopath = '/scratch/jmg1030/AdaptvCurrent/SOSpikingModel';

addpath(genpath(repopath));

%%
logNames = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];

load(['/scratch/jmg1030/FIcurve/data/' char(logNames(4))],'SimValues');
load(['/scratch/jmg1030/FIcurve/data/' char(logNames(4))],'PopParams');
%%
PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 50;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

numI = 20;
numb = 50;

ii = mod(index,numI);
bb = ceil(index/numI);

if ii == 0 
    ii = numI;
end

SimulateAdaptvCurrent(@AdLIFfunction_STDP,PopParamsAnalysis,[0 500],numI,[0 100],numb,ii,bb,'datafolder','/scratch/jmg1030/AdaptvCurrent/data/','dataname','LogWeight_s_1');

end