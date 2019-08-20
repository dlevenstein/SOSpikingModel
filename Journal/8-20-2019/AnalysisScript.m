addpath(genpath('~/Documents/Github/SOSpikingModel'))
addpath(genpath('~/Documents/GitHub/buzcode/'))

%%

mapIvals = linspace(150,300,20);
mapavals = 10.^(-4:0.5:-1);

Iindex = 1:length(mapIvals);
aindex = 1:length(mapavals);

S = cell(length(mapIvals),length(mapavals));

%%

filemap = zeros(length(mapIvals),length(mapavals));

for ii = 1:length(mapIvals)
for aa = 1:length(mapavals)
    
    filename = ['/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/Avals/AdaptationVCurrentSpikes_ii_' num2str(ii) '_aa_' num2str(aa) '.mat'];
    
    try
        load(filename)
        S{ii,aa} = spikes;
        filemap(ii,aa) = 1;
    catch
        disp(filename)    
    end
    
end
end

%%
DOWN_CV = zeros(length(mapIvals),length(mapavals));
DOWN_duration = zeros(length(mapIvals),length(mapavals));
DOWN_prob = zeros(length(mapIvals),length(mapavals));

UP_CV = zeros(length(mapIvals),length(mapavals));
UP_duration = zeros(length(mapIvals),length(mapavals));
UP_prob = zeros(length(mapIvals),length(mapavals));
UP_rate = zeros(length(mapIvals),length(mapavals));

rateMap = cell(length(mapIvals),length(mapavals));
meanRateMap = zeros(length(mapIvals),length(mapavals));

dip_stat = zeros(length(mapIvals),length(mapavals));
ISIdip_stat = zeros(length(mapIvals),length(mapavals));

meanAdaptation = zeros(length(mapIvals),length(mapavals));

for ii = 1:length(mapIvals)
parfor aa = 1:length(mapavals)
    
    spikes = S{ii,aa};
    if ~isnan(spikes)
        
    figindex = ['_ii_' num2str(ii) '_aa_' num2str(aa)];
        
    states = StateDetector(spikes,3e4,2500,mapavals(aa))
    
    DOWN_CV(ii,aa) = states.DOWN_CV_duration;
    DOWN_duration(ii,aa) = states.DOWN_mean_duration;
    DOWN_prob(ii,aa) = states.DOWN_prob;
    
    UP_CV(ii,aa) = states.UP_CV_duration;
    UP_duration(ii,aa) = states.UP_mean_duration;
    UP_prob(ii,aa) = states.UP_prob;
    UP_rate(ii,aa) = states.UP_mean_rate;
   
    meanRateMap(ii,aa) = states.mean_rate;
        
    meanAdaptation(ii,aa) = states.meanAdaptation;
    
    end
    
end
end

%%

EcellIDX = 1:2000;
IcellIDX = 2001:2500;

poprate.dt = 5;   poprate.binsize = 5;
t_rate = poprate.dt:poprate.dt:1e4;

%%
I_indices = zeros(1,5);
b_indices = zeros(1,5);

ii = find(Iindex == 27);
aa = find(aindex == 20);

I_indices(1) = ii;
b_indices(1) = aa;

ii = find(Iindex == 23);
aa = find(aindex == 8);

I_indices(2) = ii;
b_indices(2) = aa;

ii = find(Iindex == 18);
aa = find(aindex == 15);

I_indices(3) = ii;
b_indices(3) = aa;

ii = find(Iindex == 17);
aa = find(aindex == 2);

I_indices(4) = ii;
b_indices(4) = aa;

ii = find(Iindex == 28);
aa = find(aindex == 6);

I_indices(5) = ii;
b_indices(5) = aa;

ii = find(Iindex == 17);
aa = find(aindex == 29);

I_indices(6) = ii;
b_indices(6) = aa;

ii = find(Iindex == 33);
aa = find(aindex == 30);

I_indices(7) = ii;
b_indices(7) = aa;

ii = find(Iindex == 25);
aa = find(aindex == 30);

I_indices(8) = ii;
b_indices(8) = aa;

%%
I_indices = zeros(1,5);
b_indices = zeros(1,5);

ii = find(Iindex == 4);
aa = find(aindex == 4);

I_indices(1) = ii;
b_indices(1) = aa;

ii = find(Iindex == 8);
aa = find(aindex == 4);

I_indices(2) = ii;
b_indices(2) = aa;

