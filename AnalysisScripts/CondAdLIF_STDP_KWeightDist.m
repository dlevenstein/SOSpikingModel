% names = ["logSigmaWeight_01_testing","logSigmaWeight_1_testing","logSigmaWeight_10_testing","logSigmaWeight_001_testing"];
% 
% vals = ["0.01","0.1","1","10"];
% weightNames = ["001","01","1","10"];

names = ["ExperimentRate_s_01_testing","ExperimentRate_s_1_testing","ExperimentRate_s_10_testing","ExperimentRate_s_001_testing"];

vals = ["0.01","0.1","1","10"];
weightNames = ["001","01","1","10"];

% names = ["logMuWeight_01_testing","logMuWeight_1_testing","logMuWeight_10_testing","logMuWeight_03_testing","logMuWeight_3_testing"];
% 
% vals = ["0.1","0.3","1","3","10"];
% weightNames = ["01","03","1","3","10"];

% names = ["UniformWeight_01_testing","UniformWeight_1_testing","UniformWeight_10_testing","UniformWeight_001_testing"];
% 
% vals = ["0.1","0.3","1","3","10"];
% weightNames = ["01","03","1","3","10"];

for ii = 1:length(weightNames)
    
%     load(['/Users/jonathangornet/Desktop/TestRuns/logSigmaWeight_' char(weightNames(ii)) '_testing']);
    load(['/Users/jonathangornet/Desktop/TestRuns/ExperimentRate_s_' char(weightNames(ii)) '_testing']);
%     load(['/Users/jonathangornet/Desktop/TestRuns/logMuWeight_' char(weightNames(ii)) '_testing']);
%     load(['/Users/jonathangornet/Desktop/TestRuns/UniformWeight_' char(weightNames(ii)) '_testing']);

    SimValuesArray(ii) = SimValues;

end

%%
vals = [0.1,0.3,1,3,10];

for ii = 1:5
 
% U = [7,7,8,25];
%U = [3,3,7,10,25];
U = [3,3,7,10,25];
    
cellrates = cellfun(@length,SimValuesArray(ii).spikesbycell)./(SimValuesArray(1).t(end)./1000);

SortedRate = zeros(1,2500);

ratesort = zeros(2,2500);

ratesort(1,:) = cellrates;
ratesort(2,:) = 1:2500;

for jj = 1:2500
    
    id = find(ratesort(1,:) == max(ratesort(1,:)));
    SortedRate(1,jj) = ratesort(2,max(id));
    ratesort(1,max(id)) = nan;
    ratesort(2,max(id)) = nan;
    
end

SortedRate = SortedRate(SortedRate < 2001);
    
B = 100;

bins = linspace(0,U(ii),B);
wE = zeros(2000,2000);
wI = zeros(2000,2000);
wEDist = zeros(2000,B);
wIDist = zeros(2000,B);

for jj = 1:2000
    
    wiE(jj,1:2000) = reshape(SimValuesArray(ii).WeightMat(SortedRate(jj),1:2000,2),[1,2000]);
    wiI(jj,1:500) = reshape(SimValuesArray(ii).WeightMat(SortedRate(jj),2001:2500,2),[1,500]);
    
    idE = find(wiE(jj,:) == 0);
    wiE(jj,idE) = nan;
    idI = find(wiI(jj,:) == 0);
    wiI(jj,idI) = nan;
    
    wEDist(jj,:) = hist(wiE(jj,:),bins);
    wIDist(jj,:) = hist(wiI(jj,:),bins);
    
end

cellrates = cellfun(@length,SimValuesArray(ii).spikesbycell)./(SimValuesArray(1).t(end)./1000);
indegree.E = sum(SimValuesArray(ii).WeightMat(:,SimValuesArray(1).EcellIDX)~=0,2);
indegree.I = sum(SimValuesArray(ii).WeightMat(:,SimValuesArray(1).IcellIDX)~=0,2);
indegree.EIratio =     indegree.E./indegree.I;

wEE = reshape(SimValuesArray(ii).WeightMat(1:2000,1:2000,2),[1,2000.^2]);
wEI = reshape(SimValuesArray(ii).WeightMat(1:2000,2001:2500,2),[1,2000*500]);

