function [Espikes,Ispikes] = RasterSorter(SimValues)

spikesbycell = SimValues.spikesbycell;

Espikes = SimValues.spikes(find(SimValues.spikes(:,2) <= SimValues.EcellIDX(end)),:);
Ispikes = SimValues.spikes(find(SimValues.spikes(:,2) > SimValues.EcellIDX(end)),:);

Erates = zeros(1,length(SimValues.EcellIDX));
Irates = zeros(1,length(SimValues.IcellIDX));

for ee = 1:2000
    
    S = spikesbycell{ee};
    Erates(ee) = length(S);
    
end

for ii = 2001:2500
    
    S = spikesbycell{ii};
    Irates(ii) = length(S);
    
end

for ee = 1:2000
    
    [c,id] = max(Erates);
    Erates(id) = nan;
    Espikes(find(Espikes(:,2)==id),2) = ee;
    
end

for ii = 2001:2500
    
    [c,id] = max(Irates);
    Irates(id) = nan;
    Ispikes(find(Ispikes(:,2)==id),2) = ii;
    
end


end