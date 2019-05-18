function CreateSimulationFigure(PopParams)

W = PopParams.W;

%%
wEE = reshape(W(PopParams.EcellidX,PopParams.EcellidX),[numel(W(PopParams.EcellidX,PopParams.EcellidX)),1]);
wII = reshape(W(PopParams.IcellidX,PopParams.IcellidX),[numel(W(PopParams.IcellidX,PopParams.IcellidX)),1]);
wIE = reshape(W(PopParams.IcellidX,PopParams.EcellidX),[numel(W(PopParams.IcellidX,PopParams.EcellidX)),1]);
wEI = reshape(W(PopParams.EcellidX,PopParams.IcellidX),[numel(W(PopParams.EcellidX,PopParams.IcellidX)),1]);

wEE(wEE==0) = nan;
wII(wII==0) = nan;
wIE(wIE==0) = nan;
wEI(wEI==0) = nan;

%%

indegreeBins = linspace(-25,25,100);

Kee = sum(W(PopParams.EcellidX,PopParams.EcellidX)>0,2);
Kii = sum(W(PopParams.IcellidX,PopParams.IcellidX)>0,2);
Kie = sum(W(PopParams.IcellidX,PopParams.EcellidX)>0,2);
Kei = sum(W(PopParams.EcellidX,PopParams.IcellidX)>0,2);

figure
subplot(2,2,1)
plot(Kee,Kei,'.b','MarkerSize',1)
xlabel('K_{EE}','FontSize',16);ylabel('K_{EI}','FontSize',16)
subplot(2,2,2)
plot(Kii,Kie,'.r','MarkerSize',1)
xlabel('K_{II}','FontSize',16);ylabel('K_{IE}','FontSize',16)

%%

bins = linspace(-4,2,100);

mapEE = hist(log10(wEE),bins);
mapEE = mapEE./sum(mapEE);
EEbins = bins;

if nanstd(wEE) ~= 0 && nanstd(wII) ~= 0 && nanstd(wIE) ~= 0 && nanstd(wEI) ~= 0
maxHeight = 1;
else
maxHeight = 0;
end

if nanstd(wEE) ~= 0
mapEE = hist(log10(wEE),bins);
mapEE = mapEE./sum(mapEE);
binsEE = bins;
maxHeight = max([maxHeight,mapEE]);
else
mapEE = [0 1];
binsEE = log10([nanmean(wEE) nanmean(wEE)]);
end

if nanstd(wII) ~= 0
mapII = hist(log10(wII),bins);
mapII = mapII./sum(mapII);
maxHeight = max([maxHeight,mapII]);
else
mapII = [0 1];
binsII = log10([nanmean(wII) nanmean(wII)]);
end

if nanstd(wIE) ~= 0
mapIE = hist(log10(wII),bins);
mapIE = mapIE./sum(mapIE);
maxHeight = max([maxHeight,mapIE]);
else
mapIE = [0 1];
binsIE = log10([nanmean(wIE) nanmean(wIE)]);
end

if nanstd(wEI) ~= 0
mapEI = hist(log10(wEI),bins);
mapEI = mapEI./sum(mapEI);
maxHeight = max([maxHeight,mapEI]);
else
mapEI = [0 1];
binsEI = log10([nanmean(wEI) nanmean(wEI)]);
end

%%
targetBins = linspace(-2,2,25);

if std(PopParams.TargetRateE) ~= 0
targetMapE = hist(log10(PopParams.TargetRateE),targetBins);
targetMapE = targetMapE./sum(targetMapE);
targetBinsE = targetBins;
meanTR_E = mean(log10(PopParams.TargetRateE));
elseif ~isnan(PopParams.TargetRateE)
targetMapE = [0 1];
targetBinsE = log10([mean(PopParams.TargetRateE) mean(PopParams.TargetRateE)]);
meanTR_E = mean(log10(PopParams.TargetRateE));
end
if isnan(PopParams.TargetRateE)
targetMapE = nan;
targetBinsE = nan;    
end

if std(PopParams.TargetRateI) ~= 0
targetMapI = hist(log10(PopParams.TargetRateI),targetBins);
targetMapI = targetMapI./sum(targetMapI);
targetBinsI = targetBins;
meanTR_I = mean(log10(PopParams.TargetRateI));
elseif ~isnan(PopParams.TargetRateI)
targetMapI = [0 1];
targetBinsI = log10([mean(PopParams.TargetRateI) mean(PopParams.TargetRateI)]);
meanTR_I = mean(log10(PopParams.TargetRateI));
end
if isnan(PopParams.TargetRateI)
targetMapI = nan;
targetBinsI = nan;    
end

figure
subplot(2,2,1)
plot(targetBinsE,targetMapE,'b')
hold on
plot([meanTR_E meanTR_E],[0 0],'.k','MarkerSize',25)
LogScale('x',10)
xlabel('Rate (Hz)','FontSize',16);ylabel('Probability','FontSize',16)
legend('Distribution','Mean Target Rate','Location','northwest')
subplot(2,2,2)
plot(targetBinsI,targetMapI,'r')
hold on
plot([meanTR_I meanTR_I],[0 0],'.k','MarkerSize',25)
LogScale('x',10)
xlabel('Rate (Hz)','FontSize',16);ylabel('Probability','FontSize',16)
legend('Distribution','Mean Target Rate','Location','northwest')

%%

figure
subplot(2,2,1)
plot(binsEE,mapEE,'b','LineWidth',2)
hold on
plot(binsII,mapII,'r','LineWidth',2)
LogScale('x',10)
xlabel('Weight (nS)','FontSize',16);ylabel('Probability','FontSize',16);title('Population Weights','FontSize',16)
legend('EE Weights','II Weights','Location','northwest')
ylim([0 maxHeight])
subplot(2,2,2)
plot(binsIE,mapIE,'b','LineWidth',2)
hold on
plot(binsEI,mapEI,'r','LineWidth',2)
LogScale('x',10)
xlabel('Weight (nS)','FontSize',16);ylabel('Probability','FontSize',16);title('Cross-Population Weights','FontSize',16)
legend('IE Weights','EI Weights','Location','northwest')
ylim([0 maxHeight])

subplot(2,4,5)
plot(targetBinsE,targetMapE,'b')
hold on
plot([meanTR_E meanTR_E],[0 0],'.k','MarkerSize',25)
LogScale('x',10)
xlabel('Rate (Hz)','FontSize',16);ylabel('Probability','FontSize',16);title('Excitatory Target Rates','FontSize',16)
legend('Distribution','Mean Target Rate','Location','southoutside')
subplot(2,4,6)
plot(targetBinsI,targetMapI,'r')
hold on
plot([meanTR_I meanTR_I],[0 0],'.k','MarkerSize',25)
LogScale('x',10)
xlabel('Rate (Hz)','FontSize',16);ylabel('Probability','FontSize',16);title('Inhibitory Target Rates','FontSize',16)
legend('Distribution','Mean Target Rate','Location','southoutside')

subplot(4,4,11)
plot(Kee,Kei,'.b','MarkerSize',1)
xlabel('K_{EE}','FontSize',16);ylabel('K_{EI}','FontSize',16);title('Excitatory Indegree','FontSize',16)

subplot(4,4,12)
plot(Kii,Kie,'.r','MarkerSize',1)
xlabel('K_{II}','FontSize',16);ylabel('K_{IE}','FontSize',16);title('Inhibitory Indegree','FontSize',16)

end
