vals = [0.01,0.1,1];
weightNames = ["001","01","1"];

for ii = 3
B = 100;

bins = linspace(0,25,B);
wE = zeros(2500,2500);
wI = zeros(2500,2500);
wEDist = zeros(2500,B);
wIDist = zeros(2500,B);

for jj = 1:2500
    
    wiE(jj,1:2000) = reshape(SimValuesArray(ii).WeightMat(jj,1:2000,2),[1,2000]);
    wiI(jj,1:500) = reshape(SimValuesArray(ii).WeightMat(jj,2001:2500,2),[1,500]);
    
    idE = find(wiE(jj,:) == 0);
    wiE(jj,idE) = nan;
    idI = find(wiI(jj,:) == 0);
    wiI(jj,idI) = nan;
    
    wEDist(jj,:) = hist(wiE(jj,:),bins);
    wIDist(jj,:) = hist(wiI(jj,:),bins);
    
end

cellrates = cellfun(@length,SimValuesArray(ii).spikesbycell)./(SimValuesArray(ii).t(end)./1000);
indegree.E = sum(SimValuesArray(ii).WeightMat(:,SimValuesArray(ii).EcellIDX)~=0,2);
indegree.I = sum(SimValuesArray(ii).WeightMat(:,SimValuesArray(ii).IcellIDX)~=0,2);
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
        imagesc(bins,1:2500,wEDist)
        alpha(A);colorbar
        set(gca,'ydir','normal')
        xlabel('Weight (nS)');ylabel('Neuron ID');title(['E->Neuron i, \sigma: ' num2str(vals(ii))])
        
    subplot(2,2,2)
        A = repmat(1,size(wIDist));
        A(wIDist == 0) = 0;
        imagesc(bins,1:2500,wIDist)
        alpha(A);colorbar
        set(gca,'ydir','normal')
        xlabel('Weight (nS)');ylabel('Neuron ID');title(['I->Neuron i, \sigma: ' num2str(vals(ii))])
    subplot(2,2,3)
        scatter(indegree.E,indegree.I,2,log10(cellrates))
        hold on
        xlabel('In Degree (E)');ylabel('In Degree (I)')
        title('Network and Cell Rate (color)')
    subplot(2,2,4)
        plot(bins, EEDist./sum(EEDist), 'b','linewidth',2)
        hold on
        plot(bins, EIDist./sum(EIDist), 'r','linewidth',2)
        xlabel('Weight (pS)');ylabel('Probability');title('Distribution of Population Weights')
        legend('EE Weight','EI Weight')
        xlim([0 15]);ylim([0 max(EIDist./sum(EIDist)) + 0.01])
        
NiceSave(['K_Weight_Distribution_LogWeight_w_' char(weightNames(ii))],'~/Desktop',[]);

end