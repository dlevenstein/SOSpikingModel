dinfo = dir;

S = [];

for ii = 3:length(dinfo)
    
    load(dinfo(ii).name);
    id = find(spikes(:,1) > 1e3);
    ss = spikes(id,:);
    ss(:,1) = ss(:,1) - 1e3;
    
    if isempty(S) == false
        ss(:,1) = ss(:,1) + S(end,1);
    end
    
    if isempty(ss) == false
    figure
    subplot(3,1,1)
    plot(spikes(:,1),spikes(:,2),'.k','markersize',1)
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot')
    xlim([0 3000]);ylim([0 2500])
    NiceSave([dinfo(ii).name],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/Figures/9-27-2018/rasters','SpikeRasters')
    close all
    end
    
    S = [S;ss];
    
end
   
%%
% figure
% plot(S(:,1),S(:,2),'.k','markersize',1)

%%

spikesbycell = spikeSorter(S);

%%
%ISI distributions
ISIdist.bins = linspace(0,3.5,25);
ISIs = cellfun(@diff,spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{1:2000})),ISIdist.bins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{2001:length(ISIs)})),ISIdist.bins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
ISIdist.all = cat(1,ISIdist.all{:});
ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));

cellrates = cellfun(@length,spikesbycell)./(S(end,1)./1000);

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,1:2000,'stable');
sortrate.Ionly = intersect(sortrate.all,2001:2500,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);

Espikes = cat(1,spikesbycell{1:2000});
Ispikes = cat(1,spikesbycell{2001:2499});
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

A = repmat(1,size(log10(ISIdist.all(sortrate.ratetype,:))));
A(log10(ISIdist.all(sortrate.ratetype,:)) == -inf) = 0;

%%

ss = '3';

figure
subplot(2,2,1)
imagesc(ISIdist.bins,[0 max(2500)],log10(ISIdist.all(sortrate.ratetype,:)))
hold on
plot(ISIdist.bins([1 end]),min(2001).*[1 1],'k')
alpha(A);
ylabel('Neuron (sort by Rate, Type)')
h = colorbar;
ylabel(h,'log P(ISI)')
%colormap(isicolormap)
%caxis([0 1])
xlabel('ISI (ms)');%title([titlename ' 180 pA'])

subplot(2,2,3)
    plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
    hold on
    plot(t_ccg*1000,ccg(:,2,2)./500,'r')
    xlabel('t lag');ylabel('Rate');%title('Cross-Correlogram 180 pA')
    ylim([0 15])

NiceSave(['LogNormal_Sigma' ss 'bistability_Rate'],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/Figures/9-27-2018',[])
%NiceSave(['Uniform' ss 'bistability_Rate'],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/Figures/9-27-2018',[])