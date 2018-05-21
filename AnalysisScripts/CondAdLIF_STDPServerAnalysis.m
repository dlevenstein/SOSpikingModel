%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel/';
%repopath = '/home/jmg1030/SOSpikingModel';

buzpath = '/Users/jonathangornet/Documents/GitHub/buzcode/';
datafolder = 'Data/Balance/05-5-2018/';

figfolder = '~/Desktop/';

addpath(genpath(repopath))
addpath(genpath(buzpath))
addpath([repopath datafolder])

%%
%Input
PopParamsAnalysis.I_e  = 250;       %External input
PopParamsAnalysis.sigma = 50;        %niose magnitude: variance
PopParamsAnalysis.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParamsAnalysis.EPopNum = 1000;
PopParamsAnalysis.IPopNum = 250;

%Neuron properties
PopParamsAnalysis.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParamsAnalysis.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParamsAnalysis.C       = [182 119];    %capacitance (pF)
PopParamsAnalysis.V_th    = [-45 -47];    %spike threshold (mV)
PopParamsAnalysis.V_reset = [-55 -55];    %reset potential (mV)
PopParamsAnalysis.t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties
PopParamsAnalysis.E_e     = 0;      %rev potential: E (mV)
PopParamsAnalysis.E_i     = -80;    %rev potential: I (mV)
PopParamsAnalysis.tau_s   = [5 5];      %synaptic decay timescale (1/ms)

%Adaptation Properties (No adaptation)
PopParamsAnalysis.E_w     = -70;    %rev potential: adaptation (mV)
PopParamsAnalysis.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParamsAnalysis.b       = 0;    %adaptation activation rate (1/ms)
PopParamsAnalysis.delta_T = 0;     %subthreshold adaptation steepness
PopParamsAnalysis.w_r     = 0.1;     %adaptation at rest (0-1)
PopParamsAnalysis.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParamsAnalysis.Wee   = 3;        %E->E weight (nS)
PopParamsAnalysis.Wii   = 3;        %I->I weight
PopParamsAnalysis.Wie   = 3;        %E->I weight
PopParamsAnalysis.Wei   = 3;        %I->E weight (Need to check this)
PopParamsAnalysis.Kee   = 100;        %Expected E->E In Degree
PopParamsAnalysis.Kii   = 100;        %Expected I->I In Degree
PopParamsAnalysis.Kie   = 100;        %Expected E->I In Degree
PopParamsAnalysis.Kei   = 100;        %Expected I->E In Degree

TimeParamsAnalysis.dt   = 0.05;

close all

%% SimTime

TimeParamsAnalysis.SimTime = 10000;

%% Learning Parameters

PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.TargetRate = 2; %Target E rate 1Hz
PopParamsAnalysis.tauSTDP = 20;

%%

PreTainPopParams = PopParamsAnalysis;

PostTrainPopParams1e1 = PopParamsAnalysis;
PostTrainPopParams1e2 = PopParamsAnalysis;

ScrambledPopParams1e1 = PopParamsAnalysis;
ScrambledPopParams1e2 = PopParamsAnalysis;

MeanPopParams1e1 = PopParamsAnalysis;
MeanPopParams1e2 = PopParamsAnalysis;

