function [] = CondAdLIF_STDP_FI_Function(index)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/scratch/jmg1030/meanFI/SOSpikingModel';

addpath(genpath(repopath))

%%
%logNames = ["logWeight_s_001.mat","logWeight_s_01.mat","logWeight_s_05.mat","logWeight_s_1.mat"];
meanNames = ["largePopWeight01.mat","largePopWeight03.mat","largePopWeight1.mat","largePopWeight3.mat","largePopWeight10.mat"];
%Lnames = ["001","01","05","1"];
Mnames = ["01","03","1","3","10"];

%%
numI = 20;
numS = 100;
numL = length(meanNames);

Ivals = linspace(0,400,numI);

ss = mod(index,numS);
LL = ceil(index/numS);

if ss == 0
    ss = numS;
end

disp(['index: ' char(num2str(index))]);
disp(['ss: ' char(num2str(ss))]);
disp(['ii: ' char(num2str(ii))]);
disp(['LL: ' char(num2str(LL))]);

load(['/scratch/jmg1030/FIcurve/data/' char(meanNames(LL))]);

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
    SimValuesArray(ii) = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_weights',TimeParams.SimTime);
    
end

for ii = 1:numI
    
    ss = mod(index,numS);
    LL = ceil(index/numS);

    if ss == 0
        ss = numS;
    end

    spikes         = SimValuesArray(ii).spikes;
    SimValuesIndex = SimValuesArray(ii);
    
    disp(['index: ' char(num2str(index))]);
    disp(['ss: ' char(num2str(ss))]);
    disp(['ii: ' char(num2str(ii))]);
    disp(['LL: ' char(num2str(LL))]);
    
    disp(['/scratch/jmg1030/meanFI/data/MeanWeight_Spikes_' char(Mnames(LL)) '_ii_' char(num2str(ii)) '_sim_' char(num2str(ss)) '.mat']);
    disp(['/scratch/jmg1030/meanFI/data/MeanWeight_Simvalues_' char(Mnames(LL)) '_ii_' char(num2str(ii)) '_sim_' char(num2str(ss)) '.mat']);
    
    save(['/scratch/jmg1030/meanFI/data/MeanWeight_Spikes_' char(Mnames(LL)) '_ii_' char(num2str(ii)) '_sim_' char(num2str(ss)) '.mat'],'spikes','-v7.3');
    save(['/scratch/jmg1030/meanFI/data/MeanWeight_Simvalues_' char(Mnames(LL)) '_ii_' char(num2str(ii)) '_sim_' char(num2str(ss)) '.mat'],'-struct','SimValuesIndex','-v7.3');
    
end

end
