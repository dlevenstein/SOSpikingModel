addpath(genpath('~/Documents/Github/SOSpikingModel'))
addpath(genpath('~/Documents/GitHub/buzcode/'))

%%

Ivals = linspace(150,300,20);
bvals = 10.^(-2:0.5:4);

bvalsIndex = -2:0.5:4;

Iindex = 1:length(Ivals);
bindex = 1:length(bvals);

%%
S = cell(length(Ivals),length(bvals));

%%

filemap = zeros(length(Ivals),length(bvals));

for ii = 1:length(Ivals)
for bb = 1:length(bvals)
    
    filename = ['/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/Bvals/w0/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'];
    
    try
        load(filename)
        spikes=spikes(spikes(:,1)>1e4,:);
        spikes(:,1) = spikes(:,1)-1e4;
        S{ii,bb} = spikes;
        filemap(ii,bb) = 1;
    catch
        disp(filename)    
    end
    
end
end

%%
DOWN_CV = zeros(length(Ivals),length(bvals));
DOWN_duration = zeros(length(Ivals),length(bvals));
DOWN_prob = zeros(length(Ivals),length(bvals));

UP_CV = zeros(length(Ivals),length(bvals));
UP_duration = zeros(length(Ivals),length(bvals));
UP_prob = zeros(length(Ivals),length(bvals));
UP_rate = zeros(length(Ivals),length(bvals));

rateMap = cell(length(Ivals),length(bvals));
meanRateMap = zeros(length(Ivals),length(bvals));

dip_stat = zeros(length(Ivals),length(bvals));
ISIdip_stat = zeros(length(Ivals),length(bvals));

meanAdaptation = zeros(length(Ivals),length(bvals));

for ii = 1:length(Ivals)
parfor bb = 1:length(bvals)
    
    spikes = S{ii,bb};
    if ~isnan(spikes)
        
    figindex = ['_ii_' num2str(ii) '_bb_' num2str(bb)];
        
    states = StateDetector(spikes,1e4,2500,bvals(bb))
    
    DOWN_CV(ii,bb) = states.DOWN_CV_duration;
    DOWN_duration(ii,bb) = states.DOWN_mean_duration;
    DOWN_prob(ii,bb) = states.DOWN_prob;
    
    UP_CV(ii,bb) = states.UP_CV_duration;
    UP_duration(ii,bb) = states.UP_mean_duration;
    UP_prob(ii,bb) = states.UP_prob;
    UP_rate(ii,bb) = states.UP_mean_rate;
   
%     rateMap{ii,bb} = states.rate;
    meanRateMap(ii,bb) = states.mean_rate;
         
%     dip_stat(ii,bb) = states.dip;
%     ISIdip_stat(ii,bb) = states.ISIdip;
    
    meanAdaptation(ii,bb) = states.meanAdaptation;
    
    end
    
end
end

%%

SimValues.spikes = S{12,13};
SimValues.spikesbycell = spikeSorter(SimValues.spikes,1,2500);
SimValues.EcellIDX=1:2000;
SimValues.IcellIDX=2001:2500;

states = StateDetector(SimValues.spikes,2e4,2500,bvals(bb));

tArea = [SimValues.spikes(:,1)' fliplr(SimValues.spikes(:,1)')]./1e3;
Area = [zeros(1,length(SimValues.spikes(:,1))) fliplr(states.DOWNstates').*2500];

[Espikes,Ispikes] = RasterSorter(SimValues);

% fill(tArea,Area,[0.7,1,0.7],'LineStyle','none')
% hold on

%%
figure

pos = [0.1,0.4,0.8,0.5];
subplot('position',pos)
plot(Espikes(:,1)./1e3,Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1)./1e3,Ispikes(:,2),'.r','markersize',1)
set(gca,'xtick',[]);set(gca,'ytick',[])

pos = [0.1,0.1,0.8,0.25];
subplot('position',pos)
plot(states.t_rate,states.adaptation,'k')
xlabel('Time (sec)','FontSize',16);ylabel('Adaptation (nS)','FontSize',16)

NiceSave('ExampleAdaptationFigure_LognormalEE_UniformRates','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/SfNPoster',[])
%%

skip = false;
for aa = 1:length(Area)
    
    if Area(aa) > 0
        if ~skip
            Area(aa+1) = 2500;
            skip = true;
        else
            skip = false;
        end
    end
end

%%

I_indices = [6,10,7,12,12];
b_indices = [3,5,8,10,13];

Letters = ["A","B","C","D","E","F","G","H"];
        
%%

figure
subplot(2,2,1)
imagesc(Ivals,bvalsIndex,DOWN_duration');colorbar
hold on

for ii = 1:length(I_indices)
    plot(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),'sk','MarkerSize',20,'LineWidth',2)
    hold on
    text(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),char(Letters(ii)),'FontSize',10,'HorizontalAlignment','center')
    hold on
