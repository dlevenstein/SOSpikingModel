function [  ] = SpikingGraphVid( spikes,weights,celltypes,voltage )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%
spikes = SimValues.spikes;
weights = SimValues.WeightMat;
celltypes = ones(length([SimValues.EcellIDX SimValues.IcellIDX]));
celltypes(SimValues.IcellIDX) = 2;
%% Calculate the spring layout


%% Network Visualization

%Pick 100 randomcells
npick = 100;
repcells = randsample(1:length(celltypes),npick);

samplemat = weights([repcells,repcells]);
samplemat = MakeSymmetric(samplemat);
%%
%plotxy=Kamada(samplemat,0.01);
plotxy=Kamada(samplemat,0.01);

%%
cellcolors = (cellrate([repE,repI]));
cellcolors(isinf(cellcolors)) = min(~isinf(cellcolors))-1;
cellcolors= cellcolors+min(cellcolors);
figure
graphplot2D(plotxy,samplemat,2,cellcolors)
colorbar


%% Loop the video for spike times
%Possibly include voltage?

end

