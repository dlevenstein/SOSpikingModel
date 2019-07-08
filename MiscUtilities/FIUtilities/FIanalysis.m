function [rate,peakwidth,peakheight,lastspikes,S] = FIanalysis(II,path,varargin)

%[rate,peakwidth,peakheight,lastspikes,S] = FIanalysis(II,path,varargin)
%combs through all folders with FI simulations and calculates the rates and 
%duration of spiking activity.
%
%INPUTS
%   II              index for referencing correct I current array value
%   path            path to save figure value (set to [] when not saving
%                   figure
%   (optional)      for optional inputs, use: ('inputoption', inputvalue)
%       'showfig'       show and save figure
%       'bistable'      (true/false) set true if use high -> low current
%                       (default: true)
%
%OUTPUTS
%   rate            mean rate of simulation
%   peakwidth       width of ACG
%   peakheight      height of ACG
%   lastspikes      time of last spike (duration of spiking activity)
%   S               Spikes across all simulations
%JGornet Summer 2019

%%
p = inputParser;
addParameter(p,'showfig',false,@islogical)
addParameter(p,'bistable',true,@islogical)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;
bistable = p.Results.bistable;

%%

dinfo = dir;

numfig = 0;

S = [];

lastspikes = nan(1,100);
sim = 1;

Times = [];

rate.E = 0;
rate.I = 0;

peakwidth.E = 0;
peakheight.E = 0;

peakwidth.I = 0;
peakheight.I = 0;

Ivals = linspace(0,400,21);

for dd = 1:length(dinfo)
    
    try
        if dinfo(dd).bytes < 1e6
            load(dinfo(dd).name)
        else
            continue
        end
    catch
        continue
    end
    
    if exist('spikes','var')
    id = find(spikes(:,1) > 500);
    
    SimValues.spikes = spikes;
    SimValues.spikesbycell = spikeSorter(spikes,1,2500);
    SimValues.EcellIDX = 1:2000;
    SimValues.IcellIDX = 2001:2500;
    
    [Espikes,Ispikes] = RasterSorter(SimValues);
    
    if isempty(id) == false
    lastspikes(sim) = spikes(end,1) - (500);
    sim = sim + 1;
    end
    
    if bistable
        if isempty(S) == false
            S = [S;(spikes(id,1)-(500))+S(end,1),spikes(id,2)];
            Times = [Times spikes(end,1)];
        else
            S = [S;spikes(id,1)-(500),spikes(id,2)];
            Times = [Times spikes(end,1)];
            if length(S(:,1)) > 1e5
                break
            end
        end
    else
        if isempty(S) == false
            S = [S;(spikes(id,1)-(500))+S(end,1),spikes(id,2)];
            Times = [Times spikes(1,1)];
        else
            S = [S;spikes(id,1)-(500),spikes(id,2)];
            Times = [Times spikes(1,1)];
            if length(S(:,1)) > 1e5
                break
            end
        end
    end
    
    if numfig < 10 && SHOWFIG
    
    t = 0:0.5:3000;

    figure

    pos = [0.1,0.55,0.8,0.2];
    subplot('position',pos)
    
    plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
    hold on
    plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
    
    xlim([250 750]);ylim([0 2500])

    set(gca,'Xtick',[]);set(gca,'Ytick',[])

    pos = [0.1,0.3,0.8,0.2];
    subplot('position',pos)
    
    if bistable
    plot(t,(250 - Ivals(II)).*heaviside(500 - t)+Ivals(II),'k','LineWidth',2)
    xlim([250 750]);ylim([0 400])
    else
    plot(t,Ivals(II).*heaviside(t - 500),'k','LineWidth',2)
    xlim([450 3e3]);ylim([0 400])
    end
    
    set(gca,'Ytick',[])
    xlabel('Time (ms)','FontSize',14)
    
    NiceSave(['Bistability_Raster_II_' num2str(II) '_num_' num2str(numfig)],[path '/Rasters'],[]);
    close all
    numfig = numfig+1;
    
    else
        continue
    end
    end
    
end

if isempty(S) == false
   
Espikesbycell = spikeSorter(S,1,2000);
Ispikesbycell = spikeSorter(S,2001,2500);

else
    
peakwidth.E = 0;
peakheight.E = 0;

peakwidth.I = 0;
peakheight.I = 0;
    
end

%%

if ~isempty(S)

rate.E = (sum(cellfun(@length,Espikesbycell))./S(end,1)).*(1000./2000);
rate.I = (sum(cellfun(@length,Ispikesbycell))./S(end,1)).*(1000./500);
 
else

rate.E = 0; 
rate.I = 0;

peakheight.E = 0;
peakheight.I = 0;

peakwidth.E = nan;
peakwidth.I = nan;

end
end