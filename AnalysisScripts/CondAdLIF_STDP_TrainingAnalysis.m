
% names = ["logSigmaWeight_01_testing","logSigmaWeight_1_testing","logSigmaWeight_10_testing","logSigmaWeight_001_testing"];
% vals = ["0.1","1","10","0.01"];
% order = [2,3,4,1];
% numvals = [0.01,0.1,1,10];

% names = ["ExperimentRate_s_01_testing","ExperimentRate_s_1_testing","ExperimentRate_s_10_testing","ExperimentRate_s_001_testing"];
% vals = ["0.1","1","10","0.01"];
% order = [2,3,4,1];
% numvals = [0.01,0.1,1,10];

% names = ["logMuWeight_01_testing","logMuWeight_1_testing","logMuWeight_10_testing","logMuWeight_03_testing","logMuWeight_3_testing"];
% vals = ["0.1","1","10","0.01"];
% order = [1,3,5,2,4];
% numvals = [0.1,0.3,1,3,10];

peakwidth = zeros(2,5);
peakrate = zeros(2,5);
peakheight = zeros(2,5);

%%
figure

for ii = 1:5
    
    load(['/Users/jonathangornet/Desktop/TestRuns/' char(names(ii))]);
    
    SimValues.spikesbycell = spikeSorter(SimValues.spikes,1,2500);
    
    %ISI distirbutions
    ISIdist.bins = linspace(0,3.5,50);
    ISIs = cellfun(@diff,SimValues.spikesbycell,'uniformoutput',false);
    ISIdist.E = hist(log10(cat(1,ISIs{SimValues.EcellIDX})),ISIdist.bins);
    ISIdist.E = ISIdist.E./sum(ISIdist.E);
    ISIdist.I = hist(log10(cat(1,ISIs{SimValues.IcellIDX})),ISIdist.bins);
    ISIdist.I = ISIdist.I./sum(ISIdist.I);

    ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
    ISIdist.all = cat(1,ISIdist.all{:});
    ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));

    %ISI statistics
    ISIstats.mean = cellfun(@mean,ISIs);
    ISIstats.std = cellfun(@std,ISIs);
    ISIstats.CV = ISIstats.std./ISIstats.mean;

    ISIstats.CVdist.bins = linspace(0,3,30);
    ISIstats.CVdist.E = hist(ISIstats.CV(SimValues.EcellIDX),ISIstats.CVdist.bins);
    ISIstats.CVdist.I = hist(ISIstats.CV(SimValues.IcellIDX),ISIstats.CVdist.bins);

    Espikes = cat(1,SimValues.spikesbycell{SimValues.EcellIDX});
    Ispikes = cat(1,SimValues.spikesbycell{SimValues.IcellIDX});
    [ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

    %Rate Statistics
    binsizes = logspace(-0.5,2,20);
    popcorr = zeros(size(binsizes));
    for bb = 1:length(binsizes)
        [popmat] = SpktToSpkmat({Espikes,Ispikes}, [], binsizes(bb));
        popcorr(bb) = corr(popmat(:,1),popmat(:,2),'type','spearman');
    end

    cellrates = cellfun(@length,SimValues.spikesbycell)./(SimValues.t(end)./1000);

    [~,sortrate.all] =sort(cellrates);
    sortrate.Eonly = intersect(sortrate.all,SimValues.EcellIDX,'stable');
    sortrate.Ionly = intersect(sortrate.all,SimValues.IcellIDX,'stable');
    sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

    [~,sortrate.raster] = sort(sortrate.ratetype);
    
    val             = (max(ccg(:,1,1)./2000)-min(ccg(:,1,1)./2000))./2 + min(ccg(:,1,1)./2000);
    minDistLeft     = abs(val-movmean(ccg(1:500,1,1)./2000,10));
    minDistRight    = abs(val-movmean(ccg(501:1001,1,1)./2000,10));

    sortedMinDistLeft   = sort(minDistLeft);
    sortedMinDistRight  = sort(minDistRight);

    id1 = min(find(minDistLeft==min(minDistLeft)));
    id2 = min(500+find(minDistRight==min(minDistRight)));

    peakwidth(1,order(ii)) = t_ccg(id2)*1000 - t_ccg(id1)*1000;
    peakrate(1,order(ii)) = max(ccg(:,1,1)./2000);
    peakheight(1,order(ii)) = max(ccg(:,1,1)./2000) - min(ccg(:,1,1)./2000);
    
    val             = (max(ccg(:,2,2)./500)-min(ccg(:,2,2)./500))./2 + min(ccg(:,2,2)./500);
    minDistLeft     = abs(val-movmean(ccg(1:500,2,2)./500,10));
    minDistRight    = abs(val-movmean(ccg(501:1001,2,2)./500,10));

    sortedMinDistLeft   = sort(minDistLeft);
    sortedMinDistRight  = sort(minDistRight);

    id1 = min(find(minDistLeft==min(minDistLeft)));
    id2 = min(500+find(minDistRight==min(minDistRight)));

    peakwidth(2,order(ii)) = t_ccg(id2)*1000 - t_ccg(id1)*1000;
    peakrate(2,order(ii)) = max(ccg(:,2,2)./500);
    peakheight(2,order(ii)) = max(ccg(:,2,2)./500) - min(ccg(:,2,2)./500);

%     subplot(3,5,5.*(ii-1)+1)
%     
%     xlabel('s')
    
    if ii > 3
        continue
    end
    
    subplot(3,5,[5.*(ii-1)+2 5.*(ii-1)+3])
    plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','markersize',1);
    xlim([9800 1e4]);ylim([0 2500])
    xlabel('Time (ms)','fontsize',20);ylabel('Neuron ID','fontsize',20);title(['Raster m: ' char(vals(ii))],'fontsize',20)
    
    subplot(3,5,5.*(ii-1)+4)
    plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
    hold on
    plot(t_ccg*1000,ccg(:,2,2)./500,'r')
    xlabel('Time Lag (ms)','fontsize',20);ylabel('Rate (Hz)','fontsize',20);title(['Cross-Correlogram m: ' char(vals(ii))],'fontsize',20)
    
    subplot(3,5,5.*(ii-1)+5)
    A = repmat(1,size(ISIdist.all(sortrate.ratetype,:)));
    A(ISIdist.all(sortrate.ratetype,:) == 0) = 0; 
    imagesc(ISIdist.bins,[0 max(SimValues.IcellIDX)],log10(ISIdist.all(sortrate.ratetype,:)))
        
        hold on
        plot(ISIdist.bins([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        LogScale('x',10)
        
        alpha(A);
        %title('ISI Distirbution');
        ylabel('Neuron (sort by Rate, Type)')
        h = colorbar;
        ylabel(h,'log P(ISI)')
        %colormap(isicolormap)
        %caxis([0 1])
    xlabel('ISI (ms)','fontsize',20);ylabel('Neuron (sort by rate)','fontsize',20)
    
end

%%
subplot(3,5,1)
plot(numvals,peakrate(1,:),'.b','markersize',50)
hold on
plot(numvals,peakrate(2,:),'.r','markersize',50)
xlim([-1 11]);ylim([0 inf+1])
xlabel('m (pS)','fontsize',20);ylabel('Rate (Hz)','fontsize',20);title('Peak Rate','fontsize',20)

subplot(3,5,6)
plot(numvals,peakheight(1,:),'.b','markersize',50)
hold on
plot(numvals,peakheight(2,:),'.r','markersize',50)
xlim([-1 11]);ylim([0 inf+1])
xlabel('m (pS)','fontsize',20);ylabel('Rate (Hz)','fontsize',20);title('Peak Height','fontsize',20)

subplot(3,5,11)
plot(numvals,peakwidth(1,:),'.b','markersize',50)
hold on
plot(numvals,peakwidth(2,:),'.r','markersize',50)
xlim([-1 11]);ylim([0 inf+1])
xlabel('m (pS)','fontsize',20);ylabel('Time (ms)','fontsize',20);title('Peak Width','fontsize',20)
