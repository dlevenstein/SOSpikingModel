function makeCurrentFigures(currentVals,indices,networknames,legendnames,network,path)

figure
pos4 = [0.1 0.55 0.38 0.4];
subplot('Position',pos4)

ww = indices(1);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,1:2000),2),'Color',[0.7 0.7 1],'linewidth',2)
hold on

ww = indices(2);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,1:2000),2),'Color',[0.3 0.3 1],'linewidth',2)
hold on

ww = indices(3);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,1:2000),2),'Color',[0 0 0.5],'linewidth',2)

%LogScale('x',10)
ylabel('Correlation','fontsize',20);title('Current Correlation','fontsize',20)

legend(legendnames(indices),'Location','southeast')

pos1 = [0.1 0.1 0.38 0.4];
subplot('Position',pos1)

ww = indices(1);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,2001:2500),2),'Color',[1 0.7 0.7],'linewidth',2)
hold on

ww = indices(2);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,2001:2500),2),'Color',[1 0.3 0.3],'linewidth',2)
hold on

ww = indices(3);
plot(currentVals(ww).t_lags,mean(currentVals(ww).C(:,2001:2500),2),'Color',[0.5 0 0],'linewidth',2)

%LogScale('x',10)
xlabel('Time (ms)','fontsize',20);ylabel('Correlation','fontsize',20)

legend(legendnames(indices),'Location','southeast')

NiceSave([network 'CurrentCorrelation'],path,[])

%%
figure
subplot(2,2,1)

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
xlabel('Weight (nS)','fontsize',20);ylabel('Peak Height','fontsize',20);title('Current Correlations','fontsize',20)

subplot(2,2,3)

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

NiceSave([network 'CurrentValues'],path,[])


end