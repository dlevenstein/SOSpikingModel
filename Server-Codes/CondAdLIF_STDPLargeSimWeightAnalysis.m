function CondAdLIF_STDPLargeSimWeightAnalysis(ww)

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel/';
repopath = '/scratch/jmg1030/WeightAnalysis/SOSpikingModel';

%buzpath = '/Users/jonathangornet/Documents/GitHub/buzcode/';
%datafolder = '/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-5-2018/';

%figfolder = '~/Desktop/';

addpath(genpath(repopath))
%addpath(genpath(buzpath))
%addpath([repopath datafolder])

%%
%Input
PopParamsAnalysis.I_e  = 250;       %External input
PopParamsAnalysis.sigma = 50;        %niose magnitude: variance
PopParamsAnalysis.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParamsAnalysis.EPopNum = 2000;
PopParamsAnalysis.IPopNum = 500;

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
PopParamsAnalysis.Kee   = 250;        %Expected E->E In Degree
PopParamsAnalysis.Kii   = 250;        %Expected I->I In Degree
PopParamsAnalysis.Kie   = 250;        %Expected E->I In Degree
PopParamsAnalysis.Kei   = 250;        %Expected I->E In Degree

TimeParamsAnalysis.dt   = 0.05;

close all

%% SimTime

TimeParamsAnalysis.SimTime = 10000;

%% Learning Parameters

PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.TargetRate = 2; %Target E rate 1Hz
PopParamsAnalysis.tauSTDP = 20;

%%

PreTainPopParams        = PopParamsAnalysis;
PostTrainPopParams      = PopParamsAnalysis;
ScrambledPopParams      = PopParamsAnalysis;
MeanPopParams           = PopParamsAnalysis;
PopParamsTrainingSTART  = PopParamsAnalysis;
PopParamsTrainingEND    = PopParamsAnalysis;

%% Trained Simulation 1e-1

load('/scratch/jmg1030/largePopWeight3.mat')

%% Untrained Simulation

if ww == 1
    
SimValuesPreTrain = AdLIFfunction_STDP(PreTainPopParams,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',false);

save('/scratch/jmg1030/WeightAnalysis/Weight_Pre','-v7.3')

end

%% Trained Simulation

if ww == 2
    
PostTrainPopParams.W = SimValues.WeightMat(:,:,4);

SimValuesPostTrain = AdLIFfunction_STDP(PostTrainPopParams,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);

save('/scratch/jmg1030/WeightAnalysis/Weight_Post','-v7.3')

end

%% Scrambled Matrix Simulation 1e-1

if ww == 3
    
ScrambledPopParams.W = zeros(2500,2500);

ScrambledPopParams.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,4);
ScrambledPopParams.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,4);
ScrambledPopParams.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,4);

EImatrix = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,4);
EIindex = find(EImatrix > 0);
EIvalues = EImatrix(EIindex);
EIscrambled = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));

randIndex = randperm(length(EIvalues));

for ei = 1:length(EIvalues)
   
    EIscrambled(EIindex(ei)) = EIvalues(randIndex(ei));
    
end

ScrambledPopParams.W(SimValues.EcellIDX,SimValues.IcellIDX) = EIscrambled;

ScrambledSimValuesPostTrain = AdLIFfunction_STDP(ScrambledPopParams,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);

save('/scratch/jmg1030/WeightAnalysis/Weight_Scrambled','-v7.3')

end

%% Mean Matrix Simulation 1e-1

if ww == 4
    
MeanPopParams.W = zeros(2500,2500);

MeanPopParams.W(SimValues.EcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.EcellIDX,SimValues.EcellIDX,4);
MeanPopParams.W(SimValues.IcellIDX,SimValues.IcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.IcellIDX,4);
MeanPopParams.W(SimValues.IcellIDX,SimValues.EcellIDX) = SimValues.WeightMat(SimValues.IcellIDX,SimValues.EcellIDX,4);

EImatrix = SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,4);
EIindex = find(SimValues.WeightMat(SimValues.EcellIDX,SimValues.IcellIDX,4) > 0);
EImeanMatrix = zeros(length(SimValues.EcellIDX),length(SimValues.IcellIDX));
EImeanMatrix(EIindex) = mean(EImatrix(EIindex));

MeanPopParams.W(SimValues.EcellIDX,SimValues.IcellIDX) = EImeanMatrix;

MeanSimValuesPostTrain = AdLIFfunction_STDP(MeanPopParams,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);

save('/scratch/jmg1030/WeightAnalysis/Weight_Mean','-v7.3')

end

%% Training at Pre

if ww == 5
    
PopParamsTrainingPreWeight.LearningRate = 1e-2;

SimValuesTrainingSTART = AdLIFfunction_STDP(PopParamsTrainingSTART,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);

save('/scratch/jmg1030/WeightAnalysis/TrainingWeight_START','-v7.3')

end

%% Training at Post

if ww == 6
    
PopParamsTrainingPostWeight.LearningRate = 1e-2;
    
PopParamsTrainingPostWeight.W = SimValues.WeightMat(:,:,4);

SimValuesTrainingEND = AdLIFfunction_STDP(PopParamsTrainingEND,TimeParamsAnalysis,'cellout',true,'showprogress',true,'showfig',true);

save('/scratch/jmg1030/WeightAnalysis/TrainingWeight_END','-v7.3')

end
