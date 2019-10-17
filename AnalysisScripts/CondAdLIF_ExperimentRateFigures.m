pathtodata = '';
pathtofigure = '';

weightnames = ["ExperimentRate_s_001_testing.mat","ExperimentRate_s_01_testing.mat","ExperimentRate_s_1_testing.mat","ExperimentRate_s_10_testing.mat"];

%% load data
for ww = 1:length(weightnames)
    
    SimValuesArray(ww) = load([pathtodata char(weightnames(ww))]);

end

for ww = 1:length(weightnames)
    
    SimValuesList(ww) = SimValuesArray(ww).SimValues;
    
end

SimValuesArray = SimValuesList;

%% paths and legend names

indices = [2,3,4];
legendnames = ["0.01 nS","0.1 nS","1 nS","10 nS"];
networknames = ["0.01","0.1","1","10"];

network = 'ExperimentRate';

%% Make all figures for data set
makeFigures(SimValuesArray,indices,network,pathtofigure,networknames,legendnames)

%% Specifically create raster figure
makeRaster(SimValuesArray,indices,[network '_Raster'],path,true);

%% find target rates of network
weightnames = ["ExperimentRate_s_001.mat","ExperimentRate_s_01.mat","ExperimentRate_s_1.mat","ExperimentRate_s_10.mat"];

targetRates = zeros(length(weightnames),2000);

for ww = 1:length(weightnames)
    
    load(char(weightnames(ww)));
    targetRates(ww,:) = TRs;
    
end

%% find cell rates of data set

weightnames = ["ExperimentRate_s_001_spikes.mat","ExperimentRate_s_01_spikes.mat","ExperimentRate_s_1_spikes.mat","ExperimentRate_s_10_spikes.mat"];

SimRates = zeros(length(weightnames),2000);

for ww = 1:length(weightnames)

    load(char(weightnames(ww)));
    spikesbycell = spikeSorter(spikes,1,2500);
    R = cellfun(@length,spikesbycell).*(1e3/5e4);
    SimRates(ww,:) = R(1:2000);
    
    SimValuesArray(ww).spikesbycell = spikesbycell;
    SimValuesArray(ww).spikes = spikes;
    SimValuesArray(ww).t = 0:0.05:5e4;
    
    SimValuesArray(ww).EcellIDX = 1:2000;
    SimValuesArray(ww).IcellIDX = 2001:2500;
    
end

%% Create correlation figure of target rate with simulation rate

figure

pos = [0.1,0.64,0.25,0.25];
subplot('position',pos);

plot(log10(targetRates(2,:)),log10(SimRates(2,:)),'.k')
hold on
plot([-10 10],[-10 10],'k')
xlim([-1.5 2]);ylim([-1.5 2]);
LogScale('xy',10)

set(gca,'XTickLabel',[])

ylabel('Cell Rate (Hz)','FontSize',15)

pos = [0.1,0.37,0.25,0.25];
subplot('position',pos);

plot(log10(targetRates(3,:)),log10(SimRates(3,:)),'.k')
hold on
plot([-10 10],[-10 10],'k')
xlim([-1.5 2]);ylim([-1.5 2]);
LogScale('xy',10)

set(gca,'XTickLabel',[])

ylabel('Cell Rate (Hz)','FontSize',15)

pos = [0.1,0.1,0.25,0.25];
subplot('position',pos);

plot(log10(targetRates(4,:)),log10(SimRates(4,:)),'.k')
hold on
plot([-10 10],[-10 10],'k')
xlim([-1.5 2]);ylim([-1.5 2]);
xlabel('Target Rate (Hz)','FontSize',15);ylabel('Cell Rate (Hz)','FontSize',15)

LogScale('xy',10)

NiceSave('CellRates','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/TestNetworks/ExperimentRate/figures',[])

%% Create distribution of target rates and cell rates
B = 25;
bins = linspace(-1,2,B);

mapTarget = zeros(B,4);
mapSimulation = zeros(B,4);

for rr = 1:4
    
    mapTarget(:,rr) = hist(log10(targetRates(rr,:)),bins);
    mapSimulation(:,rr) = hist(log10(SimRates(rr,:)),bins);
    
end
    
%% create distribution of target rate and simulation rate 

figure
pos = [0.1,0.55,0.4,0.4];
subplot('position',pos)

plot(bins,mapTarget(:,1)./sum(mapTarget(:,1)),'--k','LineWidth',2)
hold on
plot(bins,mapSimulation(:,1)./sum(mapSimulation(:,1)),'k','LineWidth',2)
hold on
text(0.8,0.1,'s: 0.01 nS^2','FontSize',16)

AX = get(gca,'XAxis');
set(AX,'FontSize', 12)
AX = get(gca,'YAxis');
set(AX,'FontSize', 12)

legend('Target','Simulation')

set(gca,'XTickLabel',[]);ylim([0 0.2])

ylabel('Probability','FontSize',20)

pos = [0.55,0.55,0.4,0.4];
subplot('position',pos)

plot(bins,mapTarget(:,2)./sum(mapTarget(:,2)),'--k','LineWidth',2)
hold on
plot(bins,mapSimulation(:,2)./sum(mapSimulation(:,2)),'k','LineWidth',2)
hold on
text(1,0.1,'s: 0.1 nS^2','FontSize',16)

AX = get(gca,'XAxis');
set(AX,'FontSize', 12)
AX = get(gca,'YAxis');
set(AX,'FontSize', 12)

legend('Target','Simulation')

set(gca,'XTickLabel',[]);set(gca,'YTickLabel',[]);ylim([0 0.2])

pos = [0.1,0.1,0.4,0.4];
subplot('position',pos)

plot(bins,mapTarget(:,3)./sum(mapTarget(:,3)),'--k','LineWidth',2)
hold on
plot(bins,mapSimulation(:,3)./sum(mapSimulation(:,3)),'k','LineWidth',2)
hold on
text(1,0.1,'s: 1 nS^2','FontSize',16)

AX = get(gca,'XAxis');
set(AX,'FontSize', 12)
AX = get(gca,'YAxis');
set(AX,'FontSize', 12)

LogScale('x',10)
ylim([0 0.2])

legend('Target','Simulation')

ylabel('Probability','FontSize',20)
xlabel('Rate (Hz)','FontSize',20)

pos = [0.55,0.1,0.4,0.4];
subplot('position',pos)

plot(bins,mapTarget(:,4)./sum(mapTarget(:,4)),'--k','LineWidth',2)
hold on
plot(bins,mapSimulation(:,4)./sum(mapSimulation(:,4)),'k','LineWidth',2)
hold on
text(1,0.1,'s: 10 nS^2','FontSize',16)

AX = get(gca,'XAxis');
set(AX,'FontSize', 12)
AX = get(gca,'YAxis');
set(AX,'FontSize', 12)

LogScale('x',10)
set(gca,'YTickLabel',[]);ylim([0 0.2])

legend('Target','Simulation')

xlabel('Rate (Hz)','FontSize',20)

