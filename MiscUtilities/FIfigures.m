function [rate,peakwidth,peakheight,lastspikes,S] = FIfigures(II,name,path)

dinfo = dir;

S = [];

lastspikes = nan(1,100);
sim = 1;

for dd = 1:length(dinfo)
    
    try

    load(dinfo(dd).name)
        
    id = find(spikes(:,1) > 1e3);
    
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

Espikesbycell = spikeSorter(S,1,2000);
Ispikesbycell = spikeSorter(S,2001,2500);

ISI_E = [];
ISI_I = [];

for ii = 1:2500

    if ii <= 2000
        if isempty(Espikesbycell{ii})
            ISI_E = [ISI_E; 2e3];
        else
            ISI_E = [ISI_E; diff(Espikesbycell{ii})];
        end
    end
    if ii > 2000
        if isempty(Ispikesbycell{ii})
            ISI_I = [ISI_I; 2e3];
        else
            ISI_I = [ISI_I; diff(Ispikesbycell{ii})];
        end
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
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0005,'duration',0.05,'norm','rate');

figure

subplot(3,1,1)
plot(S(:,1),S(:,2),'.k','markersize',1)
ylim([0 2500])
xlabel('Time (ms)');ylabel('Neuron ID')

subplot(3,1,2)
plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
xlabel('Time Lag (ms)');ylabel('Rate (Hz)')

subplot(3,1,3)
plot(t_ccg*1000,ccg(:,2,2)./500,'r')
xlabel('Time Lag (ms)');ylabel('Rate (Hz)')

NiceSave(['Raster_II_' num2str(II)],path,[]);
close all

figure

% [d,d,w] = findpeaks([movmax(ccg(1:500,1,1)./2000,25);movmax(ccg(501:end,1,1)./2000,25)],t_ccg*1000,'Annotate','extents','WidthReference','halfprom');
% peakwidth.E = max(w);

t = t_ccg(51:end)*1000;
f = ccg(51:end,1,1)./2000;

vals = findDecay(t,f);

peakwidth.E = 1./vals.a;

subplot(2,1,1)
plot(t,f,'b')
hold on
plot(t,vals.S,'k')
xlabel('Time Lag (ms)');ylabel('Rate (Hz)')

peakheight.E = max(ccg(:,1,1)./2000);

% [d,d,w] = findpeaks([movmax(ccg(1:500,2,2)./500,25);movmax(ccg(501:end,2,2)./500,25)],t_ccg*1000,'Annotate','extents','WidthReference','halfprom');
% peakwidth.I = max(w);

t = t_ccg(51:end)*1000;
f = ccg(51:end,2,2)./500;

vals = findDecay(t,f);

peakwidth.I = 1./vals.a;

subplot(2,1,2)
plot(t,f,'r')
hold on
plot(t,vals.S,'k')
xlabel('Time Lag (ms)');ylabel('Rate (Hz)')

NiceSave(['Fitting_II_' num2str(II)],path,[])

peakheight.I = max(ccg(:,2,2)./500);

close all

else
    
%     NiceSave([name num2str(II)],path,[]);
    
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

end

end