function [] = CondAdLIF_STDP_FI_Function(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/newFI/SOSpikingModel';

addpath(genpath(repopath))

%%
logNames = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];
Lnames = ["001","01","05","1"];

%%
numI = 20;
numS = 200;
numL = 4;

Ivals = linspace(0,400,numI);

ss = mod(index,numS)
LL = ceil(index/numS);

if ss == 0
    ss = numS
end

disp(['ss: ' char(num2str(ss))]);

load(['/scratch/jmg1030/FIcurve/data/' char(logNames(LL))]);

TimeParams.SimTime = 2500;
TimeParams.dt = 0.05;

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

clear SimValues

parfor ii = 1:numI
    ii
    PopParms = PopParamsAnalysis;
    PopParms.I_e = @(t) (400 - Ivals(ii)).*heaviside(250 - t)+Ivals(ii);
    [SimValuesArray(ii)] = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_weights',TimeParams.SimTime);
end

for ii = 1:numI
    
spikes         = SimValuesArray(ii).spikes;
SimValuesIndex = SimValuesArray(ii);

save(['/scratch/jmg1030/newFI/data/LogWeight_Spikes_' char(Lnames(LL)) '_ii_' char(num2str(ii)) '_sim_' char(num2str(ss)) '.mat'],'spikes','-v7.3');
save(['/scratch/jmg1030/newFI/data/LogWeight_Simvalues_' char(Lnames(LL)) '_ii_' char(num2str(ii)) '_sim_' char(num2str(ss)) '.mat'],'-struct','SimValuesIndex','-v7.3');

clear SimValuesIndex

end

end
