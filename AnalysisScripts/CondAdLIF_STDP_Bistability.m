endspikes = nan(21,100);

for ii = 10
for jj = 1:100
    
    try
        
    %load(['/Users/jonathangornet/Desktop/spikedata/Uniform_10/singleWeight_10_sim_' num2str(jj) '_ii_' num2str(ii) '_spikes.mat'])
    load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_1_sim_' num2str(jj) '_ii_' num2str(ii) '_spikes.mat'])
    
    endspikes(ii,jj) = spikes(end,1) - 1e3;
   
    catch 
        disp(['Missing logSigmaWeight_1_sim_' num2str(jj) '_ii_' num2str(ii) '_spikes.mat']) 
    end

end
end

%%

figure

ii = 71;
%ii = 71;

load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_001_sim_' num2str(ii) '_ii_10_spikes.mat'])
%load(['/Users/jonathangornet/Desktop/spikedata/Uniform_1/singleWeight_1_sim_' num2str(ii) '_ii_10_spikes.mat'])

subplot(3,1,1)
plot(spikes(:,1),spikes(:,2),'.k','markersize',1)
hold on
plot([1000 1000],[0 2500],'r')
xlim([0,3000]);ylim([0 2500])
xlabel('Time (ms)');ylabel('Neuron ID');
title('Lognormal Sigma: 0.01, Current 180 pA')
%title('Uniform w: 1, Current 180 pA')

ii = 60;
%ii = 97;

load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_01_sim_' num2str(ii) '_ii_10_spikes.mat'])
%load(['/Users/jonathangornet/Desktop/spikedata/Uniform_3/singleWeight_3_sim_' num2str(ii) '_ii_10_spikes.mat'])

subplot(3,1,2)
plot(spikes(:,1),spikes(:,2),'.k','markersize',1)
hold on
plot([1000 1000],[0 2500],'r')
xlim([0,3000]);ylim([0 2500])
xlabel('Time (ms)');ylabel('Neuron ID');
title('Lognormal Sigma: 0.1, Current 180 pA')
%title('Uniform w: 3, Current 180 pA')

ii = 77;
%ii = 98;

load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_1_sim_' num2str(ii) '_ii_10_spikes.mat'])
%load(['/Users/jonathangornet/Desktop/spikedata/Uniform_10/singleWeight_10_sim_' num2str(ii) '_ii_10_spikes.mat'])

subplot(3,1,3)
plot(spikes(:,1),spikes(:,2),'.k','markersize',1)
hold on
plot([1000 1000],[0 2500],'r')
xlim([0,3000]);ylim([0 2500])
xlabel('Time (ms)');ylabel('Neuron ID');
title('Lognormal Sigma: 1, Current 180 pA')
%title('Uniform w: 10, Current 180 pA')

%%

ii = 71;
%ii = 71;

load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_001_sim_' num2str(ii) '_ii_10_spikes.mat'])
%load(['/Users/jonathangornet/Desktop/spikedata/Uniform_1/singleWeight_1_sim_' num2str(ii) '_ii_10_spikes.mat'])

%%

ii = 60;
%ii = 97;

load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_01_sim_' num2str(ii) '_ii_10_spikes.mat'])
%load(['/Users/jonathangornet/Desktop/spikedata/Uniform_3/singleWeight_3_sim_' num2str(ii) '_ii_10_spikes.mat'])

%%

ii = 77;
%ii = 98;

load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_1_sim_' num2str(ii) '_ii_10_spikes.mat'])
%load(['/Users/jonathangornet/Desktop/spikedata/Uniform_10/singleWeight_10_sim_' num2str(ii) '_ii_10_spikes.mat'])

%%
% ii = 71;
ii = 71;

% load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_001_sim_' num2str(ii) '_ii_10_spikes.mat'])
load(['/Users/jonathangornet/Desktop/spikedata/Uniform_1/singleWeight_1_sim_' num2str(ii) '_ii_10_spikes.mat'])

%%

% ii = 60;
ii = 97;

% load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_01_sim_' num2str(ii) '_ii_10_spikes.mat'])
load(['/Users/jonathangornet/Desktop/spikedata/Uniform_3/singleWeight_3_sim_' num2str(ii) '_ii_10_spikes.mat'])

%%

% ii = 77;
ii = 98;

