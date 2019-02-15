function spikesbycell = spikeSorter(spikes,cellStart,cellEnd)

cellID = cellStart:cellEnd;

for cc = cellID

spikesbycell{cc} = spikes(spikes(:,2)==cc,1);

end

end