% %% Untrained Simulation
% 
% tic
% SimValuesPreTrain = AdLIFfunction_STDP(PreTainPopParams,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);
% toc
% 
% %% Trained Simulation 1e-1
% 
% load('longinhSTDP_fastrate-1e-1.mat')
% 
% PostTrainPopParams1e1.W = SimValues.WeightMat(:,:,11);
% 
% tic
% SimValuesPostTrain1e1 = AdLIFfunction_STDP(PostTrainPopParams1e1,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);
% toc
% 
% %% Trained Simulation 1e-2
% 
% load('longinhSTDP_fastrate-1e-2.mat')
% 
% PostTrainPopParams1e2.W = SimValues.WeightMat(:,:,11);
% 
% tic
% SimValuesPostTrain1e2 = AdLIFfunction_STDP(PostTrainPopParams1e2,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);
% toc
% 
% %% Scrambled Matrix Simulation 1e-1
% 
% load('longinhSTDP_fastrate-1e-1.mat')
% 
% ScrambledPopParams1e1.W = zeros(1250,1250);
% 
% ScrambledPopParams1e1.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,11);
% ScrambledPopParams1e1.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,11);
% ScrambledPopParams1e1.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,11);
% 
% EImatrix = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11);
% EIindex = find(EImatrix > 0);
% EIvalues = EImatrix(EIindex);
% EIscrambled = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));
% 
% randIndex = randperm(length(EIvalues));
% 
% for ei = 1:length(EIvalues)
%    
%     EIscrambled(EIindex(ei)) = EIvalues(randIndex(ei));
%     
% end
% 
% ScrambledPopParams1e1.W(SimValues.EcellIDX,SimValues.IcellIDX) = EIscrambled;
% 
% tic
% ScrambledSimValuesPostTrain1e1 = AdLIFfunction_STDP(ScrambledPopParams1e1,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);
% toc
% 
% %% Scrambled Matrix Simulation 1e-2
% 
% load('longinhSTDP_fastrate-1e-2.mat')
% 
% ScrambledPopParams1e2.W = zeros(1250,1250);
% 
% ScrambledPopParams1e2.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,11);
% ScrambledPopParams1e2.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,11);
% ScrambledPopParams1e2.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,11);
% 
% EImatrix = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11);
% EIindex = find(EImatrix > 0);
% EIvalues = EImatrix(EIindex);
% EIscrambled = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));
% 
% randIndex = randperm(length(EIvalues));
% 
% for ei = 1:length(EIvalues)
%    
%     EIscrambled(EIindex(ei)) = EIvalues(randIndex(ei));
%     
% end
% 
% ScrambledPopParams1e2.W(SimValues.EcellIDX,SimValues.IcellIDX) = EIscrambled;
% 
% tic
% ScrambledSimValuesPostTrain1e2 = AdLIFfunction_STDP(ScrambledPopParams1e2,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);
% toc
% 
% %% Mean Matrix Simulation 1e-1
% 
% load('longinhSTDP_fastrate-1e-1.mat')
% 
% MeanPopParams1e1.W = zeros(1250,1250);
% 
% MeanPopParams1e1.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,11);
% MeanPopParams1e1.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,11);
% MeanPopParams1e1.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,11);
% 
% EImatrix = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11);
% EIindex = find(SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11) > 0);
% EImeanMatrix = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));
% EImeanMatrix(EIindex) = mean(EImatrix(EIindex));
% 
% MeanPopParams1e1.W(SimValues.EcellIDX,SimValues.IcellIDX) = EImeanMatrix;
% 
% tic
% MeanSimValuesPostTrain1e1 = AdLIFfunction_STDP(MeanPopParams1e1,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);
% toc
% 
% %% Mean Matrix Simulation 1e-2
% 
% load('longinhSTDP_fastrate-1e-2.mat')
% 
% MeanPopParams1e2.W = zeros(1250,1250);
% 
% MeanPopParams1e2.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,11);
% MeanPopParams1e2.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,11);
% MeanPopParams1e2.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,11);
% 
% EImatrix = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11);
% EIindex = find(SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11) > 0);
% EImeanMatrix = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));
% EImeanMatrix(EIindex) = mean(EImatrix(EIindex));
% 
% MeanPopParams1e2.W(SimValues.EcellIDX,SimValues.IcellIDX) = EImeanMatrix;
% 
% tic
% MeanSimValuesPostTrain1e2 = AdLIFfunction_STDP(MeanPopParams1e2,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);
% toc

%% Deriving ISI Curves

ISIdiffPreTrain = [];

ISIdiffPostTrain1e1 = [];
ISIdiffPostTrain1e2 = [];

ISIdiffPostTrainScrambled1e1 = [];
ISIdiffPostTrainScrambled1e2 = [];

ISIdiffPostTrainMean1e1 = [];
ISIdiffPostTrainMean1e2 = [];

for n = 1:1250
    
    ISIdiffPreTrain = [ISIdiffPreTrain;diff(SimValuesPreTrain.spikesbycell{n})];
    
    ISIdiffPostTrain1e1 = [ISIdiffPostTrain1e1;diff(SimValuesPostTrain1e1.spikesbycell{n})];
    ISIdiffPostTrain1e2 = [ISIdiffPostTrain1e2;diff(SimValuesPostTrain1e2.spikesbycell{n})];
    
    ISIdiffPostTrainScrambled1e1 = [ISIdiffPostTrainScrambled1e1;diff(ScrambledSimValuesPostTrain1e1.spikesbycell{n})];
    ISIdiffPostTrainScrambled1e2 = [ISIdiffPostTrainScrambled1e2;diff(ScrambledSimValuesPostTrain1e2.spikesbycell{n})];
    
    ISIdiffPostTrainMean1e1 = [ISIdiffPostTrainMean1e1;diff(MeanSimValuesPostTrain1e1.spikesbycell{n})];
    ISIdiffPostTrainMean1e2 = [ISIdiffPostTrainMean1e2;diff(MeanSimValuesPostTrain1e2.spikesbycell{n})];
    
