function makeTrainingFigure(SimValues,network,path)
%%
weightMean = SimValues.WeightChange(1,:);
spikeRate = SimValues.spikeRate;
weightStd = SimValues.WeightChange(3,:);

stdUpper = weightMean+weightStd;
stdLower = weightMean-weightStd;

t = SimValues.t;
tArea = [t fliplr(t)]./1e3;
stdArea = [stdLower fliplr(stdUpper)];

poprate.dt = 1;   poprate.binsize = 5;
t_rate = poprate.dt:poprate.dt:SimValues.t(end);

rate = hist(SimValues.spikes(:,1),t_rate);
rate = movmean(rate.*(1e3/poprate.dt)*(1/2500),poprate.binsize);

[Espikes,Ispikes] = RasterSorter(SimValues);

%%
figure
subplot(2,2,1)
fill(tArea,stdArea,[0.7,0.7,1],'LineStyle','none')
hold on
plot(t./1e3,weightMean,'b')
xlim([0 t(end)./1e3])
xlabel('Time (sec)','FontSize',16);ylabel('Weight (nS)','FontSize',16)
subplot(2,2,3)
plot(t./1e3,spikeRate(1,:),'b')
hold on
plot(t./1e3,spikeRate(2,:),'r')
xlim([0 t(end)./1e3])
ylim([0 10])
xlabel('Time (sec)','FontSize',16);ylabel('Spike Rate (Hz)','FontSize',16)

pos = [0.55,0.7,0.4,0.22];
subplot('position',pos)

plot(Espikes(:,1),Espikes(:,2),'.b','MarkerSize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','MarkerSize',1)
set(gca,'YTick',[]);set(gca,'XTick',[])
xlim([0 200]);ylim([0 2500])
ylabel({'Start','of Training'},'FontSize',16)

pos = [0.55,0.58,0.4,0.1];
subplot('position',pos)

plot(t_rate,rate,'k','LineWidth',2)
xlim([0 200]);%ylim([0 10])

xlabel('Time (ms)','FontSize',16);ylabel('Rate (Hz)','FontSize',10)

pos = [0.55,0.23,0.4,0.22];
subplot('position',pos)

plot(Espikes(:,1),Espikes(:,2),'.b','MarkerSize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','MarkerSize',1)
set(gca,'YTick',[]);set(gca,'XTick',[])
xlim([SimValues.t(end)-200 SimValues.t(end)]);ylim([0 2500])
ylabel({'End','of Training'},'FontSize',16)

pos = [0.55,0.11,0.4,0.1];
subplot('position',pos)

plot(t_rate,rate,'k','LineWidth',2)
xlim([SimValues.t(end)-200 SimValues.t(end)]);%ylim([0 10])

xlabel('Time (ms)','FontSize',16);ylabel('Rate (Hz)','FontSize',10)

% subplot(2,2,4)
% [Espikes,Ispikes] = RasterSorter(SimValues);
% plot(Espikes(:,1),Espikes(:,2),'.b','MarkerSize',1)
% hold on
% plot(Ispikes(:,1),Ispikes(:,2),'.r','MarkerSize',1)
% set(gca,'YTick',[])
% xlim([SimValues.t(end)-200 SimValues.t(end)]);ylim([0 2500])
% xlabel('Time (ms)','FontSize',16);ylabel('End of Training','FontSize',16)

%%
NiceSave(['TrainingFigure_network_' network],path,[])

end





