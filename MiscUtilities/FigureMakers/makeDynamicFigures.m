function makeDynamicFigures(dynamicVals,indices,networknames,legendnames,network,path)

%%
figure

%subplot(2,2,1)

pos4 = [0.1 0.55 0.38 0.4];
subplot('Position',pos4)

ww = indices(1);
plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapE./sum(dynamicVals(ww).ISImapE),'Color',[0.7 0.7 1],'linewidth',2)
hold on

ww = indices(2);
plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapE./sum(dynamicVals(ww).ISImapE),'Color',[0.3 0.3 1],'linewidth',2)
hold on

ww = indices(3);
plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapE./sum(dynamicVals(ww).ISImapE),'Color',[0 0 0.5],'linewidth',2)

LogScale('x',10)
ylabel('Probability','fontsize',20);title('ISI','fontsize',20)

ylim([0 0.2])

legend(legendnames(indices))

%subplot(2,2,3)

pos1 = [0.1 0.1 0.38 0.4];
subplot('Position',pos1)

ww = indices(1);
plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapI./sum(dynamicVals(ww).ISImapI),'Color',[1 0.7 0.7],'linewidth',2)
hold on

ww = indices(2);
plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapI./sum(dynamicVals(ww).ISImapI),'Color',[1 0.3 0.3],'linewidth',2)
hold on

ww = indices(3);
plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapI./sum(dynamicVals(ww).ISImapI),'Color',[0.5 0 0],'linewidth',2)

LogScale('x',10)

xlabel('ISI (ms)','fontsize',20);ylabel('Probability','fontsize',20)

ylim([0 0.2])

legend(legendnames(indices))

%subplot(2,2,2)

pos2 = [0.57 0.55 0.38 0.4];
subplot('Position',pos2)

ww = indices(1);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,1,1)./2000,'Color',[0.7 0.7 1],'linewidth',2)
hold on

ww = indices(2);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,1,1)./2000,'Color',[0.3 0.3 1],'linewidth',2)
hold on

ww = indices(3);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,1,1)./2000,'Color',[0 0 0.5],'linewidth',2)

ylabel('Rate (Hz)','fontsize',20);title('ACG','fontsize',20)
ylim([0 5])

legend(legendnames(indices))

%subplot(2,2,4)

pos3 = [0.57 0.1 0.38 0.4];
subplot('Position',pos3)

ww = indices(1);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,2,2)./500,'Color',[1 0.7 0.7],'linewidth',2)
hold on

ww = indices(2);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,2,2)./500,'Color',[1 0.3 0.3],'linewidth',2)
hold on

ww = indices(3);
plot(dynamicVals(ww).t_ccg*1000,dynamicVals(ww).ccg(:,2,2)./500,'Color',[0.5 0 0],'linewidth',2)

xlabel('Time Lag (ms)','fontsize',20);ylabel('Rate (Hz)','fontsize',20)

legend(legendnames(indices))

NiceSave([network 'ISI_and_ACG'],path,[])

%%
figure

subplot(2,2,1)
for ww = 1:length(dynamicVals)
    plot(ww,dynamicVals(ww).peakheight(1),'.b','markersize',20)
    hold on
    plot(ww,dynamicVals(ww).peakheight(2),'.r','markersize',20)
    hold on
end

xticklabels(networknames)
xlim([0 length(dynamicVals)+1])
xlabel('Weight (nS)','fontsize',20);ylabel('Peak Height (ms)','fontsize',20);title('ACG','fontsize',20)

subplot(2,2,3)
for ww = 1:length(dynamicVals)
    plot(ww,dynamicVals(ww).peakwidth(1),'.b','markersize',20)
    hold on
    plot(ww,dynamicVals(ww).peakwidth(2),'.r','markersize',20)
    hold on
end 

xticklabels(networknames)
xlim([0 length(dynamicVals)+1])
xlabel('Weight (nS)','fontsize',20);ylabel('Peak Width (ms)','fontsize',20)

NiceSave([network 'ACGValues'],path,[])

end