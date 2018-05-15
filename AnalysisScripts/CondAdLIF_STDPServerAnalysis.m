%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel/';
%repopath = '/home/jmg1030/SOSpikingModel';

datafolder = 'Data/Balance/05-5-2018/';

figfolder = '~/Desktop/';

addpath(genpath(repopath))
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

%%

TimeParamsAnalysis.SimTime = 1000;

%%

PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.TargetRate = 2; %Target E rate 1Hz
PopParamsAnalysis.tauSTDP = 20;

%% Untrained Simulation

tic
SimValuesPreTrain = AdLIFfunction_STDP(PopParamsAnalysis,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);
toc

%% Trained Simulation 1e-1

load('longinhSTDP_fastrate-1e-1.mat')

PopParamsAnalysis.W = SimValues.WeightMat(:,:,11);

tic
SimValuesPostTrain1e1 = AdLIFfunction_STDP(PopParamsAnalysis,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);
toc

%% Trained Simulation 1e-2

load('longinhSTDP_fastrate-1e-2.mat')

PopParamsAnalysis.W = SimValues.WeightMat(:,:,11);

tic
SimValuesPostTrain1e2 = AdLIFfunction_STDP(PopParamsAnalysis,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);
toc

%% Scrambled Matrix Simulation 1e-1

load('longinhSTDP_fastrate-1e-1.mat')

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

%%
tic
ScrambledSimValuesPostTrain1e1 = AdLIFfunction_STDP(PopParamsAnalysis,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);
toc

%% Scrambled Matrix Simulation 1e-2

load('longinhSTDP_fastrate-1e-2.mat')

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

%%
tic
ScrambledSimValuesPostTrain1e2 = AdLIFfunction_STDP(PopParamsAnalysis,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);
toc

%% Deriving ISI Curves

ISIdiffPreTrain = [];
ISIdiffPostTrain1e1 = [];
ISIdiffPostTrain1e2 = [];
ISIdiffPostTrainScrambled1e1 = [];
ISIdiffPostTrainScrambled1e2 = [];

for n = 1:1250
    ISIdiffPreTrain = [ISIdiffPreTrain;diff(SimValuesPreTrain.spikesbycell{n})];
    ISIdiffPostTrain1e1 = [ISIdiffPostTrain1e1;diff(SimValuesPostTrain1e1.spikesbycell{n})];
    ISIdiffPostTrain1e2 = [ISIdiffPostTrain1e2;diff(SimValuesPostTrain1e2.spikesbycell{n})];
    ISIdiffPostTrainScrambled1e1 = [ISIdiffPostTrainScrambled1e1;diff(ScrambledSimValuesPostTrain1e1.spikesbycell{n})];
    ISIdiffPostTrainScrambled1e2 = [ISIdiffPostTrainScrambled1e2;diff(ScrambledSimValuesPostTrain1e2.spikesbycell{n})];
end

%%
    
[ISIvecPreTrain,ISImapPreTrain] = hist(ISIdiffPreTrain,linspace(0,100,10));
[ISIvecPostTrain1e1,ISImapPostTrain1e1] = hist(ISIdiffPostTrain1e1,linspace(0,1000,10));
[ISIvecPostTrain1e2,ISImapPostTrain1e2] = hist(ISIdiffPostTrain1e2,linspace(0,1000,10));
[ISIvecPostTrainScrambled1e1,ISImapPostTrainScrambled1e1] = hist(ISIdiffPostTrainScrambled1e1,linspace(0,1000,10));
[ISIvecPostTrainScrambled1e2,ISImapPostTrainScrambled1e2] = hist(ISIdiffPostTrainScrambled1e2,linspace(0,1000,10));

%% ISI Curves

figure
plot(ISImapPostTrain1e1,ISIvecPostTrain1e1,'k','LineWidth',2)
hold on
plot(ISImapPostTrainScrambled1e1,ISIvecPostTrainScrambled1e1,'r','LineWidth',2)
xlabel('Time (ms)');ylabel('Frequency');title('ISI Training: 1e-1');
legend('Trained','Scrambled Matrix')

saveas(gcf,[figfolder 'ISI_1e-1.png']);

figure
plot(ISImapPostTrain1e2,ISIvecPostTrain1e2,'k','LineWidth',2)
hold on
plot(ISImapPostTrainScrambled1e2,ISIvecPostTrainScrambled1e2,'r','LineWidth',2)
legend('Trained','Scrambled Matrix')
xlabel('Time (ms)');ylabel('Frequency');title('ISI Training: 1e-2');

saveas(gcf,[figfolder 'ISI_1e-2.png']);

%% Raster Plots

figure
subplot(2,1,1)
plot(SimValuesPostTrain1e1.spikes(:,1),SimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-1')
xlim([0 TimeParamsAnalysis.SimTime])
ylim([0 1250])
subplot(2,1,2)
plot(ScrambledSimValuesPostTrain1e1.spikes(:,1),ScrambledSimValuesPostTrain1e1.spikes(:,2),'.k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-1 (Scrambled)')
xlim([0 TimeParamsAnalysis.SimTime])
ylim([0 1250])

saveas(gcf,[figfolder 'Raster1e-1.png']);

figure
subplot(2,1,1)
plot(SimValuesPostTrain1e2.spikes(:,1),SimValuesPostTrain1e2.spikes(:,2),'.k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-2')
xlim([0 TimeParamsAnalysis.SimTime])
ylim([0 1250])
subplot(2,1,2)
plot(ScrambledSimValuesPostTrain1e2.spikes(:,1),ScrambledSimValuesPostTrain1e2.spikes(:,2),'.k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Trained Raster 1e-2 (Scrambled)')
xlim([0 TimeParamsAnalysis.SimTime])
ylim([0 1250])

saveas(gcf,[figfolder 'Raster1e-2.png']);

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
xlim([-70 70])

subplot(3,1,2)
plot(real(eigEnd),imag(eigEnd),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Trained: 1e-1')
xlim([-70 70])

subplot(3,1,3)
plot(real(eigScrambled),imag(eigScrambled),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Scrambled')
xlim([-70 70])

saveas(gcf,[figfolder 'Eig1e-1.png']);

%%

Wstart = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,1);
Wend = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11);

Wstart(Wstart <= mean(mean(Wstart(Wstart > 0)))) = 0;
Wstart(Wstart > 0) = 1;

Wend(Wend <= mean(mean(Wend(Wend > 0)))) = 0;
Wend(Wend > 0) = 1;

figure;imagesc(Wstart)
figure;imagesc(Wend)

Hstart = entropy(Wstart)
Hend = entropy(Wend)

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
xlim([-50 50])

subplot(3,1,2)
plot(real(eigEnd),imag(eigEnd),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Trained: 1e-2')
xlim([-50 50])

subplot(3,1,3)
plot(real(eigScrambled),imag(eigScrambled),'.k','MarkerSize',1)
xlabel('Real');ylabel('Imaginary');title('Eigenvalues End Scrambled')
xlim([-50 50])

saveas(gcf,[figfolder 'Eig1e-2.png']);

%%

Wstart = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,1);
Wend = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,11);

Wstart(Wstart <= mean(mean(Wstart(Wstart > 0)))) = 0;
Wstart(Wstart > 0) = 1;

Wend(Wend <= mean(mean(Wend(Wend > 0)))) = 0;
Wend(Wend > 0) = 1;

figure;imagesc(Wstart)
figure;imagesc(Wend)

Hstart = entropy(Wstart)
Hend = entropy(Wend)
