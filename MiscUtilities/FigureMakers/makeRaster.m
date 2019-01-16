function makeRaster(SimValuesArray,w,name,folder,sort)

if sort 

figure

pos3 = [0.1 0.54 0.5 0.2];
subplot('Position',pos3)

ww = w(1);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

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

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

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

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

xlabel('Time (ms)','fontsize',20)

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

xlabel('Time (ms)','fontsize',20)

NiceSave(name,folder,[])

end

end