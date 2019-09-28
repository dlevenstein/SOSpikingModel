bins = linspace(0,1,25);

MAXmap      = zeros(20,13);
MEANmap     = zeros(20,13);
VARmap      = zeros(20,13);
CVmap       = zeros(20,13);

ISItotal    = [];

for bb = 1:13
    for ii = 1:20
        
        spikes = S{ii,bb};
        ISI = diff(spikes(:,1));
        
        MAXmap(ii,bb) = max([ISI;0]);
        
        %ISI = ISI(ISI < 1e3);
        %ISI = ISI(ISI > 10);

        MEANmap(ii,bb) = nanmean(ISI);
        VARmap(ii,bb) = nanvar(ISI);
        CVmap(ii,bb) = nanstd(ISI)/nanmean(ISI);
        
        ISItotal = [ISItotal;ISI];
            
    end
end

MAXmap(MAXmap == 0) = nan;

%%
figure
subplot(2,2,1)
imagesc(MEANmap)
colorbar
%set(gca,'colorscale','log')
subplot(2,2,2)
imagesc(VARmap)
colorbar
%set(gca,'colorscale','log')
subplot(2,2,3)
imagesc(CVmap)
colorbar
%set(gca,'colorscale','log')
subplot(2,2,4)
imagesc(MAXmap)
colorbar
set(gca,'colorscale','log')

%%
bins = linspace(0,4,25);
map = hist(log10(MEANmap(:)),bins);
map = map./sum(map);

figure
plot(bins,map)

%%
bins = linspace(0,2,25);
map = hist(log10(CVmap(:)),bins);
map = map./sum(map);

figure
plot(bins,map)
hold on
plot(log10([nanmean(CVmap(:)),nanmean(CVmap(:))]),[0 max(map)],'k')

%%
bins = linspace(0,4,25);
map = hist(log10(ISItotal),bins);
map = map./sum(map);

figure
plot(bins,map)
LogScale('x',10)

%%

thresh = nanmean(nanmean(MEANmap));
