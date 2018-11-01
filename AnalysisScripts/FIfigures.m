function [rate,peakwidth,peakheight,lastspikes] = FIfigures(ii,name,path)

dinfo = dir;

S = [];

lastspikes = nan(1,100);
sim = 1;

for dd = 1:length(dinfo)
    
    try

    load(dinfo(dd).name)
        
    id = find(spikes(:,1) > 1e3);
    
%     if spikes(end,1) > 1e3
%     figure
%     plot(spikes(:,1),spikes(:,2),'.k','markersize',1)
%     hold on
%     plot([1e3 1e3], [0 2500],'r')
%     xlim([0 3e3])
%     end
    
    lastspikes(sim) = spikes(end,1) - 1e3;
    sim = sim + 1;
    
    if isempty(S) == false
        S = [S;spikes(id,1)+S(end,1),spikes(id,2)];
    else
        S = [S;spikes(id,1)-1e3,spikes(id,2)];
        if length(S(:,1)) > 1e4
            break
        end
    end
    
    end
    
end

if isempty(S) == false
   
spikesbycell = spikeSorter(S,1,2500);

% figure
% 
% subplot(3,1,1)
% plot(S(:,1),S(:,2),'.k','markersize',1)
% xlim([0 S(end,1)]);ylim([0 2500])
% xlabel('Time (ms)');ylabel('Neuron ID')

Espikesbycell = spikeSorter(S,1,2000);
Ispikesbycell = spikeSorter(S,2001,2500);

ISI_E = [];
ISI_I = [];

for ii = 1:2500

    if ii <= 2000
        ISI_E = [ISI_E; diff(Espikesbycell{ii})];
    end
    if ii > 2000
        ISI_I = [ISI_I; diff(Ispikesbycell{ii})];
    end
   
end

rate.E = 1000./mean(ISI_E);
rate.I = 1000./mean(ISI_I);

bins = linspace(0,4,25);

rate.Edist = hist(log10(1000./ISI_E), bins);
rate.Idist = hist(log10(1000./ISI_I), bins);

rate.bins = bins;

else
    
    rate.Edist = zeros(1,25);
    rate.Idist = zeros(1,25);

    rate.E = 0;
    rate.I = 0;
    
    peakwidth.E = 0;
    peakheight.E = 0;

    peakwidth.I = 0;
    peakheight.I = 0;
    
end

%%

if length(S(:,1)) >= 1e3
    

Espikes = cat(1,spikesbycell{1:2000});
Ispikes = cat(1,spikesbycell{2001:2500});
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

[d,d,w] = findpeaks(movmean(ccg(:,1,1)./2000,10),t_ccg*1000,'Annotate','extents','WidthReference','halfheight'); 
peakwidth.E = max(w);
peakheight.E = max(ccg(:,1,1)./2000);

% subplot(3,1,2)
% plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
% xlabel('Time Lag (ms)');ylabel('Rate (Hz)')

[d,d,w] = findpeaks(movmean(ccg(:,2,2)./500,10),t_ccg*1000,'Annotate','extents','WidthReference','halfheight');
peakwidth.I = max(w);
peakheight.I = max(ccg(:,2,2)./500);

% subplot(3,1,3)
% plot(t_ccg*1000,ccg(:,2,2)./500,'r')
% xlabel('Time Lag (ms)');ylabel('Rate (Hz)')
% 
% NiceSave([name num2str(ii)],path,[]);

else
    
%     NiceSave([name num2str(ii)],path,[]);
    
    peakwidth.E = nan;
    peakheight.E = nan;

    peakwidth.I = nan;
    peakheight.I = nan;

end

end