ii = find(Iindex == 8);
aa = find(aindex == 8);

I_indices(3) = ii;
b_indices(3) = aa;

ii = find(Iindex == 10);
aa = find(aindex == 7);

I_indices(4) = ii;
b_indices(4) = aa;

ii = find(Iindex == 18);
aa = find(aindex == 9);

I_indices(5) = ii;
b_indices(5) = aa;

ii = find(Iindex == 6);
aa = find(aindex == 12);

I_indices(6) = ii;
b_indices(6) = aa;

ii = find(Iindex == 10);
aa = find(aindex == 13);

I_indices(7) = ii;
b_indices(7) = aa;

ii = find(Iindex == 19);
aa = find(aindex == 13);

I_indices(8) = ii;
b_indices(8) = aa;

%%
figure
subplot(2,2,1)
imagesc(mapIvals,mapavals,DOWN_CV');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'CV(DOWN)','FontSize',12) 
%clim([0 2])

subplot(2,2,2)
imagesc(mapIvals,mapavals,dip_stat');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'Dip','FontSize',12) 

subplot(2,2,3)
imagesc(mapIvals,mapavals,UP_CV');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'CV(UP)','FontSize',12) 
clim([0 2])

subplot(2,2,4)
imagesc(mapIvals,mapavals,meanRateMap');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'\mu(Rate)','FontSize',12) 
set(gca,'colorscale','log')

%NiceSave('Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_LognormalRates/figures',[])
%NiceSave('Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/figures',[])

%%
figure
subplot(2,2,1)
imagesc(mapIvals,mapavals,DOWN_duration');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
set(gca,'colorscale','log')
ylabel(h,'\mu(DOWN Duration) (ms)','FontSize',12)

subplot(2,2,2)
imagesc(mapIvals,mapavals,UP_rate');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
set(gca,'colorscale','log')
ylabel(h,'\mu(UP Rate)','FontSize',12) 

subplot(2,2,3)
imagesc(mapIvals,mapavals,UP_duration');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
set(gca,'colorscale','log')
ylabel(h,'\mu(UP Duration) (ms)','FontSize',12) 

subplot(2,2,4)
imagesc(mapIvals,mapavals,meanAdaptation');colorbar
% hold on
% plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
% hold on
% text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
% hold on
% text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
set(gca,'colorscale','log')
ylabel(h,'\mu(Adaptation)','FontSize',12) 

%NiceSave('Duration_Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_LognormalRates/figures',[])
%NiceSave('Duration_Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/figures',[])

%%
figure
subplot(2,2,1)
imagesc(Iindex,aindex,ISIdip_stat');colorbar
hold on
plot(Iindex(I_indices(1)),aindex(b_indices(1)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(2)),aindex(b_indices(2)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(3)),aindex(b_indices(3)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(4)),aindex(b_indices(4)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(5)),aindex(b_indices(5)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(6)),aindex(b_indices(6)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(7)),aindex(b_indices(7)),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(Iindex(I_indices(8)),aindex(b_indices(8)),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(Iindex(I_indices(1)),aindex(b_indices(1)),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(2)),aindex(b_indices(2)),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(3)),aindex(b_indices(3)),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(4)),aindex(b_indices(4)),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(5)),aindex(b_indices(5)),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(6)),aindex(b_indices(6)),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(7)),aindex(b_indices(7)),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(Iindex(I_indices(8)),aindex(b_indices(8)),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
%set(gca,'colorscale','log')
ylabel(h,'ISI Dip Stat','FontSize',12) 
yticklabels({'0.1','1','10','100','1e3','1e4'})
xticklabels({'150','200','250','300'})

%NiceSave('ISI_Dip_Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_LognormalRates/figures',[])
NiceSave('ISI_Dip_Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/figures',[])

%%
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/Adaptation/Spike-BasedCurrentAdaptation.mat');
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/Adaptation/Spike-BasedRate.mat');
%Erate = load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/DOWN/ExperimentRateM1/Erates.csv');
%Erate = load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/DOWN/LognormalEE_LognormalRates/Erates.csv');
Erate = load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/DOWN/LognormalEE_UniformRates/Erates.csv');
%Erate = Erate(3,:);

FI_Ivals = linspace(0,400,21);

Letters = ["A","B","C","D","E","F","G","H"];

%%

for ii = 1:8
    
spikes=S{I_indices(ii),b_indices(ii)};

%states = StateDetector(spikes,2e4,2500,mapavals(b_indices(ii)));
states = StateDetector(spikes,1e4,2500,mapavals(b_indices(ii)))

figindex = ['_ii_' num2str(I_indices(ii)) '_bb_' num2str(b_indices(ii))];

figure

pos = [0.07,0.6,0.5,0.3];
subplot('position',pos)

rate = states.rate;
DOWNstates = rate == 0;

tArea = [states.t_rate fliplr(states.t_rate)]./1e3;
Area = [zeros(1,length(states.t_rate)) fliplr(DOWNstates).*2500];

SimValues.spikes = S{I_indices(ii),b_indices(ii)};
SimValues.spikesbycell = spikeSorter(SimValues.spikes,1,2500);
SimValues.EcellIDX=1:2000;
SimValues.IcellIDX=2001:2500;

[Espikes,Ispikes] = RasterSorter(SimValues);

fill(tArea,Area,[0.7,1,0.7],'LineStyle','none')
hold on
plot(Espikes(:,1)./1e3,Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1)./1e3,Ispikes(:,2),'.r','markersize',1)
hold on

xlim([3 9]);ylim([0 2500]);ylabel(char(Letters(ii)))

set(gca,'xticklabel',[]);set(gca,'yticklabel',[])

pos = [0.07,0.38,0.5,0.2];
subplot('position',pos)

tArea = [states.t_rate fliplr(states.t_rate)]./1e3;
Area = [zeros(1,length(states.t_rate)) fliplr(DOWNstates).*ceil(max(states.adaptation))];

fill(tArea,Area,[0.7,1,0.7],'LineStyle','none')
hold on
plot(states.t_rate./1e3,states.adaptation,'k')
xlim([3 9]);ylim([floor(min(states.adaptation)) ceil(max(states.adaptation))])
set(gca,'xticklabel',[])

ylabel('Adaptation (nS)','FontSize',12)

pos = [0.07,0.26,0.5,0.1];
subplot('position',pos)

tArea = [states.t_rate fliplr(states.t_rate)]./1e3;
Area = [zeros(1,length(states.t_rate)) fliplr(DOWNstates).*5];

fill(tArea,Area,[0.7,1,0.7],'LineStyle','none')
hold on
plot(states.t_rate./1e3,rate,'k','linewidth',1)
hold on
plot([3 3.5],[3 3],'k','LineWidth',2) 
hold on
text(2.75, 3,'3 Hz','FontSize',12)

xlim([3 9]);ylim([0 5])

set(gca,'yticklabel',[])
xlabel('Time (sec)','FontSize',12)

pos = [0.67,0.75,0.3,0.2];
subplot('position',pos)

plot(mapIvals(I_indices(ii))-CurrentAdaptation(b_indices(ii),:),Rate(b_indices(ii),:),'.-k','MarkerSize',2,'LineWidth',2)
hold on
plot(FI_Ivals,log10(Erate),'.-b','MarkerSize',2,'LineWidth',2)
ylim([-0.5 1.5])
LogScale('y',10)

xlabel('Current (pA)','FontSize',12);ylabel('Rate (Hz)','FontSize',12)
legend('Adaptation','Excitatory Rate','Location','northoutside')

if ~isnan(states.DOWNmap)
pos = [0.67,0.45,0.3,0.2];
subplot('position',pos)

plot(states.bins,states.DOWNmap,'Color',[0.1,0.5,0.1],'LineWidth',2)
hold on
plot(states.bins,states.UPmap,'Color',[0.7,0.1,0.1],'LineWidth',2)
legend('DOWN Duration','UP Duration','Location','northoutside')
xlabel('Duration (ms)','FontSize',12);ylabel('Probability','FontSize',12)
LogScale('x',10)
end

% if ~isempty(states.UPrate)
% pos = [0.67,0.15,0.3,0.2];
% subplot('position',pos)
% 
% plot(states.UPrate(2,:),log10(states.UPrate(1,:)),'.k','MarkerSize',10)
% xlabel('Rate (Hz)','FontSize',12);ylabel('Duration (ms)','FontSize',12)
% 
% %ylim([1 3])
% 
% LogScale('y',10)
% %xlim([0 3])
% 
% end
%NiceSave(['ExampleRasters' figindex],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_LognormalRates/figures',[])
%NiceSave(['ExampleRasters' figindex],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/7-26-2019/LognormalEE_UniformRates/figures',[])
%close all

end