end

%%

bins = linspace(0,10,10);

[ISIvecPreTrain,ISImapPreTrain] = hist(ISIdiffPreTrain,bins);

[ISIvecPostTrain1e1,ISImapPostTrain1e1] = hist(ISIdiffPostTrain1e1,bins);
[ISIvecPostTrain1e2,ISImapPostTrain1e2] = hist(ISIdiffPostTrain1e2,bins);

[ISIvecPostTrainScrambled1e1,ISImapPostTrainScrambled1e1] = hist(ISIdiffPostTrainScrambled1e1,bins);
[ISIvecPostTrainScrambled1e2,ISImapPostTrainScrambled1e2] = hist(ISIdiffPostTrainScrambled1e2,bins);

[ISIvecPostTrainMean1e1,ISImapPostTrainMean1e1] = hist(ISIdiffPostTrainMean1e1,bins);
[ISIvecPostTrainMean1e2,ISImapPostTrainMean1e2] = hist(ISIdiffPostTrainMean1e2,bins);

%% ISI Curves

figure
plot(ISImapPostTrain1e1,ISIvecPostTrain1e1,'k','LineWidth',2)
hold on
plot(ISImapPostTrainScrambled1e1,log10(ISIvecPostTrainScrambled1e1),'r','LineWidth',2)
hold on
plot(ISImapPostTrainMean1e1,log10(ISIvecPostTrainMean1e1),'b','LineWidth',2)
xlabel('Time (ms)');ylabel('Frequency');title('ISI Training: 1e-1');
LogScale('y',10)
legend('Trained','Scrambled Matrix','Mean Matrix')

%%
saveas(gcf,[figfolder 'ISI_1e-1.png']);
NiceSave('ISI_1e-1.pdf',figfolder,[]);
close all

figure
plot(ISImapPostTrain1e2,log10(ISIvecPostTrain1e2),'k','LineWidth',2)
hold on
plot(ISImapPostTrainScrambled1e2,log10(ISIvecPostTrainScrambled1e2),'r','LineWidth',2)
hold on
plot(ISImapPostTrainMean1e2,log10(ISIvecPostTrainMean1e2),'b','LineWidth',2)
xlabel('Time (ms)');ylabel('Frequency');title('ISI Training: 1e-2');
LogScale('y',10)
legend('Trained','Scrambled Matrix','Mean Matrix')

saveas(gcf,[figfolder 'ISI_1e-2.png']);
NiceSave('ISI_1e-2.pdf',figfolder,[]);
close all

%% Raster Plots

