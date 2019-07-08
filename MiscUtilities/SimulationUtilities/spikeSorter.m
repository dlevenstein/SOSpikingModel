function spikesbycell = spikeSorter(spikes,cellStart,cellEnd)
%spikesbycell = spikeSorter(spikes,cellStart,cellEnd)
%sorts spike times to each neuron
%
%INPUTS
%   spikes        array of spike times
%   cellStart     first cell ID
%   cellEnd       last cell ID
%
%OUTPUTS
%   spikesbycell  sorted spike times in a cell
%JGornet Summer 2019

%%
cellID = cellStart:cellEnd;

for cc = cellID

spikesbycell{cc} = spikes(spikes(:,2)==cc,1);

end

end
