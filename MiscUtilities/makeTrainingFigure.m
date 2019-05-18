function makeTrainingFigure(SimValues,network,path)

weightMean = SimValues.WeightChange(1,:);
spikeRate = SimValues.spikeRate;
weightStd = SimValues.WeightChange(3,:);

stdUpper = weightMean+weightStd;
stdLower = weightMean-weightStd;

t = SimValues.t;
tArea = [t fliplr(t)];
stdArea = [stdLower fliplr(stdUpper)];

figure
subplot(2,2,1)
fill(tArea,stdArea,[0.7,0.7,1],'LineStyle','none')
hold on
plot(t,weightMean,'b')
xlim([0 t(end)])
subplot(2,2,3)
plot(t,spikeRate(1,:),'b')
hold on
plot(t,spikeRate(2,:),'r')
xlim([0 t(end)])

subplot(2,2,2)
[Espikes,Ispikes] = RasterSorter(SimValues);
plot(Espikes(:,1),Espikes(:,2),'.b','MarkerSize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.b','MarkerSize',1)
xlim([0 500]);ylim([0 2500])

subplot(2,2,4)
[Espikes,Ispikes] = RasterSorter(SimValues);
plot(Espikes(:,1),Espikes(:,2),'.b','MarkerSize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.b','MarkerSize',1)
xlim([0 500]);ylim([0 2500])

NiceSave(['TrainingFigure_network_' network],path,[])

end





