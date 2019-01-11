function [rate,peakwidth,peakheight,lastspikes,S] = FIfigures(II,path)

dinfo = dir;

S = [];

lastspikes = nan(1,100);
sim = 1;

Times = [];

for dd = 1:length(dinfo)
    
    try
        
    if dinfo(dd).bytes < 1000000
        load(dinfo(dd).name)
    else
        continue
    end
        
    id = find(spikes(:,1) > 1e3+10);
    
%     figure
%     plot(spikes(:,1),spikes(:,2),'.k','markersize',1)
%     hold on
%     plot([spikes(end,1) spikes(end,1)],[0 2500],'r')
%     hold on
%     plot([1e3 1e3],[0 2500],'r')
%     NiceSave(['PeakWidth_II_' num2str(II)],[path 'Rasters'],[]);
%     close all
    
    if isempty(id) == false
    lastspikes(sim) = spikes(end,1) - (1e3+10);
    sim = sim + 1;
    end
    
    if isempty(S) == false
        S = [S;(spikes(id,1)-(1e3+10))+S(end,1),spikes(id,2)];
        Times = [Times S(end,1)];
    else
        S = [S;spikes(id,1)-(1e3+10),spikes(id,2)];
        Times = [Times S(end,1)];
        if length(S(:,1)) > 1e4
            break
        end
    end
    
    end
    
end

if isempty(S) == false
   
spikesbycell = spikeSorter(S,1,2500);

Espikesbycell = spikeSorter(S,1,2000);
Ispikesbycell = spikeSorter(S,2001,2500);

rate.E = 0;
rate.I = 0;

NumEspikes = 0;
NumIspikes = 0;

ISI_E = [];
ISI_I = [];

for ii = 1:2500

    if ii <= 2000
        if isempty(Espikesbycell{ii})
            ISI_E = [ISI_E; 2e3];
        else
            ISI_E = [ISI_E; diff(Espikesbycell{ii})];
            NumEspikes = NumEspikes + length(Espikesbycell{ii});
        end
    end
    if ii > 2000
        if isempty(Ispikesbycell{ii})
            ISI_I = [ISI_I; 2e3];
        else
            ISI_I = [ISI_I; diff(Ispikesbycell{ii})];
            NumIspikes = NumIspikes + length(Ispikesbycell{ii});
        end
    end
   
end

else

    rate.E = 0;
    rate.I = 0;
    
    peakwidth.E = 0;
    peakheight.E = 0;

    peakwidth.I = 0;
    peakheight.I = 0;
    
end

%%

if isempty(S)
    
    if isnan(rate.E)
        rate.E = 0;
    end
    if isnan(rate.I)
        rate.I = 0;
    end
    
    peakheight.E = 0;
    peakheight.I = 0;
        
    peakwidth.E = nan;
    peakwidth.I = nan;
    
elseif length(S(:,1)) >= 1e3

if length(max(S(find(S(:,2) < 2001),1))) > 0
rate.E = (NumEspikes./max(S(find(S(:,2) < 2001),1))).*(1000./2500);
else
rate.E = 0; 
end
if length(max(S(find(S(:,2) >= 2001),1))) > 0
rate.I = (NumIspikes./max(S(find(S(:,2) >= 2001),1))).*(1000./2500);
else
rate.I = 0;
end
    
Espikes = cat(1,spikesbycell{1:2000});
Ispikes = cat(1,spikesbycell{2001:2500});
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.001,'duration',0.1,'norm','rate');

% figure
% 
% subplot(3,1,1)
% plot(S(:,1),S(:,2),'.k','markersize',1)
% hold on
% for tt = 1:length(Times)
%     plot([Times(tt) Times(tt)],[0 2500],'r')
%     hold on
% end
% ylim([0 2500])
% xlabel('Time (ms)');ylabel('Neuron ID')
% 
% subplot(3,1,2)
% plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
% xlabel('Time Lag (ms)');ylabel('Rate (Hz)')
% 
% subplot(3,1,3)
% plot(t_ccg*1000,ccg(:,2,2)./500,'r')
% xlabel('Time Lag (ms)');ylabel('Rate (Hz)')
% 
% NiceSave(['Raster_II_' num2str(II)],path,[]);
% close all

[d,d,w] = findpeaks(ccg(:,1,1)./2000,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
if ismember(0,d)
    peakwidth.E = w(1);
elseif any(isnan(ccg(:,1,1)))
    peakwidth.E = nan;
elseif all(ccg(:,1,1) == 0)
    peakwidth.E = nan;
else
    [d,d,w] = findpeaks(-ccg(:,1,1)./2000,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
    peakwidth.E = w(1);
end

peakheight.E = max(ccg(:,1,1)./2000)-min(ccg(:,1,1)./2000);

[d,d,w] = findpeaks(ccg(:,2,2)./500,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
if ismember(0,d)
    peakwidth.I = w(1);
elseif any(isnan(ccg(:,2,2)))
    peakwidth.I = nan;
elseif all(ccg(:,2,2) == 0)
    peakwidth.I = nan;
else 
    [d,d,w] = findpeaks(-ccg(:,2,2)./500,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
    peakwidth.I = w(1);
end

peakheight.I = max(ccg(:,2,2)./500)-min(ccg(:,2,2)./500);

% figure
% 
% subplot(2,1,1)
% [d,d,w] = findpeaks(ccg(:,1,1)./2000,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
% if ismember(0,d)
%     findpeaks(ccg(:,1,1)./2000,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
% else
%     findpeaks(-ccg(:,1,1)./2000,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
% end
% subplot(2,1,2)
% [d,d,w] = findpeaks(ccg(:,2,2)./500,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
% if ismember(0,d)
%     findpeaks(ccg(:,2,2)./500,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
% else
%     findpeaks(-ccg(:,2,2)./500,t_ccg*1000,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
% end
% NiceSave(['PeakWidth_II_' num2str(II)],path,[]);
%close all

% close all

else
    
%     NiceSave([name num2str(II)],path,[]);
    
%     if isnan(rate.E)
%         rate.E = 0;
%     end
%     if isnan(rate.I)
%         rate.I = 0;
%     end
    
    peakheight.E = 0;
    peakheight.I = 0;
        
    peakwidth.E = nan;
    peakwidth.I = nan;

end

end