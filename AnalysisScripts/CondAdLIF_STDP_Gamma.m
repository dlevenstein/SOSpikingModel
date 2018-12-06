meanWeights = ["01","03","1","3","10"];
stdWeights = ["001","01","1","10"];

UniformMean = zeros(2,length(meanWeights));
LogMuMean = zeros(2,length(meanWeights));

LogSigmaMean = zeros(2,length(stdWeights));
ExperimentRateMean = zeros(2,length(stdWeights));

g_L     = [182/18 119/8];

for ii = 1:length(meanWeights)
    
    load(['UniformWeight_' char(meanWeights(ii)) '_testing.mat']);
   
    UniformMean(1,ii) = mean(mean(1+SimValues.g_e(1:2000,:)./g_L(1)+SimValues.g_e(1:2000,:)./g_L(1)));
    UniformMean(2,ii) = mean(mean(1+SimValues.g_e(2001:2500,:)./g_L(2)+SimValues.g_e(2001:2500,:)./g_L(2)));
    
    load(['logMuWeight_' char(meanWeights(ii)) '_testing.mat']);
    
    LogMuMean(1,ii) = mean(mean(1+SimValues.g_e(1:2000,:)./g_L(1)+SimValues.g_e(1:2000,:)./g_L(1)));
    LogMuMean(2,ii) = mean(mean(1+SimValues.g_e(2001:2500,:)./g_L(2)+SimValues.g_e(2001:2500,:)./g_L(2)));

end

for ii = 1:length(stdWeights)
    
    load(['logSigmaWeight_' char(stdWeights(ii)) '_testing.mat']);
    
    LogSigmaMean(1,ii) = mean(mean(1+SimValues.g_e(1:2000,:)./g_L(1)+SimValues.g_e(1:2000,:)./g_L(1)));
    LogSigmaMean(2,ii) = mean(mean(1+SimValues.g_e(2001:2500,:)./g_L(2)+SimValues.g_e(2001:2500,:)./g_L(2)));
    
    load(['ExperimentRate_s_' char(stdWeights(ii)) '_testing.mat']);
    
    ExperimentRateMean(1,ii) = mean(mean(1+SimValues.g_e(1:2000,:)./g_L(1)+SimValues.g_e(1:2000,:)./g_L(1)));
    ExperimentRateMean(2,ii) = mean(mean(1+SimValues.g_e(2001:2500,:)./g_L(2)+SimValues.g_e(2001:2500,:)./g_L(2)));
    
end

%%
figure
subplot(2,2,1)
plot(1:5,UniformMean(1,:),'.b','markersize',50)
hold on
plot(1:5,UniformMean(2,:),'.r','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(max(UniformMean))+1])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Uniform')
subplot(2,2,2)
plot(1:5,LogMuMean(1,:),'.b','markersize',50)
hold on
plot(1:5,LogMuMean(2,:),'.r','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(max(LogMuMean))+1])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal m')
subplot(2,2,3)
plot(1:4,LogSigmaMean(1,:),'.b','markersize',50)
hold on
plot(1:4,LogSigmaMean(2,:),'.r','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(max(LogSigmaMean))+1])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal s')
subplot(2,2,4)
plot(1:4,ExperimentRateMean(1,:),'.b','markersize',50)
hold on
plot(1:4,ExperimentRateMean(2,:),'.r','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(max(ExperimentRateMean))+1])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Experiment')

NiceSave('GammaConductances','~/Desktop',[])