end

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'\mu(DOWN Duration)','FontSize',12) 
set(gca,'colorscale','log')

subplot(2,2,2)
imagesc(Ivals,bvalsIndex,UP_duration');colorbar
hold on

for ii = 1:length(I_indices)
    plot(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),'sk','MarkerSize',20,'LineWidth',2)
    hold on
    text(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),char(Letters(ii)),'FontSize',10,'HorizontalAlignment','center')
    hold on
end

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'\mu(UP Duration)','FontSize',12) 
set(gca,'colorscale','log')

subplot(2,2,3)
imagesc(Ivals,bvalsIndex,DOWN_CV');colorbar
hold on

for ii = 1:length(I_indices)
    plot(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),'sk','MarkerSize',20,'LineWidth',2)
    hold on
    text(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),char(Letters(ii)),'FontSize',10,'HorizontalAlignment','center')
    hold on
end

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'CV(DOWN Duration)','FontSize',12) 

subplot(2,2,4)
imagesc(Ivals,bvalsIndex,UP_CV');colorbar
hold on

for ii = 1:length(I_indices)
    plot(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),'sk','MarkerSize',20,'LineWidth',2)
    hold on
    text(Ivals(I_indices(ii)),bvalsIndex(b_indices(ii)),char(Letters(ii)),'FontSize',10,'HorizontalAlignment','center')
    hold on
end

xlabel('Current (pA)','FontSize',16);ylabel('Adaptation b','FontSize',16)
h = colorbar;
ylabel(h,'CV(UP Duration)','FontSize',12) 
set(gca,'colorscale','log')

NiceSave('AdaptationMap_LognormalEE_UniformRates','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/SfNPoster',[])

%%

for ii = 1:length(I_indices)
    
    SimValues.spikes = S{I_indices(ii),b_indices(ii)};
    SimValues.spikesbycell = spikeSorter(SimValues.spikes,1,2500);
    SimValues.EcellIDX=1:2000;
    SimValues.IcellIDX=2001:2500;

    states = StateDetector(SimValues.spikes,2e4,2500,bvals(bb));

    tArea = [SimValues.spikes(:,1)' fliplr(SimValues.spikes(:,1)')]./1e3;
    Area = [zeros(1,length(SimValues.spikes(:,1))) fliplr(states.DOWNstates').*2500];
  
    aa = find(Area > 1);
    Area(aa) = 2500;
    Area(aa-1) = 2500;
    
    
    [Espikes,Ispikes] = RasterSorter(SimValues);
    
    figure

    pos = [0.1,0.4,0.4,0.3];
    subplot('position',pos)
   
    fill(tArea,Area,[0.7,1,0.7],'LineStyle','none')
    hold on
    plot(Espikes(:,1)./1e3,Espikes(:,2),'.b','markersize',1)
    hold on
    plot(Ispikes(:,1)./1e3,Ispikes(:,2),'.r','markersize',1)
    set(gca,'xtick',[]);set(gca,'ytick',[])
    ylabel(char(Letters(ii)),'FontSize',16)
    xlim([10 20])
    
    pos = [0.1,0.1,0.4,0.25];
    subplot('position',pos)
    plot(states.t_rate./1e3,states.adaptation,'k')
    xlabel('Time (sec)','FontSize',16);ylabel('Adaptation (nS)','FontSize',16)
    xlim([10 20])
    
    pos = [0.60,0.45,0.3,0.25];
    subplot('position',pos)
    plot(states.bins,states.DOWNmap,'color',[0.7,1,0.7],'LineWidth',2)
    hold on
    plot(states.bins,states.UPmap,'color',[1,0.7,0.7],'LineWidth',2)
    LogScale('x',10)
    xlabel('Duration (ms)','FontSize',16);ylabel('Probability','FontSize',16)
    
    pos = [0.60,0.1,0.3,0.25];
    subplot('position',pos)
    plot(states.UPlengths,log10(states.UPrate),'.k','MarkerSize',1)
    xlabel('UP Duration (ms)','FontSize',16);ylabel('UP Rate (Hz)','FontSize',16)
    xlim([0 inf]);ylim([0 3])
    LogScale('y',10)
    %NiceSave(['ExampleRaster_LognormalEE_UniformRates_ii_' num2str(I_indices(ii)) '_bb_' num2str(b_indices(ii))],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/SfNPoster',[])
    
    %close all
    
end

