addpath(genpath('~/Documents/Github/SOSpikingModel'))
addpath(genpath('~/Documents/GitHub/buzcode/'))

%%

Ivals = linspace(150,300,20);
bvals = 10.^(-2:0.5:4);

Iindex = 1:length(Ivals);
bindex = 1:length(bvals);

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

ii = 11;
bb = 13;

spikes = S{ii,bb};

states = StateDetector(spikes,1e4,2500,bvals(bb));

rate = states.rate;
DOWNstates = states.DOWNstates;

tArea = [spikes(:,1)' fliplr(spikes(:,1)')]./1e3;
Area = [zeros(1,length(spikes(:,1))) fliplr(DOWNstates').*2500];

SimValues.spikes = S{ii,bb};
SimValues.spikesbycell = spikeSorter(SimValues.spikes,1,2500);
SimValues.EcellIDX=1:2000;
SimValues.IcellIDX=2001:2500;

[Espikes,Ispikes] = RasterSorter(SimValues);

figure

fill(tArea,Area,[0.7,1,0.7],'LineStyle','none')
hold on
plot(Espikes(:,1)./1e3,Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1)./1e3,Ispikes(:,2),'.r','markersize',1)
xlim([27 30])

%%

EcellIDX = 1:2000;
IcellIDX = 2001:2500;

poprate.dt = 5;   poprate.binsize = 5;
t_rate = poprate.dt:poprate.dt:1e4;

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

%states = StateDetector(spikes,2e4,2500,bvals(b_indices(ii)));
states = StateDetector(spikes,1e4,2500,bvals(b_indices(ii)))

figindex = ['_ii_' num2str(I_indices(ii)) '_bb_' num2str(b_indices(ii))];

figure

pos = [0.07,0.6,0.5,0.3];
subplot('position',pos)

rate = states.rate;
DOWNstates = states.rate;

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

plot(Ivals(I_indices(ii))-CurrentAdaptation(b_indices(ii),:),Rate(b_indices(ii),:),'.-k','MarkerSize',2,'LineWidth',2)
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
NiceSave(['ExampleRasters' figindex],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/7-26-2019/LognormalEE_UniformRates/figures',[])
%close all

end

%%

Ivals = linspace(150,300,20);
bvals = 10.^(-2:0.5:4);

Iindex = 1:length(Ivals);
bindex = 1:length(bvals);

Sw0     = cell(length(Ivals),length(bvals));
Sw0null = cell(length(Ivals),length(bvals));

%%

filemap = zeros(length(Ivals),length(bvals));

for ii = 1:length(Ivals)
for bb = 1:length(bvals)
    
    filename = ['/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/Bvals/w0/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'];
    
    try
        load(filename)
        %spikes=spikes(spikes(:,1)>1e4,:);
        %spikes(:,1) = spikes(:,1)-1e4;
        Sw0{ii,bb} = spikes;
        filemap(ii,bb) = 1;
    catch
        disp(filename)    
    end
    
end
end

%%

filemap = zeros(length(Ivals),length(bvals));

for ii = 1:length(Ivals)
for bb = 1:length(bvals)
    
    filename = ['/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/Adaptation/LognormalEE_UniformRates/Bvals/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'];
    
    try
        load(filename)
        %spikes=spikes(spikes(:,1)>1e4,:);
        %spikes(:,1) = spikes(:,1)-1e4;
        Sw0null{ii,bb} = spikes;
        filemap(ii,bb) = 1;
    catch
        disp(filename)    
    end
    
end
end