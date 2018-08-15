function [] = CondAdLIF_STDP_FIserver(ll)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';

addpath(genpath(repopath))

%%
logNames = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];

%%

load(['/scratch/jmg1030/FIcurve/data/' char(logNames(ll))]);

PopParamsAnalysis = PopParams;
TimeParamsAnalysis = TimeParams;

PopParamsAnalysis.LearningRate = 0;
TimeParamsAnalysis.SimTime = 1e4;

PopParamsAnalysis.W = SimValues.WeightMat(:,:,2);

simfunction = @AdLIFfunction_STDP;
Irange = [0 500];
numI = 36;
    
[ Ivals,rate,voltagemean,SimValues ] = SimulateFICurve(simfunction,PopParamsAnalysis,Irange,numI,'showfig',false);

save(['/scratch/jmg1030/FIcurve/data/UP_Rate_s_' char(Snames(ll)) '.mat'],'-struct','rate','-v7.3')
save(['/scratch/jmg1030/FIcurve/data/UP_Voltagemean_s_' char(Snames(ll)) '.mat'],'-struct','voltagemean','-v7.3')
save(['/scratch/jmg1030/FIcurve/data/UP_SimValues_s_' char(Snames(ll)) '.mat'],'SimValues','-v7.3')

[ Ivals,rate,voltagemean,SimValues ] = SimulateFICurve(simfunction,PopParamsAnalysis,Irange,numI,'showfig',false,'bistableramp',true);

save(['/scratch/jmg1030/FIcurve/data/DOWN_Rate_s_' char(Snames(ll)) '.mat'],'-struct','rate','-v7.3')
save(['/scratch/jmg1030/FIcurve/data/DOWN_Voltagemean_s_' char(Snames(ll)) '.mat'],'-struct','voltagemean','-v7.3')
save(['/scratch/jmg1030/FIcurve/data/DOWN_SimValues_s_' char(Snames(ll)) '.mat'],'SimValues','-v7.3')

end
