function makeRaster(SimValuesArray,w,name,folder,sort)

if sort 

poprate.dt = 1;   overlap = 1;   winsize = poprate.dt.*overlap;

figure

pos3 = [0.1 0.54 0.5 0.2];
subplot('Position',pos3)

ww = w(1);

SimValuesArray(ww).spikes = SimValuesArray(ww).spikes(find(SimValuesArray(ww).spikes(:,1) > 1e3),:);
SimValuesArray(ww).spikesbycell = spikeSorter(SimValuesArray(ww).spikes,1,2500);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

[spikemat,t_rate,~] = SpktToSpkmat(SimValuesArray(ww).spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValuesArray(ww).EcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).EcellIDX);
poprate.I = sum(spikemat(:,SimValuesArray(ww).IcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).IcellIDX);

M = max(max([poprate.E poprate.I]));
m = min(min([poprate.E poprate.I]));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,1000.*(poprate.E-m)./(M-m),'b','LineWidth',2)
hold on
plot(t_rate,1000.*(poprate.I-m)./(M-m),'r','LineWidth',2)

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

[spikemat,t_rate,~] = SpktToSpkmat(SimValuesArray(ww).spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValuesArray(ww).EcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).EcellIDX);
poprate.I = sum(spikemat(:,SimValuesArray(ww).IcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).IcellIDX);

M = max(max([poprate.E poprate.I]));
m = min(min([poprate.E poprate.I]));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,1000.*(poprate.E-m)./(M-m),'b','LineWidth',2)
hold on
plot(t_rate,1000.*(poprate.I-m)./(M-m),'r','LineWidth',2)

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

[spikemat,t_rate,~] = SpktToSpkmat(SimValuesArray(ww).spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValuesArray(ww).EcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).EcellIDX);
poprate.I = sum(spikemat(:,SimValuesArray(ww).IcellIDX),2)./(winsize./1000)./length(SimValuesArray(ww).IcellIDX);

M = max(max([poprate.E poprate.I]));
m = min(min([poprate.E poprate.I]));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,1000.*(poprate.E-m)./(M-m),'b','LineWidth',2)
hold on
plot(t_rate,1000.*(poprate.I-m)./(M-m),'r','LineWidth',2)

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