id = find(wEE == 0);
wEE(id) = nan;
id = find(wEI == 0);
wEI(id) = nan;

EEDist = hist(wEE,bins);
EIDist = hist(wEI,bins);

figure

%     subplot(2,2,1)
%         A = repmat(1,size(wEDist));
%         A(wEDist == 0) = 0;
%         imagesc(bins,1:2000,wEDist)
%         alpha(A);colorbar
%         set(gca,'ydir','normal')
%         xlabel('Weight (nS)','fontsize',20);ylabel('Neuron ID','fontsize',20);
%         
%         %title(['E->Neuron i, \sigma: ' num2str(vals(ii))])
%         %title(['E->Neuron i, Weight: ' num2str(vals(ii))])
%         title(['E->Neuron i, w: ' num2str(vals(ii))],'fontsize',20)
        
    subplot(2,2,1)
        A = repmat(1,size(wIDist));
        A(wIDist == 0) = 0;
        imagesc(bins,1:2000,wIDist)
        alpha(A);colorbar
        set(gca,'ydir','normal')
        xlabel('Weight (nS)','fontsize',20);ylabel('Neuron ID','fontsize',20);
        
        %title(['I->Neuron i, \sigma: ' num2str(vals(ii))])
        %title(['I->Neuron i, Weight: ' num2str(vals(ii))])
        title(['I->Neuron i, w: ' num2str(vals(ii))],'fontsize',20)
        
    subplot(2,2,3)
        scatter(indegree.E,indegree.I,2,log10(cellrates))
        hold on
        xlabel('In Degree (E)','fontsize',20);ylabel('In Degree (I)','fontsize',20)
        title('Network and Cell Rate (color)','fontsize',20)
        colorbar
    subplot(2,2,4)
        %plot(bins, EEDist./sum(EEDist), 'b','linewidth',2)
        plot([vals(ii) vals(ii)], [0 max(EIDist./sum(EIDist)) + 0.01], 'b','linewidth',2)
        hold on
        plot(bins, EIDist./sum(EIDist), 'r','linewidth',2)
        xlabel('Weight (pS)','fontsize',20);ylabel('Probability','fontsize',20);
        title('Distribution of Population Weights','fontsize',20)
        legend('EE Weight','EI Weight')
        xlim([0 U(ii)]);ylim([0 inf])

NiceSave(['WeightAnalysis_UniformWeight_' char(weightNames(ii))],'~/Desktop',[]);

%NiceSave(['WeightAnalysis_LogMu_m_' char(weightNames(ii))],'~/Desktop',[]);
%NiceSave(['WeightAnalysis_LogSigma_s_' char(weightNames(ii))],'~/Desktop',[]);
%NiceSave(['K_Weight_Distribution_Uniform_w_' char(weightNames(ii))],'~/Desktop',[]);
% NiceSave(['WeightAnalysis_ExperimentRate_s_' char(weightNames(ii))],'~/Desktop',[]);

end

%%
for ii = 1:length(weightNames)
    
    wEE = reshape(SimValuesArray(ii).WeightMat(1:2000,1:2000,2),[1,2000.^2]);
    wEI = reshape(SimValuesArray(ii).WeightMat(1:2000,2001:2500,2),[1,2000*500]);

    id = find(wEE == 0);
    wEE(id) = nan;
    id = find(wEI == 0);
    wEI(id) = nan;
    
    nanmean(wEI)
    nanmean(wEE)
    
end
    
    
%%
UniformName     = ["01","03","1","3","10"];
LogSigmaName    = ["0.01","0.1","1","10"];
LogMuName       = ["0.1","0.3","1","3","10"];

KuniformE    = zeros(2500,length(UniformName));
KLogSigmaE   = zeros(2500,length(LogSigmaName));
KLogMuE      = zeros(2500,length(LogMuName));

KuniformI    = zeros(2500,length(UniformName));
KLogSigmaI   = zeros(2500,length(LogSigmaName));
KLogMuI      = zeros(2500,length(LogMuName));