% load(['/Users/jonathangornet/Desktop/SpikeDataLogSigma/logSigmaWeight_1_sim_' num2str(ii) '_ii_10_spikes.mat'])
load(['/Users/jonathangornet/Desktop/spikedata/Uniform_10/singleWeight_10_sim_' num2str(ii) '_ii_10_spikes.mat'])

%%

ss = '10';

%titlename = 'LogNormal, Sigma 1,';
titlename = 'Uniform w 10,';

figure

id = find(spikes(:,1) < 1e3);

postspikes = spikes(id,:);
postspikes(:,1) = postspikes(:,1);
spikesbycell = spikeSorter(postspikes);

%ISI distirbutions
ISIdist.bins = linspace(0,3.5,25);
ISIs = cellfun(@diff,spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{1:2000})),ISIdist.bins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{2001:2500})),ISIdist.bins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
ISIdist.all = cat(1,ISIdist.all{:});
ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));

cellrates = cellfun(@length,spikesbycell)./((max(postspikes(:,1))./1000));

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,1:2000,'stable');
sortrate.Ionly = intersect(sortrate.all,2001:2500,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);

A = repmat(1,size(log10(ISIdist.all(sortrate.ratetype,:))));
A(log10(ISIdist.all(sortrate.ratetype,:)) == -inf) = 0;

subplot(2,2,1)
imagesc(ISIdist.bins,[0 max(2500)],log10(ISIdist.all(sortrate.ratetype,:)))
hold on
plot(ISIdist.bins([1 end]),min(2001).*[1 1],'k')
alpha(A);
ylabel('Neuron (sort by Rate, Type)')
h = colorbar;
ylabel(h,'log P(ISI)')
%colormap(isicolormap)
%caxis([0 1])
xlabel('ISI (ms)');title([titlename ' 400 pA'])

id = find(spikes(:,1) > 1e3);

postspikes = spikes(id,:);
postspikes(:,1) = postspikes(:,1) - 1e3;
spikesbycell = spikeSorter(postspikes);

%ISI distirbutions
ISIdist.bins = linspace(0,3.5,25);
ISIs = cellfun(@diff,spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{1:2000})),ISIdist.bins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{2001:length(ISIs)})),ISIdist.bins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
ISIdist.all = cat(1,ISIdist.all{:});
ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));

cellrates = cellfun(@length,spikesbycell)./((max(postspikes(:,1))./1000));

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,1:2000,'stable');
sortrate.Ionly = intersect(sortrate.all,2001:2500,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);

A = repmat(1,size(log10(ISIdist.all(sortrate.ratetype,:))));
A(log10(ISIdist.all(sortrate.ratetype,:)) == -inf) = 0;

subplot(2,2,2)
imagesc(ISIdist.bins,[0 max(2500)],log10(ISIdist.all(sortrate.ratetype,:)))
hold on
plot(ISIdist.bins([1 end]),min(2001).*[1 1],'k')
alpha(A);
ylabel('Neuron (sort by Rate, Type)')
h = colorbar;
ylabel(h,'log P(ISI)')
%colormap(isicolormap)
%caxis([0 1])
xlabel('ISI (ms)');title([titlename ' 180 pA'])

id = find(spikes(:,1) < 1e3);

postspikes = spikes(id,:);
postspikes(:,1) = postspikes(:,1);
spikesbycell = spikeSorter(postspikes);

Espikes = cat(1,spikesbycell{1:2000});
Ispikes = cat(1,spikesbycell{2001:2500});
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

subplot(2,2,3)
    plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
    hold on
    plot(t_ccg*1000,ccg(:,2,2)./500,'r')
    xlabel('t lag (ms)');ylabel('Rate');%title('Cross-Correlogram 400 pA')
    ylim([0 15])
    
id = find(spikes(:,1) > 1e3);

postspikes = spikes(id,:);
postspikes(:,1) = postspikes(:,1) - 1e3;
spikesbycell = spikeSorter(postspikes);

Espikes = cat(1,spikesbycell{1:2000});
Ispikes = cat(1,spikesbycell{2001:2499});
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

subplot(2,2,4)
    plot(t_ccg*1000,ccg(:,1,1)./2000,'b')
    hold on
    plot(t_ccg*1000,ccg(:,2,2)./500,'r')
    xlabel('t lag');ylabel('Rate');%title('Cross-Correlogram 180 pA')
    ylim([0 15])

%NiceSave(['LogNormal_Sigma' ss 'bistability_Rate'],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/Figures/9-27-2018',[])
NiceSave(['Uniform' ss 'bistability_Rate'],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/Figures/9-27-2018',[])