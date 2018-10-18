% vals = [0.01,0.1,1];
% weightNames = ["001","01","1"];

% vals = [0.1,1,10];
% weightNames = ["01","1","10"];

vals = [1,0.3,0.1];
spikeNames = ["1-001","01-002","03-003"];
weightNames = ["1","01","03"];

for ii = 1:length(weightNames)
    
%     SimValuesArray(ii) = load(['~/Desktop/TrainedWeights/Asynchrony_Test_s_' char(weightNames(ii))]);
%     SimValuesArray(ii) = load(['~/Desktop/TrainedWeights/Weights_Asynchrony_Test_s_' char(weightNames(ii))]);
     spikesbycell(ii) = load(['~/Desktop/TrainedWeights/AsynchronyLogMu_m_' char(spikeNames(ii))],'spikesbycell');
     SimValues(ii) = load(['~/Desktop/TrainedWeights/logWeight_m_' char(weightNames(ii))],'SimValues');
    
end

%%
for ii = 1:3
    
    SimValuesArray(ii).WeightMat = SimValues(ii).WeightMat;
    SimValuesArray(ii).spikesbycell = SimValues(ii).spikesbycell;
    %S = load(['~/Desktop/TrainedWeights/AsynchronyLogMu_m_' char(spikeNames(ii))],'spikes');
    %SimValuesArray(ii).spikes = S.spikes;
    SimValuesArray(ii).t = SimValues(ii).t;
    SimValuesArray(ii).EcellIDX = SimValues(ii).EcellIDX;
    SimValuesArray(ii).IcellIDX = SimValues(ii).IcellIDX;
    
end
%%
for ii = 1:3
    
%U = [7,7,17];
%U = [1,5,20];
U = [7,3,2];
    
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

    subplot(2,2,1)
        A = repmat(1,size(wEDist));
        A(wEDist == 0) = 0;
        imagesc(bins,1:2000,wEDist)
        alpha(A);colorbar
        set(gca,'ydir','normal')
        xlabel('Weight (nS)');ylabel('Neuron ID');
        
        %title(['E->Neuron i, \sigma: ' num2str(vals(ii))])
        %title(['E->Neuron i, Weight: ' num2str(vals(ii))])
        title(['E->Neuron i, \mu: ' num2str(vals(ii))])
        
    subplot(2,2,2)
        A = repmat(1,size(wIDist));
        A(wIDist == 0) = 0;
        imagesc(bins,1:2000,wIDist)
        alpha(A);colorbar
        set(gca,'ydir','normal')
        xlabel('Weight (nS)');ylabel('Neuron ID');
        
        %title(['I->Neuron i, \sigma: ' num2str(vals(ii))])
        %title(['I->Neuron i, Weight: ' num2str(vals(ii))])
        title(['I->Neuron i, \mu: ' num2str(vals(ii))])
        
    subplot(2,2,3)
        scatter(indegree.E,indegree.I,2,(cellrates))
        hold on
        xlabel('In Degree (E)');ylabel('In Degree (I)')
        title('Network and Cell Rate (color)')
        colorbar
    subplot(2,2,4)
        plot(bins, EEDist./sum(EEDist), 'b','linewidth',2)
        %plot([vals(ii) vals(ii)], [0 max(EIDist./sum(EIDist)) + 0.01], 'b','linewidth',2)
        hold on
        plot(bins, EIDist./sum(EIDist), 'r','linewidth',2)
        xlabel('Weight (pS)');ylabel('Probability');
        title('Distribution of Population Weights')
        legend('EE Weight','EI Weight')
        xlim([0 U(ii)]);ylim([0 max(EIDist./sum(EIDist)) + 0.01])
        
%NiceSave(['K_Weight_Distribution_LogWeight_w_' char(weightNames(ii))],'~/Desktop',[]);
%NiceSave(['K_Weight_Distribution_Uniform_w_' char(weightNames(ii))],'~/Desktop',[]);
%NiceSave(['K_Weight_Distribution_LogWeightMu_w_' char(weightNames(ii))],'~/Desktop',[]);

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
LogSigmaName    = ["001","01","1"];
LogMuName       = ["01","03","1"];

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
    
    load(['~/Desktop/TrainedWeights/largePopWeight' char(UniformName(ii)) '.mat']);
   
    for jj = 1:2500
        
        KuniformE(jj,ii) = sum(SimValues.WeightMat(jj,1:2000,2));
        KuniformI(jj,ii) = sum(SimValues.WeightMat(jj,2001:2500,2));
        Kuniform(jj,ii)  = KuniformE(jj,ii)/KuniformI(jj,ii);
        
        spikes = SimValues.spikesbycell{jj};
        
        rateuniform(jj,ii) = 1./mean((diff(spikes(spikes > 5e5))));
        
    end
    
end

%%
for p = 1:5
figure
subplot(2,2,1)
plot(KuniformE(1:2000,p),KuniformI(1:2000,p),'.b','markersize',1)
xlabel('k_{i,E}');ylabel('k_{i,I}');title(['Indegree Sum into E cells, Uniform w: ' char(UniformName(p))]);
%xlim([0 max(KuniformE(1:2000,p))]);ylim([0 max(KuniformI(1:2000,p))])
subplot(2,2,2)
plot(KuniformE(2001:2500,p),KuniformI(2001:2500,p),'.r','markersize',1)
xlabel('k_{i,E}');ylabel('k_{i,I}');title(['Indegree Sum into I cells, Uniform w: ' char(UniformName(p))]);
%xlim([0 max(KuniformE(1:2000,p))]);ylim([0 max(KuniformI(1:2000,p))])
subplot(2,2,3)
plot(Kuniform(1:2000,p),rateuniform(1:2000,p),'.b','markersize',1)
xlabel('<K>');ylabel('Rate (1/ms)');title(['Indegree Sum into E cells']);
%xlim([0 max(Kuniform(2001:2500,p))]);ylim([0 max(rateuniform(2001:2500,p))])
subplot(2,2,4)
plot(Kuniform(2001:2500,p),rateuniform(2001:2500,p),'.r','markersize',1)
xlabel('<K>');ylabel('Rate (1/ms)');title(['Indegree Sum into I cells']);
%xlim([0 max(Kuniform(2001:2500,p))]);ylim([0 max(rateuniform(2001:2500,p))])

