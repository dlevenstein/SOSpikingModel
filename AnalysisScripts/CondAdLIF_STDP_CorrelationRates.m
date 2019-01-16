meanWeights = ["01","03","1","3","10"];
stdWeights = ["001","01","1","10"];

UniformMean = zeros(5,length(meanWeights));
LogMuMean = zeros(5,length(meanWeights));

LogSigmaMean = zeros(5,length(stdWeights));
ExperimentRateMean = zeros(5,length(stdWeights));

UniformVoltageMean = zeros(1,length(meanWeights));
LogMuVoltageMean = zeros(1,length(meanWeights));

LogSigmaVoltageMean = zeros(1,length(stdWeights));
ExperimentRateVoltageMean = zeros(1,length(stdWeights));

for ii = 1:length(meanWeights)
    
    load(['UniformWeight_' char(meanWeights(ii)) '_testing.mat']);
    UniformMean(:,ii) = RateCorrelation(SimValues);
    
    C = corr(transpose(SimValues.V(1:2500,:)),transpose(SimValues.V(1:2500,:)));
    C(diag(diag(true(size(C))))) = nan;
    
    UniformVoltageMean(ii) = nanmean(nanmean(C));
    
    load(['logMuWeight_' char(meanWeights(ii)) '_testing.mat']);
    LogMuMean(:,ii) = RateCorrelation(SimValues);
    
    C = corr(transpose(SimValues.V(1:2500,:)),transpose(SimValues.V(1:2500,:)));
    C(diag(diag(true(size(C))))) = nan;
    
    LogMuVoltageMean(ii) = nanmean(nanmean(C));
    
end

for ii = 1:length(stdWeights)
    
    load(['logSigmaWeight_' char(stdWeights(ii)) '_testing.mat']);
    LogSigmaMean(:,ii) = RateCorrelation(SimValues);
    
    C = corr(transpose(SimValues.V(1:2500,:)),transpose(SimValues.V(1:2500,:)));
    C(diag(diag(true(size(C))))) = nan;
    
    LogSigmaVoltageMean(ii) = nanmean(nanmean(C));
    
    load(['ExperimentRate_s_' char(stdWeights(ii)) '_testing.mat']);
    ExperimentRateMean(:,ii) = RateCorrelation(SimValues);
    
    C = corr(transpose(SimValues.V(1:2500,:)),transpose(SimValues.V(1:2500,:)));
    C(diag(diag(true(size(C))))) = nan;
    
    ExperimentRateVoltageMean(ii) = nanmean(nanmean(C));
    
end

%%
figure
subplot(2,2,1)
plot(1:5,UniformMean(1,:),'.k','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(UniformMean(1,:))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Uniform')
subplot(2,2,2)
plot(1:5,LogMuMean(1,:),'.k','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(LogMuMean(1,:))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal m')
subplot(2,2,3)
plot(1:4,LogSigmaMean(1,:),'.k','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(LogSigmaMean(1,:))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal s')
subplot(2,2,4)
plot(1:4,ExperimentRateMean(1,:),'.k','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(ExperimentRateMean(1,:))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Experiment')

NiceSave('CorrelationSpikeRate','~/Desktop',[])

%%
figure
subplot(2,2,1)
plot(1:5,UniformMean(2,:),'.b','markersize',50)
hold on
plot(1:5,UniformMean(3,:),'.r','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(max(UniformMean))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Uniform')
subplot(2,2,2)
plot(1:5,LogMuMean(2,:),'.b','markersize',50)
hold on
plot(1:5,LogMuMean(3,:),'.r','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(max(LogMuMean))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal m')
subplot(2,2,3)
plot(1:4,LogSigmaMean(2,:),'.b','markersize',50)
hold on
plot(1:4,LogSigmaMean(3,:),'.r','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(max(LogSigmaMean))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal s')
subplot(2,2,4)
plot(1:4,ExperimentRateMean(2,:),'.b','markersize',50)
hold on
plot(1:4,ExperimentRateMean(3,:),'.r','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(max(ExperimentRateMean))+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Experiment')

NiceSave('CorrelationSpikeRatePop','~/Desktop',[])

%%

figure
subplot(2,2,1)
plot(1:5,UniformVoltageMean,'.k','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(UniformVoltageMean)+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Uniform')
subplot(2,2,2)
plot(1:5,LogMuVoltageMean,'.k','markersize',50)
xticklabels({'0.1','0.3','1','3','10'})
xlim([0 6]);ylim([0 max(LogMuVoltageMean)+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal m')
subplot(2,2,3)
plot(1:4,LogSigmaVoltageMean,'.k','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(LogSigmaVoltageMean)+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Lognormal s')
subplot(2,2,4)
plot(1:4,ExperimentRateVoltageMean,'.k','markersize',50)
xticklabels({'0.01','0.1','1','10'})
xlim([0 5]);ylim([0 max(ExperimentRateVoltageMean)+0.01])
xlabel('Weight (nS)');ylabel('Mean Correlation');title('Experiment')

NiceSave('CorrelationVoltages','~/Desktop',[])