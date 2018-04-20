function [ corrhist,condx,currx,currPETH ] = CheckBalance( SimValues,PopParams,timewin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% DEV
%timewin = [39000 40000];
%%
%% Calcualte each cell's spike rate and rate sortings
cellrates = cellfun(@length,SimValues.spikesbycell)./(SimValues.t(end)./1000);

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,SimValues.EcellIDX,'stable');
sortrate.Ionly = intersect(sortrate.all,SimValues.IcellIDX,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);


%% Pop Rate
poprate.dt = 0.5;   overlap = 4;   winsize = poprate.dt.*overlap;
[spikemat,t_rate,~] = SpktToSpkmat(SimValues.spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValues.EcellIDX),2)./(winsize./1000)./length(SimValues.EcellIDX);
poprate.I = sum(spikemat(:,SimValues.IcellIDX),2)./(winsize./1000)./length(SimValues.IcellIDX);

%% Spike statistics

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

%% Figure ISI, Vm distributions
isicolormap = [1 1 1; makeColorMap([1 1 1],[0.8 0 0])];
figure

    subplot(3,3,1:2)
        plot(SimValues.spikes(:,1),sortrate.raster(SimValues.spikes(:,2)),'k.','markersize',2)
        hold on
        plot(SimValues.t([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        ylim(max(SimValues.IcellIDX).*[0 1]);   xlim(timewin);
        ylabel('Cell (Sorted by rate)')
        
    subplot(6,3,7:8)
        plot(t_rate,poprate.E,'k')
        hold on
        plot(t_rate,poprate.I,'r')
           xlim(timewin); 
           xlabel('t (s)');ylabel('Pop. Rate (Spks/cell/s)')
        
    subplot(2,2,3)
        imagesc(ISIdist.bins,[0 max(SimValues.IcellIDX)],log10(ISIdist.all(sortrate.ratetype,:)))
        hold on
        plot(ISIdist.bins([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        LogScale('x',10)
        %title('ISI Distirbution');
        ylabel('Neuron (sort by Rate, Type)')
        h = colorbar;
        ylabel(h,'log P(ISI)')
        %colormap(isicolormap)
        %caxis([0 1])
        xlabel('ISI (ms)')
    subplot(4,2,6)
        plot(ISIstats.CVdist.bins,ISIstats.CVdist.E,'k','linewidth',2)
        hold on
        plot(ISIstats.CVdist.bins,ISIstats.CVdist.I,'r','linewidth',2)
        xlabel('ISI CV');ylabel('# Cells')
        
    subplot(4,3,6)
        [ax,e,i] = plotyy(t_ccg*1000,ccg(:,1,1)./length(SimValues.EcellIDX),t_ccg*1000,ccg(:,1,2)./length(SimValues.IcellIDX));
        set(e,'color','k');set(e,'linewidth',1)
        set(i,'color','r');set(i,'linewidth',1)
        hold on
        plot([0 0],get(gca,'ylim'),'k')
        xlim([-25 25])
        %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
        xlabel('t lag from E spike (ms)')
	subplot(4,3,3)
        [ax,e,i] = plotyy(t_ccg*1000,ccg(:,2,1)./length(SimValues.EcellIDX),t_ccg*1000,ccg(:,2,2)./length(SimValues.IcellIDX));
        set(e,'color','k');set(e,'linewidth',1)
        set(i,'color','r');set(i,'linewidth',1)
        hold on
        plot([0 0],get(gca,'ylim'),'k')
        xlim([-25 25])
        %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
        xlabel('t lag from I spike (ms)')
        
    subplot(4,2,8)
        plot(log10(binsizes),popcorr,'k','linewidth',2)
        LogScale('x',10)
        xlabel('Spike Bin Size (ms)');ylabel('E-I Rate Correlation')
        
%% Conductance/Current Balance

%Current/Conductance correlations
currents.E = SimValues.g_e.*(SimValues.V-PopParams.E_e);
currents.I = SimValues.g_i.*(SimValues.V-PopParams.E_i);

gcorr = corr(SimValues.g_e',SimValues.g_i','type','spearman');
gcorr = diag(gcorr);
currcorr = corr(currents.E',currents.I','type','spearman');
currcorr = diag(currcorr);

corrhist.bins = linspace(-1,1,101);
corrhist.currE = hist(currcorr(SimValues.EcellIDX),corrhist.bins);
corrhist.currI = hist(currcorr(SimValues.IcellIDX),corrhist.bins);
corrhist.gE = hist(gcorr(SimValues.EcellIDX),corrhist.bins);
corrhist.gI = hist(gcorr(SimValues.IcellIDX),corrhist.bins);

[~,sortgcorr] = sort(gcorr);
[~,sortcurrcorr] = sort(currcorr);

% Spike-triggered averages
maxlag = 50;  %ms
maxlag_dt = maxlag./SimValues.t(2);  %convert to dt units
numcells = PopParams.EPopNum+PopParams.IPopNum;
EIcurrx = zeros(2.*maxlag_dt+1,numcells); EIcondx = zeros(2.*maxlag_dt+1,numcells);
currPETH.e = zeros(2.*maxlag_dt+1,numcells);
currPETH.i = zeros(2.*maxlag_dt+1,numcells);
for nn = 1:(PopParams.EPopNum+PopParams.IPopNum)
    [EIcurrx(:,nn),t_lags] = xcov(currents.E(nn,:),currents.I(nn,:),maxlag_dt,'coeff');
    [EIcondx(:,nn),t_lags] = xcov(SimValues.g_e(nn,:),SimValues.g_i(nn,:),maxlag_dt,'coeff'); 
    [currPETH.e(:,nn)] = EventVsContinousCCG(currents.E(nn,:)',SimValues.t',SimValues.spikesbycell{nn},maxlag);
    [currPETH.i(:,nn)] = EventVsContinousCCG(currents.I(nn,:)',SimValues.t',SimValues.spikesbycell{nn},maxlag);
    [currPETH.syn(:,nn)] = EventVsContinousCCG(currents.I(nn,:)'+currents.E(nn,:)',SimValues.t',SimValues.spikesbycell{nn},maxlag);
end

currPETH.tlags=t_lags;
currPETH.meanEE = nanmean(currPETH.e(:,SimValues.EcellIDX),2);
currPETH.meanEI = nanmean(currPETH.i(:,SimValues.EcellIDX),2);
currPETH.meanEsyn = nanmean(currPETH.syn(:,SimValues.EcellIDX),2);
currPETH.meanIE = nanmean(currPETH.e(:,SimValues.IcellIDX),2);
currPETH.meanII = nanmean(currPETH.i(:,SimValues.IcellIDX),2);
currPETH.meanIsyn = nanmean(currPETH.syn(:,SimValues.IcellIDX),2);

currx.tlags = t_lags; condx.tlags = t_lags;
currx.meanE = nanmean(EIcurrx(:,SimValues.EcellIDX),2);
currx.meanI = nanmean(EIcurrx(:,SimValues.IcellIDX),2);
condx.meanE = nanmean(EIcondx(:,SimValues.EcellIDX),2);
condx.meanI = nanmean(EIcondx(:,SimValues.IcellIDX),2);

%%
figure
subplot(3,2,1)
    plot(corrhist.bins,corrhist.currE,'k','linewidth',1)
    hold on
    plot(corrhist.bins,corrhist.currI,'r','linewidth',1)
        plot(corrhist.bins,corrhist.gE,'k--','linewidth',1)
    hold on
    plot(corrhist.bins,corrhist.gI,'r--','linewidth',1)
    axis tight
    plot([0 0],get(gca,'ylim'),'k:')
    box off
    xlabel('E/I Input Correlation');
    ylabel('# Cells')
    legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')

subplot(3,2,3)
    plot(currx.tlags,currx.meanE,'k','linewidth',1)
    hold on
    plot(condx.tlags,condx.meanE,'k--','linewidth',1)
    plot(currx.tlags,currx.meanI,'r','linewidth',1)
    plot(condx.tlags,condx.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lags([1 end]),[0 0],'k')
    legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')

subplot(3,2,2)
    plot(currPETH.tlags,currPETH.meanEE,'k','linewidth',1)
    hold on
    plot(currPETH.tlags,currPETH.meanEI,'r','linewidth',1)
    plot(currPETH.tlags,currPETH.meanEsyn,'color',[0.5 0.5 0.5],'linewidth',2)
    plot([0 0],get(gca,'ylim'),'k:')
    plot(currPETH.tlags([1 end]),[0 0],'k')
    xlabel('t lag from E spike (ms)')
    ylabel('Mean Current Input')
    legend('E->E','I->E','Total Synaptic','location','southeast')

subplot(3,2,4)
    plot(currPETH.tlags,currPETH.meanIE,'k','linewidth',1)
    hold on
    plot(currPETH.tlags,currPETH.meanII,'r','linewidth',1)
    plot(currPETH.tlags,currPETH.meanIsyn,'color',[0.5 0.5 0.5],'linewidth',1)
    plot([0 0],get(gca,'ylim'),'k:')
    plot(currPETH.tlags([1 end]),[0 0],'k')
    legend('E->I','I->I','Total Synaptic','location','southeast')
    xlabel('t lag from I spike (ms)')
    ylabel('Mean Current Input')


end