NiceSave(['Kweight_Uniform_w_' char(UniformName(p))],'~/Desktop',[])

end

%%
for ii = 1:length(LogSigmaName)
    
    load(['~/Desktop/TrainedWeights/logWeight_s_' char(LogSigmaName(ii)) '.mat']);
   
    for jj = 1:2500
        
        KLogSigmaE(jj,ii) = sum(SimValues.WeightMat(jj,1:2000,2));
        KLogSigmaI(jj,ii) = sum(SimValues.WeightMat(jj,2001:2500,2));
        KLogSigma(jj,ii)  = KLogSigmaE(jj,ii)/KLogSigmaI(jj,ii);
        
        spikes = SimValues.spikesbycell{jj};
        
        rateLogSigma(jj,ii) = 1./mean(diff(spikes(spikes > 5e5)));
        
    end
    
end

%%
for p = 1:3
figure
subplot(2,2,1)
plot(KLogSigmaE(1:2000,p),KLogSigmaI(1:2000,p),'.b','markersize',1)
xlabel('k_{i,E}');ylabel('k_{i,I}');title(['Sum -> E cells, LogWeight Sigma: ' char(LogSigmaName(p))]);
%xlim([0 max(KLogSigmaE(1:2000,p))]);ylim([0 max(KLogSigmaI(1:2000,p))])
subplot(2,2,2)
plot(KLogSigmaE(2001:2500,p),KLogSigmaI(2001:2500,p),'.r','markersize',1)
xlabel('k_{i,E}');ylabel('k_{i,I}');title(['Sum -> I cells, LogWeight Sigma: ' char(LogSigmaName(p))]);
%xlim([0 max(KLogSigmaE(1:2000,p))]);ylim([0 max(KLogSigmaI(1:2000,p))])
subplot(2,2,3)
plot(KLogSigma(1:2000,p),rateLogSigma(1:2000,p),'.b','markersize',1)
xlabel('<K>');ylabel('Rate (1/ms)');title(['Indegree Sum into E cells']);
%xlim([0 max(KLogSigma(2001:2500,p))]);ylim([0 max(rateLogSigma(2001:2500,p))])
subplot(2,2,4)
plot(KLogSigma(2001:2500,p),rateLogSigma(2001:2500,p),'.r','markersize',1)
xlabel('<K>');ylabel('Rate (1/ms)');title(['Indegree Sum into I cells']);
%xlim([0 max(KLogSigma(2001:2500,p))]);ylim([0 max(rateLogSigma(2001:2500,p))])

NiceSave(['Kweight_LogSigma_s_' char(LogSigmaName(p))],'~/Desktop',[])

end

%%
for ii = 1:length(LogMuName)
    
    load(['~/Desktop/TrainedWeights/logWeight_m_' char(LogMuName(ii)) '.mat']);
   
    for jj = 1:2500
        
        KLogMuE(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,1:2000,2));
        KLogMuI(jj,ii) = sum(SimValuesArray(ii).WeightMat(jj,2001:2500,2));
        KLogMu(jj,ii)  = KLogMuE(jj,ii)/KLogMuI(jj,ii);
        
        spikes = SimValuesArray(ii).spikesbycell{jj};
        
        rateLogMu(jj,ii) = 1000./mean(diff(spikes));
        
    end
    
    %rateLogMu(:,ii) = cellfun(@length,SimValuesArray(ii).spikesbycell)./(SimValuesArray(1).t(end)./1000);
    
end

%%
for p = 1:3
figure
subplot(2,2,1)
plot(KLogMuE(1:2000,p),KLogMuI(1:2000,p),'.b','markersize',1)
%xlim([0 max(KLogMuE(1:2000,p))]);ylim([0 max(KLogMuI(1:2000,p))])
xlabel('k_{i,E}');ylabel('k_{i,I}');title(['Indegree Sum into E, LogWeight Mu: ' char(LogMuName(p))]);
subplot(2,2,2)
plot(KLogMuE(2001:2500,p),KLogMuI(2001:2500,p),'.r','markersize',1)
%xlim([0 max(KLogMuE(1:2000,p))]);ylim([0 max(KLogMuI(1:2000,p))])
xlabel('k_{i,E}');ylabel('k_{i,I}');title(['Indegree Sum into I, LogWeight Mu: ' char(LogMuName(p))]);
subplot(2,2,3)
plot(KLogMu(1:2000,p),rateLogMu(1:2000,p),'.b','markersize',1)
%xlim([0 max(KLogMu(2001:2500,p))]);ylim([0 max(rateLogMu(2001:2500,p))])
xlabel('<K>');ylabel('Rate (1/ms)');title(['Indegree Sum into E']);
subplot(2,2,4)
plot(KLogMu(2001:2500,p),rateLogMu(2001:2500,p),'.r','markersize',1)
%xlim([0 max(KLogMu(2001:2500,p))]);ylim([0 max(rateLogMu(2001:2500,p))])
xlabel('<K>');ylabel('Rate (1/ms)');title(['Indegree Sum into I']);

% NiceSave(['Kweight_LogMu_m_' char(LogMuName(p))],'~/Desktop',[])

end
