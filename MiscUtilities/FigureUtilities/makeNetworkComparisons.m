function makeNetworkComparisons(SimValuesArray,SimValuesArrayScrambled,SimValuesArrayMean,indices,network,path)

figure

pos = [0.1 0.54 0.4 0.2];
subplot('Position',pos)

ww = indices(1);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])
title('Raster','fontsize',20)

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos = [0.1 0.32 0.4 0.2];
subplot('Position',pos)

ww = indices(1);

[Espikes,Ispikes] = RasterSorter(SimValuesArrayScrambled(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos = [0.1 0.1 0.4 0.2];
subplot('Position',pos)

ww = indices(1);

[Espikes,Ispikes] = RasterSorter(SimValuesArrayMean(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

xlabel('Time (ms)','fontsize',20)

pos = [0.55 0.54 0.4 0.2];
subplot('Position',pos)

ww = indices(end);

[Espikes,Ispikes] = RasterSorter(SimValuesArray(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])
title('Raster','fontsize',20)

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos = [0.55 0.32 0.4 0.2];
subplot('Position',pos)

ww = indices(end);

[Espikes,Ispikes] = RasterSorter(SimValuesArrayScrambled(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

pos = [0.55 0.1 0.4 0.2];
subplot('Position',pos)

ww = indices(end);

[Espikes,Ispikes] = RasterSorter(SimValuesArrayMean(ww));

plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)

xlim([9800 1e4]);ylim([0 2500])

set(gca,'xtick',[])
set(gca,'xticklabel',[])

set(gca,'ytick',[])
set(gca,'yticklabel',[])

xlabel('Time (ms)','fontsize',20)

NiceSave([network 'NetworkRasterComparison'],path,[])
    
%%

[dynamicVals,kvals] = AnalyzeDynamics(SimValuesArray);

[dynamicValsScrambled,kvalsScrambled] = AnalyzeDynamics(SimValuesArrayScrambled);

[dynamicValsMean,kvalsMean] = AnalyzeDynamics(SimValuesArrayMean);

%%

figure

pos = [0.1 0.1 0.2 0.4];
subplot('Position',pos)

ww = indices(1);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,2,2)./500,'Color',[1 0.7 0.7],'linewidth',2)
hold on
plot(dynamicValsScrambled(ww).t_ccg*1000,dynamicValsScrambled(ww).ccg(:,2,2)./500,'Color',[1 0.3 0.3],'linewidth',2)
hold on
plot(dynamicValsMean(ww).t_ccg*1000,dynamicValsMean(ww).ccg(:,2,2)./500,'Color',[0.5 0 0],'linewidth',2)

legend('Trained','Scrambled','Mean')

pos = [0.35 0.1 0.2 0.4];
subplot('Position',pos)

ww = indices(2);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,2,2)./500,'Color',[1 0.7 0.7],'linewidth',2)
hold on
plot(dynamicValsScrambled(ww).t_ccg*1000,dynamicValsScrambled(ww).ccg(:,2,2)./500,'Color',[1 0.3 0.3],'linewidth',2)
hold on
plot(dynamicValsMean(ww).t_ccg*1000,dynamicValsMean(ww).ccg(:,2,2)./500,'Color',[0.5 0 0],'linewidth',2)

legend('Trained','Scrambled','Mean')

pos = [0.60 0.1 0.2 0.4];
subplot('Position',pos)

ww = indices(3);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,2,2)./500,'Color',[1 0.7 0.7],'linewidth',2)
hold on
plot(dynamicValsScrambled(ww).t_ccg*1000,dynamicValsScrambled(ww).ccg(:,2,2)./500,'Color',[1 0.3 0.3],'linewidth',2)
hold on
plot(dynamicValsMean(ww).t_ccg*1000,dynamicValsMean(ww).ccg(:,2,2)./500,'Color',[0.5 0 0],'linewidth',2)

legend('Trained','Scrambled','Mean')

pos = [0.1 0.55 0.2 0.4];
subplot('Position',pos)

ww = indices(1);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,1,1)./2000,'Color',[0.7 0.7 1],'linewidth',2)
hold on
plot(dynamicValsScrambled(ww).t_ccg*1000,dynamicValsScrambled(ww).ccg(:,1,1)./2000,'Color',[0.3 0.3 1],'linewidth',2)
hold on
plot(dynamicValsMean(ww).t_ccg*1000,dynamicValsMean(ww).ccg(:,1,1)./2000,'Color',[0 0 0.5],'linewidth',2)

legend('Trained','Scrambled','Mean')

pos = [0.35 0.55 0.2 0.4];
subplot('Position',pos)

ww = indices(2);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,1,1)./2000,'Color',[0.7 0.7 1],'linewidth',2)
hold on
plot(dynamicValsScrambled(ww).t_ccg*1000,dynamicValsScrambled(ww).ccg(:,1,1)./2000,'Color',[0.3 0.3 1],'linewidth',2)
hold on
plot(dynamicValsMean(ww).t_ccg*1000,dynamicValsMean(ww).ccg(:,1,1)./2000,'Color',[0 0 0.5],'linewidth',2)

legend('Trained','Scrambled','Mean')

pos = [0.60 0.55 0.2 0.4];
subplot('Position',pos)

ww = indices(3);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,1,1)./2000,'Color',[0.7 0.7 1],'linewidth',2)
hold on
plot(dynamicValsScrambled(ww).t_ccg*1000,dynamicValsScrambled(ww).ccg(:,1,1)./2000,'Color',[0.3 0.3 1],'linewidth',2)
hold on
plot(dynamicValsMean(ww).t_ccg*1000,dynamicValsMean(ww).ccg(:,1,1)./2000,'Color',[0 0 0.5],'linewidth',2)

legend('Trained','Scrambled','Mean')

NiceSave([network 'NetworkACGComparison'],path,[])

end