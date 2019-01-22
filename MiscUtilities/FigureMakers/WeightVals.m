function Network = WeightVals(SimValuesArray)

%%
for ww = 1:length(SimValuesArray)
    
w = SimValuesArray(ww).WeightMat(:,:,end);
w(find(w == 0)) = nan;

EBounds = [floor(log10(min(min(w(1:2000,1:2000))))) ceil(log10(max(max(w(1:2000,1:2000)))))];
IBounds = [floor(log10(min(min(w(1:2000,2001:2500))))) ceil(log10(max(max(w(1:2000,2001:2500)))))];

cellrates = cellfun(@length,SimValuesArray(ww).spikesbycell)./(SimValuesArray(ww).t(end)./1000);

SortedRate = zeros(1,2500);
ratesort = zeros(2,2500);

ratesort(1,:) = cellrates;
ratesort(2,:) = 1:2500;

for jj = 1:2500
    
    id = find(ratesort(1,:) == max(ratesort(1,:)));
    SortedRate(1,jj) = ratesort(2,max(id));
    ratesort(1,max(id)) = nan;
    ratesort(2,max(id)) = nan;
    
end

SortedRate = SortedRate(SortedRate < 2001);
    
B = 100;

Ebins = linspace(EBounds(1),EBounds(2),B);
Ibins = linspace(IBounds(1),IBounds(2),B);

wEDist = zeros(2000,B);
wIDist = zeros(2000,B);

for jj = 1:2000
    
    wiE(jj,1:2000) = reshape(w(SortedRate(jj),1:2000),[1,2000]);
    wiI(jj,1:500) = reshape(w(SortedRate(jj),2001:2500),[1,500]);
    
    wEDist(jj,:) = hist(log10(wiE(jj,:)),Ebins);
    wIDist(jj,:) = hist(log10(wiI(jj,:)),Ibins);
    
    wEDist(jj,:) = wEDist(jj,:)./sum(wEDist(jj,:));
    wIDist(jj,:) = wIDist(jj,:)./sum(wIDist(jj,:));
    
end

EEDist = hist(log10(reshape(w(1:2000,1:2000),[2000*2000,1])),Ebins);
EIDist = hist(log10(reshape(w(1:2000,2001:2500),[2000*500,1])),Ibins);

vals.Ebins = Ebins;
vals.Ibins = Ibins;

vals.EEDist = EEDist./sum(EEDist);
vals.EIDist = EIDist./sum(EIDist);

vals.wEDist = wEDist;
vals.wIDist = wIDist;

vals.meanEE = nanmean(reshape(w(1:2000,1:2000),[2000*2000,1]));
vals.meanEI = nanmean(reshape(w(1:2000,2001:2500),[2000*500,1]));

vals.varEE = nanvar(reshape(w(1:2000,1:2000),[2000*2000,1]));
vals.varEI = nanvar(reshape(w(1:2000,2001:2500),[2000*500,1]));

Network(ww) = vals;

end

end