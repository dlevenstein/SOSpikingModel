function [ UPDOWN,ratehist,durhist ] = DOWNdetection( spikes,varargin )
%mean, CV, UP/DOWN times,
%option: try multiple rate bins, thresholds
%
%OPTIONS
%   'threshold'     Rate threshold - below this is DOWN state (default: 0.5Hz)
%   'binsize'       (Gaussian) Binning window for calculating rate (default: 25 ms)
%   'SHOWFIG'       show the figure (default: true)
%   'numcells'      this is to account for simulations in which not all
%                   cells spike. However, this should be updated to 
%                   should put in cell array form instead
%   'simdur'        duration of the simulation (default: last spike)


%% Options
p = inputParser;
addParameter(p,'threshold',0.2);
addParameter(p,'binsize',25);
addParameter(p,'SHOWFIG',true);
addParameter(p,'numcells',2500);
addParameter(p,'simdur',Inf);
addParameter(p,'savefolder',pwd);



parse(p,varargin{:})

threshold = p.Results.threshold;
binsize = p.Results.binsize;
SHOWFIG = p.Results.SHOWFIG;
numcells = p.Results.numcells;
simdur = p.Results.simdur;
savefolder = p.Results.savefolder;
%%

ratehist.numbins = 150;
ratehist.bins = linspace(-2,1.5,ratehist.numbins);



spikemat = bz_SpktToSpkmat(spikes,'dt',1,'binsize',binsize,...
    'bintype','gaussian','units','rate','win',[0 simdur]);
spikemat.allrate = mean(spikemat.data,2)*1000;

%Rate histogram
ratehist.hist = hist(log10(spikemat.allrate),ratehist.bins);


%% UP/DOWN detection

IDX.timestamps = spikemat.timestamps;
IDX.statenames = {'UP','DOWN'};
IDX.states = single(spikemat.allrate>threshold);
IDX.states(spikemat.allrate<=threshold)=2;
UPDOWN.ints = bz_IDXtoINT(IDX);
UPDOWN.dur.UP = diff(UPDOWN.ints.UPstate,[],2);
UPDOWN.dur.DOWN = diff(UPDOWN.ints.DOWNstate,[],2);
    
[UPspikes,inUP] = InIntervals(spikes(:,1),UPDOWN.ints.UPstate);
UPDOWN.UPrate = [];
for uu = unique(inUP)'
    if uu == 0
        continue
    end
    UPDOWN.UPrate(uu) = sum(inUP==uu)./UPDOWN.dur.UP(uu);
end

durhist.bins = linspace(0.5,4,25);
durhist.UP = hist(log10(UPDOWN.dur.UP),durhist.bins);
durhist.UP = durhist.UP./sum(durhist.UP);
durhist.DOWN = hist(log10(UPDOWN.dur.DOWN),durhist.bins);
durhist.DOWN = durhist.DOWN./sum(durhist.DOWN);
durhist.mean.UP = mean(UPDOWN.dur.UP);
durhist.mean.DOWN = mean(UPDOWN.dur.DOWN);
durhist.CV.UP = std(UPDOWN.dur.UP)./mean(UPDOWN.dur.UP);
durhist.CV.DOWN = std(UPDOWN.dur.DOWN)./mean(UPDOWN.dur.DOWN);

ratehist.summstats.meanrate = mean(spikemat.allrate);
ratehist.summstats.meanUPrate = sum(UPspikes)./sum(UPDOWN.dur.UP); %spikes/ms
ratehist.summstats.meanUPrate = ratehist.summstats.meanUPrate.*1000./numcells; %spikes/cell/s

%%
if SHOWFIG
DOWNcolor = [0 0 0.8];

figure
    subplot(3,1,1)
    plot(spikes(:,1),spikes(:,2),'.')
    ylim([0 2500])
    hold on
    plot(spikemat.timestamps,bz_NormToRange((spikemat.allrate)),'k')
    y = get(gca,'Ylim');
    patch([UPDOWN.ints.DOWNstate(:,1) UPDOWN.ints.DOWNstate(:,2),...
        UPDOWN.ints.DOWNstate(:,2) UPDOWN.ints.DOWNstate(:,1)]',...
        repmat([y(1) y(1) y(2) y(2)],length(UPDOWN.ints.DOWNstate(:,1)),1)',...
        DOWNcolor,'FaceAlpha',0.2,'EdgeColor','none');
    bz_ScaleBar('ms')
    box off
    title('Entire Simulation')
    
    subplot(3,1,2)
    plot(spikes(:,1),spikes(:,2),'k.','markersize',1)
    ylim([0 2500])
    hold on
    plot(spikemat.timestamps,bz_NormToRange((spikemat.allrate)),'k')
    y = get(gca,'Ylim');
    patch([UPDOWN.ints.DOWNstate(:,1) UPDOWN.ints.DOWNstate(:,2),...
        UPDOWN.ints.DOWNstate(:,2) UPDOWN.ints.DOWNstate(:,1)]',...
        repmat([y(1) y(1) y(2) y(2)],length(UPDOWN.ints.DOWNstate(:,1)),1)',...
        DOWNcolor,'FaceAlpha',0.2,'EdgeColor','none');
    %plot(get(gca,'xlim'
    box off
    xlim([10000 15000])
    bz_ScaleBar('ms')
    title('Example Window')


subplot(3,3,7)
plot(log10(UPDOWN.dur.UP),log10(UPDOWN.UPrate),'.')
axis tight
box off
hold on
plot(durhist.bins,bz_NormToRange(durhist.DOWN))
plot(durhist.bins,bz_NormToRange(durhist.UP))
LogScale('xy',10)
xlabel('UP/DOWN Dur (ms)');ylabel('UP Rate')
legend('UP States','UP','DOWN')

subplot(3,3,8)
plot(ratehist.bins,(ratehist.hist))
axis tight
hold on
plot(log10(threshold).*[1 1],get(gca,'ylim'),'r')
LogScale('x',10)
box off
xlabel('Pop Rate (Hz)')

    if ~islogical(SHOWFIG)
        NiceSave('UPDOWNDetection',savefolder,SHOWFIG,'figtype','jpeg')
    end
end


end
