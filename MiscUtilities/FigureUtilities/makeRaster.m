function makeRaster(SimValuesArray,w,name,folder,sort)
%%
if sort 

poprate.dt = 1;   overlap = 6;   winsize = poprate.dt.*overlap;
t_rate = 0:poprate.dt:1e4;

figure

pos3 = [0.1 0.54 0.5 0.2];
subplot('Position',pos3)

ww = w(1);

SimValuesArray(ww).spikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,1) > 1e3),:);
SimValuesArray(ww).spikesbycell = spikeSorter(SimValuesArray(ww).spikes,1,2500);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

poprate.E = hist(Espikes(:,1),t_rate);
poprate.E = movmean(poprate.E,overlap);

poprate.I = hist(Ispikes(:,1),t_rate);
poprate.I = movmean(poprate.I,overlap);

% [spikemat,t_rate,~] = SpktToSpkmat(SimValuesArray(ww).spikesbycell, [], poprate.dt,overlap);
% poprate.E = sum(spikemat(:,SimValuesArray(ww).EcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).EcellIDX);
% poprate.I = sum(spikemat(:,SimValuesArray(ww).IcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).IcellIDX);

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,50.*poprate.E,'Color',[0.7 0.7 1],'linewidth',2)
hold on
plot(t_rate,50.*poprate.I,'Color',[1 0.7 0.7],'linewidth',2)
hold on
plot([8650 8700],[500 500],'k','LineWidth',2) 
hold on
text(8705,510,'10 Hz','FontSize',16)
    
xlim([8500 8700]);ylim([0 2500])

title('Raster','fontsize',20);

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos2 = [0.1 0.32 0.5 0.2];
subplot('Position',pos2)

ww = w(2);

SimValuesArray(ww).spikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,1) > 1e3),:);
SimValuesArray(ww).spikesbycell = spikeSorter(SimValuesArray(ww).spikes,1,2500);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

poprate.E = hist(Espikes(:,1),t_rate);
poprate.E = movmean(poprate.E,overlap);

poprate.I = hist(Ispikes(:,1),t_rate);
poprate.I = movmean(poprate.I,overlap);

% [spikemat,t_rate,~] = SpktToSpkmat(SimValuesArray(ww).spikesbycell, [], poprate.dt,overlap);
% poprate.E = sum(spikemat(:,SimValuesArray(ww).EcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).EcellIDX);
% poprate.I = sum(spikemat(:,SimValuesArray(ww).IcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).IcellIDX);

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,50.*poprate.E,'Color',[0.3 0.3 1],'linewidth',2)
hold on
plot(t_rate,50.*poprate.I,'Color',[1 0.3 0.3],'linewidth',2)
hold on
plot([8650 8700],[500 500],'k','LineWidth',2) 
hold on
text(8705,510,'10 Hz','FontSize',16)

xlim([8500 8700]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos1 = [0.1 0.1 0.5 0.2];
subplot('Position',pos1)

ww = w(3);

SimValuesArray(ww).spikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,1) > 1e3),:);
SimValuesArray(ww).spikesbycell = spikeSorter(SimValuesArray(ww).spikes,1,2500);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

poprate.E = hist(Espikes(:,1),t_rate);
poprate.E = movmean(poprate.E,overlap);

poprate.I = hist(Ispikes(:,1),t_rate);
poprate.I = movmean(poprate.I,overlap);

% [spikemat,t_rate,~] = SpktToSpkmat(SimValuesArray(ww).spikesbycell, [], poprate.dt,overlap);
% poprate.E = sum(spikemat(:,SimValuesArray(ww).EcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).EcellIDX);
% poprate.I = sum(spikemat(:,SimValuesArray(ww).IcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).IcellIDX);

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,50.*poprate.E,'Color',[0 0 0.5],'linewidth',2)
hold on
plot(t_rate,50.*poprate.I,'Color',[0.5 0 0],'linewidth',2)
hold on
plot([8650 8700],[500 500],'k','LineWidth',2) 
hold on
text(8705,510,'10 Hz','FontSize',16)

xlim([8500 8700]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

%xlabel('Time (ms)','fontsize',20)

NiceSave(name,folder,[])

else
    
figure

pos3 = [0.1 0.54 0.5 0.2];
subplot('Position',pos3)

ww = w(1);

Espikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,2) <= 2000),:);
Ispikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,2) > 2000),:);

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

title('Raster','fontsize',20);

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos2 = [0.1 0.32 0.5 0.2];
subplot('Position',pos2)

ww = w(2);

Espikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,2) <= 2000),:);
Ispikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,2) > 2000),:);

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos1 = [0.1 0.1 0.5 0.2];
subplot('Position',pos1)

ww = w(3);

Espikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,2) <= 2000),:);
Ispikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,2) > 2000),:);

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

%xlabel('Time (ms)','fontsize',20)

NiceSave(name,folder,[])

end

end