Kuniform    = zeros(2500,length(UniformName));
KLogSigma   = zeros(2500,length(LogSigmaName));
KLogMu      = zeros(2500,length(LogMuName));

rateuniform     = zeros(2500,length(UniformName));
rateLogSigma    = zeros(2500,length(LogSigmaName));
rateLogMu       = zeros(2500,length(LogMuName));

%%
for ii = 1:length(UniformName)
    
    %load(['~/Desktop/TrainedWeights/largePopWeight' char(UniformName(ii)) '.mat']);
   
    for jj = 1:2500
        
        KuniformE(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,1:2000,2));
        KuniformI(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,2001:2500,2));
        Kuniform(jj,ii)  = KuniformE(jj,ii)/KuniformI(jj,ii);
        
        spikes = SimValuesArray(ii).spikesbycell{jj};
        
        rateuniform(jj,ii) = 1000./mean((diff(spikes(spikes > 1e3))));
        
    end
    
end

%%
for p = 1:5
figure
subplot(2,2,1)
plot(KuniformE(1:2000,p),KuniformI(1:2000,p),'.b','markersize',1)
xlabel('k_{i,E}','fontsize',20);ylabel('k_{i,I}','fontsize',20);title(['Indegree Sum into E cells, Uniform w: ' char(UniformName(p))],'fontsize',20);
%xlim([0 max(KuniformE(1:2000,p))]);ylim([0 max(KuniformI(1:2000,p))])
subplot(2,2,2)
plot(KuniformE(2001:2500,p),KuniformI(2001:2500,p),'.r','markersize',1)
xlabel('k_{i,E}','fontsize',20);ylabel('k_{i,I}','fontsize',20);title(['Indegree Sum into I cells, Uniform w: ' char(UniformName(p))],'fontsize',20);
%xlim([0 max(KuniformE(1:2000,p))]);ylim([0 max(KuniformI(1:2000,p))])
subplot(2,2,3)
plot(Kuniform(1:2000,p),rateuniform(1:2000,p),'.b','markersize',1)
xlabel('<K>','fontsize',20);ylabel('Rate (1/ms)','fontsize',20);title(['Indegree Sum into E cells'],'fontsize',20);
%xlim([0 max(Kuniform(2001:2500,p))]);ylim([0 max(rateuniform(2001:2500,p))])
subplot(2,2,4)
plot(Kuniform(2001:2500,p),rateuniform(2001:2500,p),'.r','markersize',1)
xlabel('<K>','fontsize',20);ylabel('Rate (1/ms)','fontsize',20);title(['Indegree Sum into I cells'],'fontsize',20);
%xlim([0 max(Kuniform(2001:2500,p))]);ylim([0 max(rateuniform(2001:2500,p))])

NiceSave(['Kweight_Uniform_w_' char(UniformName(p))],'~/Desktop',[])

end

%%
for ii = 1:length(LogSigmaName)
    
    %load(['~/Desktop/TrainedWeights/logWeight_s_' char(LogSigmaName(ii)) '.mat']);
   
    for jj = 1:2500
        
        KLogSigmaE(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,1:2000,2));
        KLogSigmaI(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,2001:2500,2));
        KLogSigma(jj,ii)  = KLogSigmaE(jj,ii)/KLogSigmaI(jj,ii);
        
        spikes = SimValuesArray(ii).spikesbycell{jj};
        
        rateLogSigma(jj,ii) = 1000./mean(diff(spikes(spikes > 1e3)));
        
    end
    
end

