function [dynamicVals,kvals] = AnalyzeDynamics(SimValuesArray)

%%
KweightE = zeros(2500,1);
KweightI = zeros(2500,1);
Kweight = zeros(2500,1);

Krate = zeros(2500,1);

%figure
for ii = 1:length(SimValuesArray)
       
    for jj = 1:2500
        
        KweightE(jj) = sum(SimValuesArray(ii).WeightMat(jj,1:2000,2));
        KweightI(jj) = sum(SimValuesArray(ii).WeightMat(jj,2001:2500,2));
        Kweight(jj)  = KweightE(jj)/KweightI(jj);
        
        spikes = SimValuesArray(ii).spikesbycell{jj};
        
        Krate(jj) = length(spikes).*(1000./SimValuesArray(ii).t(end));
        
    end
    
    kvals(ii).Kweight = Kweight;
    kvals(ii).Krate = Krate;

end

for ii = 1:length(SimValuesArray)
        
    S = find(SimValuesArray(ii).spikes(:,1) > 1e3);
    SimValuesArray(ii).spikesbycell = spikeSorter(SimValuesArray(ii).spikes(S,:),1,2500);
    
    ISI_E = [];
    ISI_I = [];
    
    for jj = 1:2500
        
        if jj <= 2000
            ISI_E = [ISI_E;diff(SimValuesArray(ii).spikesbycell{jj})];
        end
        if jj > 2000
            ISI_I = [ISI_I;diff(SimValuesArray(ii).spikesbycell{jj})];
        end
        
    end
    
    bins = linspace(0,4,50);
    
    ISImapE = hist(log10(ISI_E),bins);
    ISImapI = hist(log10(ISI_I),bins);
    
    rateDistE = hist(log10(1000./ISI_E),bins);
    rateDistI = hist(log10(1000./ISI_I),bins);
    
    %ISI distirbutions
    ISIdist.bins = linspace(0,3.5,50);
    ISIs = cellfun(@diff,SimValuesArray(ii).spikesbycell,'uniformoutput',false);
    ISIdist.E = hist(log10(cat(1,ISIs{SimValuesArray(ii).EcellIDX})),ISIdist.bins);
    ISIdist.E = ISIdist.E./sum(ISIdist.E);
    ISIdist.I = hist(log10(cat(1,ISIs{SimValuesArray(ii).IcellIDX})),ISIdist.bins);
    ISIdist.I = ISIdist.I./sum(ISIdist.I);

    ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
    ISIdist.all = cat(1,ISIdist.all{:});
    ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));

    %ISI statistics
    ISIstats.mean = cellfun(@mean,ISIs);
    ISIstats.std = cellfun(@std,ISIs);
    ISIstats.CV = ISIstats.std./ISIstats.mean;

    ISIstats.CVdist.bins = linspace(0,3,30);
    ISIstats.CVdist.E = hist(ISIstats.CV(SimValuesArray(ii).EcellIDX),ISIstats.CVdist.bins);
    ISIstats.CVdist.I = hist(ISIstats.CV(SimValuesArray(ii).IcellIDX),ISIstats.CVdist.bins);

    Espikes = cat(1,SimValuesArray(ii).spikesbycell{SimValuesArray(ii).EcellIDX});
    Ispikes = cat(1,SimValuesArray(ii).spikesbycell{SimValuesArray(ii).IcellIDX});
    [ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.001,'duration',0.1,'norm','rate');

    cellrates = cellfun(@length,SimValuesArray(ii).spikesbycell)./(SimValuesArray(ii).t(end)./1000);

    [~,sortrate.all] =sort(cellrates);
    sortrate.Eonly = intersect(sortrate.all,SimValuesArray(ii).EcellIDX,'stable');
    sortrate.Ionly = intersect(sortrate.all,SimValuesArray(ii).IcellIDX,'stable');
    sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

    [~,sortrate.raster] = sort(sortrate.ratetype);
    
    [d,d,w] = findpeaks(ccg(:,1,1)./2000,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
    peakwidth(1) = w(1);
    peakheight(1) = max(ccg(:,1,1)./2000) - min(ccg(:,1,1)./2000);
   
    [d,d,w] = findpeaks(ccg(:,2,2)./500,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
    peakwidth(2) = w(1);
    peakheight(2) = max(ccg(:,2,2)./500) - min(ccg(:,2,2)./500);
    
    dynamicVals(ii).t_ccg = t_ccg;
    dynamicVals(ii).ccg = ccg;
    
    dynamicVals(ii).ISIdist = ISIdist;
    
    dynamicVals(ii).bins = bins;
    dynamicVals(ii).ISImapE = ISImapE;
    dynamicVals(ii).ISImapI = ISImapI;
    
    dynamicVals(ii).rateDistE = rateDistE;
    dynamicVals(ii).rateDistI = rateDistI;
    
    dynamicVals(ii).peakwidth = peakwidth;
    dynamicVals(ii).peakheight = peakheight;
    
    dynamicVals(ii).sortrate = sortrate;
    
end

end