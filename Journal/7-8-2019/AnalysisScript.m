%% Journal Entry 

addpath(genpath('/scratch/jmg1030/FIcurve/SOSpikingModel'));
addpath(genpath('/scratch/jmg1030/FIcurve/buzcode'));

%%
path = '/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/LognormalEE_UniformRates/';
Irange = [150 300];
numI = 46;
barray = -2:0.2:4;

analyzedVals = AdaptationAnalysis(path,Irange,numI,barray);

save([path 'AnalyzedAdaptationValues'],'analyzedVals','-v7.3');

%%
for ii = 1:length(mapIvals)
for bb = 1:length(mapbvals)
    
    filename = ['/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'];
  
    try
        load(filename)
        spikes=spikes(spikes(:,1)>1e4,:);
        spikes(:,1) = spikes(:,1)-1e4;
        S{ii,bb} = spikes;
    catch
        disp(filename)    
    end
    
end
end

%%

load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/AnalyzedAdaptationValues.mat')

mapIvals = linspace(150,300,46);
mapbvals = 10.^(-2:0.2:4);

barray = -2:0.2:4;

Iindex = 1:length(mapIvals);
bindex = 1:length(mapbvals);

%%
I_indices = zeros(1,5);
b_indices = zeros(1,5);

ii = find(Iindex == 27);
bb = find(bindex == 20);

I_indices(1) = ii;
b_indices(1) = bb;

ii = find(Iindex == 23);
bb = find(bindex == 8);

I_indices(2) = ii;
b_indices(2) = bb;

ii = find(Iindex == 18);
bb = find(bindex == 15);

I_indices(3) = ii;
b_indices(3) = bb;

ii = find(Iindex == 17);
bb = find(bindex == 2);

I_indices(4) = ii;
b_indices(4) = bb;

ii = find(Iindex == 28);
bb = find(bindex == 6);

I_indices(5) = ii;
b_indices(5) = bb;

ii = find(Iindex == 17);
bb = find(bindex == 29);

I_indices(6) = ii;
b_indices(6) = bb;

ii = find(Iindex == 33);
bb = find(bindex == 30);

I_indices(7) = ii;
b_indices(7) = bb;

ii = find(Iindex == 25);
bb = find(bindex == 30);

I_indices(8) = ii;
b_indices(8) = bb;

%%
DOWN_CV = analyzedVals.DOWN_CV;
DOWN_duration = analyzedVals.DOWN_duration;

UP_CV = analyzedVals.UP_CV;
UP_duration = analyzedVals.UP_duration;
UP_rate = analyzedVals.UP_rate;

meanRateMap = analyzedVals.meanRateMap;

meanAdaptation = analyzedVals.meanAdaptation;

%%
figure
subplot(2,2,1)
imagesc(mapIvals,barray,DOWN_CV');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'CV(DOWN)','FontSize',12) 
%clim([0 2])
LogScale('y',10)

subplot(2,2,3)
imagesc(mapIvals,barray,UP_CV');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'CV(UP)','FontSize',12) 
clim([0 2])
LogScale('y',10)

subplot(2,2,2)
imagesc(mapIvals,barray,meanRateMap');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'\mu(Rate)','FontSize',12) 
set(gca,'colorscale','log')
LogScale('y',10)

NiceSave('Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/figures',[])

%%

figure

subplot(2,2,1)
imagesc(mapIvals,barray,DOWN_duration');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'\mu(Rate)','FontSize',12) 
set(gca,'colorscale','log')
LogScale('y',10)

subplot(2,2,2)
imagesc(mapIvals,barray,UP_rate');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'\mu(Rate)','FontSize',12) 
set(gca,'colorscale','log')
LogScale('y',10)

subplot(2,2,3)
imagesc(mapIvals,barray,UP_duration');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
set(gca,'colorscale','log')
ylabel(h,'\mu(UP Duration) (ms)','FontSize',12) 
LogScale('y',10)

subplot(2,2,4)
imagesc(mapIvals,barray,meanAdaptation');colorbar
hold on
plot(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'sk','MarkerSize',20,'LineWidth',2)
hold on
plot(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'sk','MarkerSize',20,'LineWidth',2)
hold on
text(mapIvals(Iindex(I_indices(1))),barray(bindex(b_indices(1))),'A','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(2))),barray(bindex(b_indices(2))),'B','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(3))),barray(bindex(b_indices(3))),'C','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(4))),barray(bindex(b_indices(4))),'D','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(5))),barray(bindex(b_indices(5))),'E','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(6))),barray(bindex(b_indices(6))),'F','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(7))),barray(bindex(b_indices(7))),'G','FontSize',10,'HorizontalAlignment','center')
hold on
text(mapIvals(Iindex(I_indices(8))),barray(bindex(b_indices(8))),'H','FontSize',10,'HorizontalAlignment','center')

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
set(gca,'colorscale','log')
ylabel(h,'\mu(Adaptation)','FontSize',12) 
LogScale('y',10)

NiceSave('Duration_Maps','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/figures',[])

%%
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/Adaptation/Spike-BasedCurrentAdaptation.mat');
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/Adaptation/Spike-BasedRate.mat');

Erate = load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/FI_300/DOWN/LognormalEE_UniformRates/Erates.csv');

FI_Ivals = linspace(0,400,21);

Letters = ["A","B","C","D","E","F","G","H"];

%%
for ii = 1:8
    
spikes=S{I_indices(ii),b_indices(ii)};

figindex = ['_ii_' num2str(I_indices(ii)) '_bb_' num2str(b_indices(ii))];
states = StateDetector(spikes,2e4,2500,mapbvals(bb));

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
text(2.3, 3,'3 Hz','FontSize',12)

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

if ~isempty(states.UPrate)
pos = [0.67,0.15,0.3,0.2];
subplot('position',pos)

plot(states.UPrate,log10(states.UPlengths),'.k','MarkerSize',10)
xlabel('Rate (Hz)','FontSize',12);ylabel('Duration (ms)','FontSize',12)

LogScale('y',10)

end

NiceSave(['ExampleRasters' figindex],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/figures',[])

end