%%
for p = 1:4
figure
subplot(2,2,1)
plot(KLogSigmaE(1:2000,p),KLogSigmaI(1:2000,p),'.b','markersize',1)
xlabel('k_{i,E}','fontsize',20);ylabel('k_{i,I}','fontsize',20);title(['Sum -> E cells, s^2: ' char(LogSigmaName(p))],'fontsize',20);
%xlim([0 max(KLogSigmaE(1:2000,p))]);ylim([0 max(KLogSigmaI(1:2000,p))])
subplot(2,2,2)
plot(KLogSigmaE(2001:2500,p),KLogSigmaI(2001:2500,p),'.r','markersize',1)
xlabel('k_{i,E}','fontsize',20);ylabel('k_{i,I}','fontsize',20);title(['Sum -> I cells, s^2: ' char(LogSigmaName(p))],'fontsize',20);
%xlim([0 max(KLogSigmaE(1:2000,p))]);ylim([0 max(KLogSigmaI(1:2000,p))])
subplot(2,2,3)
plot(KLogSigma(1:2000,p),rateLogSigma(1:2000,p),'.b','markersize',1)
xlabel('<K>','fontsize',20);ylabel('Rate (1/ms)','fontsize',20);title(['Indegree Sum into E cells'],'fontsize',20);
%xlim([0 max(KLogSigma(2001:2500,p))]);ylim([0 max(rateLogSigma(2001:2500,p))])
subplot(2,2,4)
plot(KLogSigma(2001:2500,p),rateLogSigma(2001:2500,p),'.r','markersize',1)
xlabel('<K>','fontsize',20);ylabel('Rate (1/ms)','fontsize',20);title(['Indegree Sum into I cells'],'fontsize',20);
%xlim([0 max(KLogSigma(2001:2500,p))]);ylim([0 max(rateLogSigma(2001:2500,p))])

NiceSave(['Kweight_ExperimentRate_s_' char(LogSigmaName(p))],'~/Desktop',[])
%NiceSave(['Kweight_LogSigma_s_' char(LogSigmaName(p))],'~/Desktop',[])

end

%%
for ii = 1:length(LogMuName)
    
    %load(['~/Desktop/TrainedWeights/logWeight_m_' char(LogMuName(ii)) '.mat']);
   
    for jj = 1:2500
        
        KLogMuE(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,1:2000,2));
        KLogMuI(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,2001:2500,2));
        KLogMu(jj,ii)  = KLogMuE(jj,ii)/KLogMuI(jj,ii);
        
        spikes = SimValuesArray(ii).spikesbycell{jj};
        
        rateLogMu(jj,ii) = 1000./mean(diff(spikes > 1e3));
        
    end
    
    %rateLogMu(:,ii) = cellfun(@length,SimValuesArray(ii).spikesbycell)./(SimValuesArray(1).t(end)./1000);
    
end

%%
for p = 1:5
figure
subplot(2,2,1)
plot(KLogMuE(1:2000,p),KLogMuI(1:2000,p),'.b','markersize',1)
%xlim([0 max(KLogMuE(1:2000,p))]);ylim([0 max(KLogMuI(1:2000,p))])
xlabel('k_{i,E}','fontsize',20);ylabel('k_{i,I}','fontsize',20);title(['Indegree Sum into E, m: ' char(LogMuName(p))],'fontsize',20);
subplot(2,2,2)
plot(KLogMuE(2001:2500,p),KLogMuI(2001:2500,p),'.r','markersize',1)
%xlim([0 max(KLogMuE(1:2000,p))]);ylim([0 max(KLogMuI(1:2000,p))])
xlabel('k_{i,E}','fontsize',20);ylabel('k_{i,I}','fontsize',20);title(['Indegree Sum into I, m: ' char(LogMuName(p))]);
subplot(2,2,3)
plot(KLogMu(1:2000,p),rateLogMu(1:2000,p),'.b','markersize',1)
%xlim([0 max(KLogMu(2001:2500,p))]);ylim([0 max(rateLogMu(2001:2500,p))])
xlabel('<K>','fontsize',20);ylabel('Rate (1/ms)','fontsize',20);title(['Indegree Sum into E'],'fontsize',20);
subplot(2,2,4)
plot(KLogMu(2001:2500,p),rateLogMu(2001:2500,p),'.r','markersize',1)
%xlim([0 max(KLogMu(2001:2500,p))]);ylim([0 max(rateLogMu(2001:2500,p))])
xlabel('<K>','fontsize',20);ylabel('Rate (1/ms)','fontsize',20);title(['Indegree Sum into I'],'fontsize',20);

NiceSave(['Kweight_LogMu_m_' char(LogMuName(p))],'~/Desktop',[])

end
