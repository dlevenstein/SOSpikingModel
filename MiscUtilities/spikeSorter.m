function spikesbycell = spikeSorter(spikes)

cellID = min(spikes(:,2)):max(spikes(:,2));

for cc = cellID
    
spikesbycell{cc} = spikes(spikes(:,2)==cc,1);

end

end
