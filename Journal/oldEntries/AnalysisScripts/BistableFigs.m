
w = 3;

dinfo = dir;

LastSpike = nan(21,100);

for ii = 3:length(dinfo)
    
    load(dinfo(ii).name);
    LastSpike(:,ii) = lastSpikeTimes;
    
end

B = 100;
bins = linspace(0,2000,B);
bistableMap = zeros(21,B);

for ii = 1:21
    
    bistableMap(ii,:) = hist(LastSpike(ii,:),bins);
    
end

%map{w} = bistableMap;

%%
figure
subplot(3,1,1)
    A = repmat(1,size(map{1}));
    A(map{1} == 0) = 0;
    imagesc(linspace(0,400,21),bins,map{1}')
    alpha(A');colorbar
    set(gca,'ydir','normal')
    xlabel('Current (pA)');ylabel('Last Spike Time (ms)');title(['Bistability Test Uniform: 1'])
    ylim([0 2000])
subplot(3,1,2)
    A = repmat(1,size(map{2}));
    A(map{2} == 0) = 0;
    imagesc(linspace(0,400,21),bins,map{2}')
    alpha(A');colorbar
    set(gca,'ydir','normal')
    xlabel('Current (pA)');ylabel('Last Spike Time (ms)');title(['Bistability Test Uniform: 3'])
    ylim([0 2000])
subplot(3,1,3)
    A = repmat(1,size(map{3}));
    A(map{3} == 0) = 0;
    imagesc(linspace(0,400,21),bins,map{3}')
    alpha(A');colorbar
    set(gca,'ydir','normal')
    xlabel('Current (pA)');ylabel('Last Spike Time (ms)');title(['Bistability Test Uniform: 10'])
    ylim([0 2000])

%%
figure
A = repmat(1,size(bistableMap'));
A(bistableMap' == 0) = 0;
imagesc(linspace(0,400,21),bins,bistableMap')
alpha(A);colorbar
set(gca,'ydir','normal')
xlabel('Current (pA)');ylabel('Last Spike Time (ms)');title(['Bistability Test Log Weigh Mu: ' num2str(w)])
ylim([0 2000])

% NiceSave(['Bistability_LogWeightSigma_' num2str(w)],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/Figures/9-27-2018',[])