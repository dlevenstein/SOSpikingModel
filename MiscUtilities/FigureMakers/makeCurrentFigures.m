function makeCurrentFigures(currentVals,indices,networknames,legendnames,network,path)

%%
figure
pos = [0.1 0.55 0.38 0.4];
subplot('Position',pos)

ww = indices(1);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,1:2000),2),'Color',[0.7 0.7 1],'linewidth',2)
hold on

ww = indices(2);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,1:2000),2),'Color',[0.3 0.3 1],'linewidth',2)
hold on

ww = indices(3);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,1:2000),2),'Color',[0 0 0.5],'linewidth',2)

set(gca,'xticklabel',[])

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

ylabel('Correlation','fontsize',20);title('Current Correlation','fontsize',20)

legend(legendnames(indices),'Location','southeast')

box OFF

pos = [0.1 0.1 0.38 0.4];
subplot('Position',pos)

ww = indices(1);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,2001:2500),2),'Color',[1 0.7 0.7],'linewidth',2)
hold on

ww = indices(2);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,2001:2500),2),'Color',[1 0.3 0.3],'linewidth',2)
hold on

ww = indices(3);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,2001:2500),2),'Color',[0.5 0 0],'linewidth',2)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

%LogScale('x',10)
xlabel('Time (ms)','fontsize',20);ylabel('Correlation','fontsize',20)

legend(legendnames(indices),'Location','southeast')

box OFF

%NiceSave([network 'CurrentCorrelation'],path,[])

pos = [0.58 0.55 0.38 0.4];
subplot('Position',pos)

for ww = 1:length(currentVals)
plot(ww,currentVals(ww).peakheightE,'.b','markersize',20)
hold on
end

for ww = 1:length(currentVals)
plot(ww,currentVals(ww).peakheightI,'.r','markersize',20)
hold on
end

xticklabels(networknames)
xlim([0 length(currentVals)+1])

set(gca,'xticklabel',[])

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

ylabel('Peak Height','fontsize',20);title('Current Correlations','fontsize',20)

box OFF

pos = [0.58 0.1 0.38 0.4];
subplot('Position',pos)

for ww = 1:length(currentVals)
plot(ww,currentVals(ww).peakwidthE,'.b','markersize',20)
hold on
end

for ww = 1:length(currentVals)
plot(ww,currentVals(ww).peakwidthI,'.r','markersize',20)
hold on
end

xticklabels(networknames)
xlim([0 length(currentVals)+1])
xlabel('Weight (nS)','fontsize',20);ylabel('Peak Width (ms)','fontsize',20)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

box OFF

NiceSave([network 'CurrentValues'],path,[])

end