figure
subplot(3,1,1)
plot(SimValuesPostTrain1e1.spikes(:,1),SimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([0 TimeParamsAnalysis.SimTime],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-1')
xlim([9000 9200])
ylim([0 1250])
subplot(3,1,2)
plot(ScrambledSimValuesPostTrain1e1.spikes(:,1),ScrambledSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([0 TimeParamsAnalysis.SimTime],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-1 (Scrambled)')
xlim([9000 9200])
ylim([0 1250])
subplot(3,1,3)
plot(MeanSimValuesPostTrain1e1.spikes(:,1),MeanSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([0 TimeParamsAnalysis.SimTime],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-1 (Mean)')
xlim([9000 9200])
ylim([0 1250])

saveas(gcf,[figfolder 'Raster1e-1.png']);
NiceSave('Raster1e-1.pdf',figfolder,[]);
close all

figure
subplot(3,1,1)
plot(SimValuesPostTrain1e2.spikes(:,1),SimValuesPostTrain1e2.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([0 TimeParamsAnalysis.SimTime],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-2')
xlim([9000 9200])
ylim([0 1250])
subplot(3,1,2)
plot(ScrambledSimValuesPostTrain1e2.spikes(:,1),ScrambledSimValuesPostTrain1e2.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([0 TimeParamsAnalysis.SimTime],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-2 (Scrambled)')
xlim([9000 9200])
ylim([0 1250])
subplot(3,1,3)
plot(MeanSimValuesPostTrain1e2.spikes(:,1),MeanSimValuesPostTrain1e2.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([0 TimeParamsAnalysis.SimTime],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-2 (Mean)')
xlim([9000 9200])
ylim([0 1250])

saveas(gcf,[figfolder 'Raster1e-2.png']);
NiceSave('Raster1e-2.pdf',figfolder,[]);
close all

%% Weight Analysis

load('longinhSTDP_fastrate-1e-1.mat')

%%
time = zeros(5,100);
weightDist = zeros(5,100);

for ii = 0:5
    
WEND = reshape(SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,2*ii+1),[250000,1]);

id = find(WEND==0);

WEND(id) = nan;

[weightDist(ii+1,:),time] = hist(WEND,linspace(0,20,100));

end

figure
imagesc(1:6,time,weightDist')
xlabel('Times (ms)');ylabel('Weight (nS)');title('Distribution of Weight: 1e-1')
xticks(1:6)
xticklabels(SimValues.t_weight(1:2:11))
set(gca,'YDir','normal')
caxis([0 12000])
colorbar

saveas(gcf,[figfolder 'WeightDist1e-1.png']);
NiceSave('WeightDist1e-1.pdf',figfolder,[]);
close all

%%
eigStart = eig(SimValues.WeightMat(:,:,1));
eigEnd = eig(SimValues.WeightMat(:,:,11));

PopParamsAnalysis.W = zeros(1250,1250);

PopParamsAnalysis.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,11);
PopParamsAnalysis.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,11);
PopParamsAnalysis.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,11);

eRandIndex = randperm(1000);
iRandIndex = randperm(250) + 1000;

for ee = 1:length(eRandIndex)
for ii = 1:length(iRandIndex)
    
    PopParamsAnalysis.W(ee,ii+1000) = SimValues.WeightMat(eRandIndex(ee),iRandIndex(ii),11);
    
end
end

eigScrambled = eig(PopParamsAnalysis.W);

figure
subplot(3,1,1)
plot(real(eigStart),imag(eigStart),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues Start Trained: 1e-1')
xlim([-100 700])

subplot(3,1,2)
plot(real(eigEnd),imag(eigEnd),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Trained: 1e-1')
xlim([-100 700])

subplot(3,1,3)
plot(real(eigScrambled),imag(eigScrambled),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Scrambled')
xlim([-100 700])

saveas(gcf,[figfolder 'Eig1e-1.png']);
NiceSave('Eig1e-1.pdf',figfolder,[]);
close all

%%

Espikes = cat(1,SimValues.spikesbycell{SimValues.EcellIDX});
Ispikes = cat(1,SimValues.spikesbycell{SimValues.IcellIDX});

EspikesSTART = Espikes(Espikes < 1e4);
IspikesSTART = Ispikes(Ispikes < 1e4);

EspikesEND = Espikes(Espikes > 1e6);
IspikesEND = Ispikes(Ispikes > 1e6);

[ccgSTART,t_ccgSTART] = CCG({double(EspikesSTART./1000),double(IspikesSTART./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgEND,t_ccgEND] = CCG({double(EspikesEND./1000),double(IspikesEND./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

%%
EspikesPreTrain = cat(1,SimValuesPreTrain.spikesbycell{SimValuesPreTrain.EcellIDX});
IspikesPreTrain = cat(1,SimValuesPreTrain.spikesbycell{SimValuesPreTrain.IcellIDX});

EspikesPostTrain1e1 = cat(1,SimValuesPostTrain1e1.spikesbycell{SimValuesPostTrain1e1.EcellIDX});
IspikesPostTrain1e1 = cat(1,SimValuesPostTrain1e1.spikesbycell{SimValuesPostTrain1e1.IcellIDX});

EspikesScrambledPostTrain1e1 = cat(1,ScrambledSimValuesPostTrain1e1.spikesbycell{ScrambledSimValuesPostTrain1e1.EcellIDX});
IspikesScrambledPostTrain1e1 = cat(1,ScrambledSimValuesPostTrain1e1.spikesbycell{ScrambledSimValuesPostTrain1e1.IcellIDX});

EspikesMeanPostTrain1e1 = cat(1,MeanSimValuesPostTrain1e1.spikesbycell{MeanSimValuesPostTrain1e1.EcellIDX});
IspikesMeanPostTrain1e1 = cat(1,MeanSimValuesPostTrain1e1.spikesbycell{MeanSimValuesPostTrain1e1.IcellIDX});

[ccgPreTrain,t_ccgPreTrain] = CCG({double(EspikesPreTrain./1000),double(IspikesPreTrain./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgPostTrain1e1,t_ccgPostTrain1e1] = CCG({double(EspikesPostTrain1e1./1000),double(IspikesPostTrain1e1./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgScrambledPostTrain1e1,t_ccgScrambledPostTrain1e1] = CCG({double(EspikesScrambledPostTrain1e1./1000),double(IspikesScrambledPostTrain1e1./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgMeanPostTrain1e1,t_ccgMeanPostTrain1e1] = CCG({double(EspikesMeanPostTrain1e1./1000),double(IspikesMeanPostTrain1e1./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

%%
figure
subplot(3,2,1)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','Markersize',1)
hold on
plot([0 200],[1000 1000],'r')
xlabel('Time (ms)');ylabel('Neuron ID');title('Start of Training')
xlim([0 200]);ylim([0 1250])

subplot(3,2,2)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','Markersize',1)
hold on
plot([1e6 1e6+200],[1000 1000],'r')
xlabel('Time (ms)');ylabel('Neuron ID');title('End of Training')
xlim([1e6 1e6+200]);ylim([0 1250])

subplot(3,2,3)
    [ax,e,i] = plotyy(t_ccgSTART*1000,ccgSTART(:,1,1)./length(SimValues.EcellIDX),t_ccgSTART*1000,ccgSTART(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,2,5)
    [ax,e,i] = plotyy(t_ccgSTART*1000,ccgSTART(:,2,1)./length(SimValues.EcellIDX),t_ccgSTART*1000,ccgSTART(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
subplot(3,2,4)
    [ax,e,i] = plotyy(t_ccgEND*1000,ccgEND(:,1,1)./length(SimValues.EcellIDX),t_ccgEND*1000,ccgEND(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,2,6)
    [ax,e,i] = plotyy(t_ccgEND*1000,ccgEND(:,2,1)./length(SimValues.EcellIDX),t_ccgEND*1000,ccgEND(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
NiceSave('RasterTraining1e1.pdf',figfolder,[]);
close all

figure
subplot(4,1,1)
plot(real(eigStart),imag(eigStart),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues Start Trained: 1e-1')
xlim([-100 700])

subplot(4,1,2)
plot(real(eigEnd),imag(eigEnd),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Trained: 1e-1')
xlim([-100 700])

subplot(2,1,2)
imagesc(1:6,time,log10(weightDist)')
xlabel('Times (ms)');ylabel('Weight (nS)');title('Distribution of Weight Log_{10} at Learning: 1e-1')
xticks(1:6)
xticklabels(SimValues.t_weight(1:2:11))
set(gca,'YDir','normal')
% caxis([0 12000])
colorbar
NiceSave('WeightTraining1e1.pdf',figfolder,[]);
close all

%%
figure
subplot(3,4,1)
plot(SimValuesPreTrain.spikes(:,1),SimValuesPreTrain.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Pre-Training')
xlim([9000 9200]);ylim([0 1250])
subplot(3,4,2)
plot(SimValuesPostTrain1e1.spikes(:,1),SimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Trained: 1e1')
xlim([9000 9200]);ylim([0 1250])
subplot(3,4,3)
plot(ScrambledSimValuesPostTrain1e1.spikes(:,1),ScrambledSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Scrambled: 1e1')
xlim([9000 9200]);ylim([0 1250])
subplot(3,4,4)
plot(MeanSimValuesPostTrain1e1.spikes(:,1),MeanSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Mean: 1e1')
xlim([9000 9200]);ylim([0 1250])

subplot(3,4,5)
    [ax,e,i] = plotyy(t_ccgPreTrain*1000,ccgPreTrain(:,1,1)./length(SimValues.EcellIDX),t_ccgPreTrain*1000,ccgPreTrain(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,9)
    [ax,e,i] = plotyy(t_ccgPreTrain*1000,ccgPreTrain(:,2,1)./length(SimValues.EcellIDX),t_ccgPreTrain*1000,ccgPreTrain(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
subplot(3,4,6)
    [ax,e,i] = plotyy(t_ccgPostTrain1e1*1000,ccgPostTrain1e1(:,1,1)./length(SimValues.EcellIDX),t_ccgPostTrain1e1*1000,ccgPostTrain1e1(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,10)
    [ax,e,i] = plotyy(t_ccgPostTrain1e1*1000,ccgPostTrain1e1(:,2,1)./length(SimValues.EcellIDX),t_ccgPostTrain1e1*1000,ccgPostTrain1e1(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
subplot(3,4,7)
    [ax,e,i] = plotyy(t_ccgScrambledPostTrain1e1*1000,ccgScrambledPostTrain1e1(:,1,1)./length(SimValues.EcellIDX),t_ccgScrambledPostTrain1e1*1000,ccgScrambledPostTrain1e1(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,11)
    [ax,e,i] = plotyy(t_ccgScrambledPostTrain1e1*1000,ccgScrambledPostTrain1e1(:,2,1)./length(SimValues.EcellIDX),t_ccgScrambledPostTrain1e1*1000,ccgScrambledPostTrain1e1(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')

subplot(3,4,8)
    [ax,e,i] = plotyy(t_ccgMeanPostTrain1e1*1000,ccgMeanPostTrain1e1(:,1,1)./length(SimValues.EcellIDX),t_ccgMeanPostTrain1e1*1000,ccgMeanPostTrain1e1(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,12)
    [ax,e,i] = plotyy(t_ccgMeanPostTrain1e1*1000,ccgMeanPostTrain1e1(:,2,1)./length(SimValues.EcellIDX),t_ccgMeanPostTrain1e1*1000,ccgMeanPostTrain1e1(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')

NiceSave('WeightComparison1e1.pdf',figfolder,[]);
close all

%% Weight Analysis

load('longinhSTDP_fastrate-1e-2.mat')   

%% Eigenvalues

time = zeros(5,100);
weightDist = zeros(5,100);

for ii = 0:5
    
WEND = reshape(SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,2*ii+1),[250000,1]);

id = find(WEND==0);

WEND(id) = nan;

[weightDist(ii+1,:),time] = hist(WEND,linspace(0,20,100));

end

figure
imagesc(1:6,time,weightDist')
xlabel('Times (ms)');ylabel('Weight (nS)');title('Distribution of Weight: 1e-2')
xticks(1:6)
xticklabels(SimValues.t_weight(1:2:11))
set(gca,'YDir','normal')
caxis([0 12000])
colorbar

saveas(gcf,[figfolder 'WeightDist1e-2.png']);
NiceSave('WeightDist1e-2.pdf',figfolder,[]);
close all

%% Eigenvalues

eigStart = eig(SimValues.WeightMat(:,:,1));
eigEnd = eig(SimValues.WeightMat(:,:,11));

PopParamsAnalysis.W = zeros(1250,1250);

PopParamsAnalysis.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,11);
PopParamsAnalysis.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,11);
PopParamsAnalysis.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,11);

eRandIndex = randperm(1000);
iRandIndex = randperm(250) + 1000;

for ee = 1:length(eRandIndex)
for ii = 1:length(iRandIndex)
    
    PopParamsAnalysis.W(ee,ii+1000) = SimValues.WeightMat(eRandIndex(ee),iRandIndex(ii),11);
    
end
end

eigScrambled = eig(PopParamsAnalysis.W);

figure
subplot(3,1,1)
plot(real(eigStart),imag(eigStart),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues Start Trained: 1e-2')
xlim([-100 700])

subplot(3,1,2)
plot(real(eigEnd),imag(eigEnd),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Trained: 1e-2')
xlim([-100 700])

subplot(3,1,3)
plot(real(eigScrambled),imag(eigScrambled),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Scrambled')
xlim([-100 700])

saveas(gcf,[figfolder 'Eig1e-2.png']);
NiceSave('Eig1e-2.pdf',figfolder,[]);
close all

%%

Espikes = cat(1,SimValues.spikesbycell{SimValues.EcellIDX});
Ispikes = cat(1,SimValues.spikesbycell{SimValues.IcellIDX});

EspikesSTART = Espikes(Espikes < 1e4);
IspikesSTART = Ispikes(Ispikes < 1e4);

EspikesEND = Espikes(Espikes > 1e6);
IspikesEND = Ispikes(Ispikes > 1e6);

[ccgSTART,t_ccgSTART] = CCG({double(EspikesSTART./1000),double(IspikesSTART./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgEND,t_ccgEND] = CCG({double(EspikesEND./1000),double(IspikesEND./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

%%
EspikesPreTrain = cat(1,SimValuesPreTrain.spikesbycell{SimValuesPreTrain.EcellIDX});
IspikesPreTrain = cat(1,SimValuesPreTrain.spikesbycell{SimValuesPreTrain.IcellIDX});

EspikesPostTrain1e2 = cat(1,SimValuesPostTrain1e2.spikesbycell{SimValuesPostTrain1e2.EcellIDX});
IspikesPostTrain1e2 = cat(1,SimValuesPostTrain1e2.spikesbycell{SimValuesPostTrain1e2.IcellIDX});

EspikesScrambledPostTrain1e2 = cat(1,ScrambledSimValuesPostTrain1e2.spikesbycell{ScrambledSimValuesPostTrain1e2.EcellIDX});
IspikesScrambledPostTrain1e2 = cat(1,ScrambledSimValuesPostTrain1e2.spikesbycell{ScrambledSimValuesPostTrain1e2.IcellIDX});

EspikesMeanPostTrain1e2 = cat(1,MeanSimValuesPostTrain1e2.spikesbycell{MeanSimValuesPostTrain1e2.EcellIDX});
IspikesMeanPostTrain1e2 = cat(1,MeanSimValuesPostTrain1e2.spikesbycell{MeanSimValuesPostTrain1e2.IcellIDX});

[ccgPreTrain,t_ccgPreTrain] = CCG({double(EspikesPreTrain./1000),double(IspikesPreTrain./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgPostTrain1e2,t_ccgPostTrain1e2] = CCG({double(EspikesPostTrain1e2./1000),double(IspikesPostTrain1e2./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgScrambledPostTrain1e2,t_ccgScrambledPostTrain1e2] = CCG({double(EspikesScrambledPostTrain1e2./1000),double(IspikesScrambledPostTrain1e2./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');
[ccgMeanPostTrain1e2,t_ccgMeanPostTrain1e2] = CCG({double(EspikesMeanPostTrain1e2./1000),double(IspikesMeanPostTrain1e2./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');

%%
figure
subplot(3,2,1)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','Markersize',1)
hold on
plot([0 200],[1000 1000],'r')
xlabel('Time (ms)');ylabel('Neuron ID');title('Start of Training')
xlim([0 200]);ylim([0 1250])

subplot(3,2,2)
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','Markersize',1)
hold on
plot([1e6 1e6+200],[1000 1000],'r')
xlabel('Time (ms)');ylabel('Neuron ID');title('End of Training')
xlim([1e6 1e6+200]);ylim([0 1250])

subplot(3,2,3)
    [ax,e,i] = plotyy(t_ccgSTART*1000,ccgSTART(:,1,1)./length(SimValues.EcellIDX),t_ccgSTART*1000,ccgSTART(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,2,5)
    [ax,e,i] = plotyy(t_ccgSTART*1000,ccgSTART(:,2,1)./length(SimValues.EcellIDX),t_ccgSTART*1000,ccgSTART(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
subplot(3,2,4)
    [ax,e,i] = plotyy(t_ccgEND*1000,ccgEND(:,1,1)./length(SimValues.EcellIDX),t_ccgEND*1000,ccgEND(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,2,6)
    [ax,e,i] = plotyy(t_ccgEND*1000,ccgEND(:,2,1)./length(SimValues.EcellIDX),t_ccgEND*1000,ccgEND(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')

NiceSave('RasterTraining1e2.pdf',figfolder,[]);
close all

figure
subplot(4,1,1)
plot(real(eigStart),imag(eigStart),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues Start Trained: 1e-2')
xlim([-100 700])

subplot(4,1,2)
plot(real(eigEnd),imag(eigEnd),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Trained: 1e-2')
xlim([-100 700])

subplot(2,1,2)
imagesc(1:6,time,log10(weightDist)')
xlabel('Times (ms)');ylabel('Weight (nS)');title('Distribution of Weight Log_{10} at Learning: 1e-1')
xticks(1:6)
xticklabels(SimValues.t_weight(1:2:11))
set(gca,'YDir','normal')
% caxis([0 12000])
colorbar

NiceSave('WeightTraining1e2.pdf',figfolder,[]);
close all

%%
figure
subplot(3,4,1)
plot(SimValuesPreTrain.spikes(:,1),SimValuesPreTrain.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Pre-Training')
xlim([9000 9200]);ylim([0 1250])
subplot(3,4,2)
plot(SimValuesPostTrain1e1.spikes(:,1),SimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Trained: 1e2')
xlim([9000 9200]);ylim([0 1250])
subplot(3,4,3)
plot(ScrambledSimValuesPostTrain1e1.spikes(:,1),ScrambledSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Scrambled: 1e2')
xlim([9000 9200]);ylim([0 1250])
subplot(3,4,4)
plot(MeanSimValuesPostTrain1e1.spikes(:,1),MeanSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
hold on
plot([9000 9200],[1000 1000],'r','LineWidth',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Mean: 1e2')
xlim([9000 9200]);ylim([0 1250])

subplot(3,4,5)
    [ax,e,i] = plotyy(t_ccgPreTrain*1000,ccgPreTrain(:,1,1)./length(SimValues.EcellIDX),t_ccgPreTrain*1000,ccgPreTrain(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,9)
    [ax,e,i] = plotyy(t_ccgPreTrain*1000,ccgPreTrain(:,2,1)./length(SimValues.EcellIDX),t_ccgPreTrain*1000,ccgPreTrain(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
subplot(3,4,6)
    [ax,e,i] = plotyy(t_ccgPostTrain1e2*1000,ccgPostTrain1e2(:,1,1)./length(SimValues.EcellIDX),t_ccgPostTrain1e2*1000,ccgPostTrain1e2(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,10)
    [ax,e,i] = plotyy(t_ccgPostTrain1e2*1000,ccgPostTrain1e2(:,2,1)./length(SimValues.EcellIDX),t_ccgPostTrain1e2*1000,ccgPostTrain1e2(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')
    
subplot(3,4,7)
    [ax,e,i] = plotyy(t_ccgScrambledPostTrain1e2*1000,ccgScrambledPostTrain1e2(:,1,1)./length(SimValues.EcellIDX),t_ccgScrambledPostTrain1e2*1000,ccgScrambledPostTrain1e2(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,11)
    [ax,e,i] = plotyy(t_ccgScrambledPostTrain1e2*1000,ccgScrambledPostTrain1e2(:,2,1)./length(SimValues.EcellIDX),t_ccgScrambledPostTrain1e2*1000,ccgScrambledPostTrain1e2(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')

subplot(3,4,8)
    [ax,e,i] = plotyy(t_ccgMeanPostTrain1e2*1000,ccgMeanPostTrain1e2(:,1,1)./length(SimValues.EcellIDX),t_ccgMeanPostTrain1e2*1000,ccgMeanPostTrain1e2(:,1,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,1,2)./length(SimValues.IcellIDX),'r')
    xlabel('t lag from E spike (ms)')
subplot(3,4,12)
    [ax,e,i] = plotyy(t_ccgMeanPostTrain1e2*1000,ccgMeanPostTrain1e2(:,2,1)./length(SimValues.EcellIDX),t_ccgMeanPostTrain1e2*1000,ccgMeanPostTrain1e2(:,2,2)./length(SimValues.IcellIDX));
    set(e,'color','k');set(e,'linewidth',1)
    set(i,'color','r');set(i,'linewidth',1)
    hold on
    plot([0 0],get(gca,'ylim'),'k')
    xlim([-25 25])
    %plot(t,ccg(:,2,1)./length(SimValues.EcellIDX),'k')
    xlabel('t lag from I spike (ms)')

NiceSave('WeightComparison1e2.pdf',figfolder,[]);
close all
%% Check balance 

timewin = [9000 9200];

% [ PreTraincorrhist,PreTraincondx,PreTraincurrx,PreTraincurrPETH ] = CheckBalance( SimValuesPreTrain,PopParamsAnalysis,timewin);

% [ corrhistPostTrain1e1,condxPostTrain1e1,currxPostTrain1e1,currPETHPostTrain1e1 ] = CheckBalance( SimValuesPostTrain1e1,PopParamsAnalysis,timewin);
% NiceSave('CheckBalanceSynapse1e1.pdf',figfolder,[]);
% close all
% [ corrhistPostTrain1e2,condxPostTrain1e2,currxPostTrain1e2,currPETHPostTrain1e2 ] = CheckBalance( SimValuesPostTrain1e2,PopParamsAnalysis,timewin);
% NiceSave('CheckBalanceSynapse
% 1e2.pdf',figfolder,[]);
% close all
% [ ScrambledcorrhistPostTrain1e1,ScrambledcondxPostTrain1e1,ScrambledcurrxPostTrain1e1,ScrambledcurrPETHPostTrain1e1 ] = CheckBalance( ScrambledSimValuesPostTrain1e1,PopParamsAnalysis,timewin);
% [ ScrambledcorrhistPostTrain1e2,ScrambledcondxPostTrain1e2,ScrambledcurrxPostTrain1e2,ScrambledcurrPETHPostTrain1e2 ] = CheckBalance( ScrambledSimValuesPostTrain1e2,PopParamsAnalysis,timewin);
% 
% [ MeancorrhistPostTrain1e1,MeancondxPostTrain1e1,MeancurrxPostTrain1e1,MeancurrPETHPostTrain1e1 ] = CheckBalance( MeanSimValuesPostTrain1e1,PopParamsAnalysis,timewin);
% [ MeancorrhistPostTrain1e2,MeancondxPostTrain1e2,MeancurrxPostTrain1e2,MeancurrPETHPostTrain1e2 ] = CheckBalance( MeanSimValuesPostTrain1e2,PopParamsAnalysis,timewin);
