%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
%repopath = '/scratch/jmg1030/WeightAnalysis/Data/SOSpikingModel';
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';

%repopath = '/home/jmg1030/SOSpikingModel';
addpath(genpath(repopath))

%figfolder = '/scratch/jmg1030/WeightAnalysis/Data';
SAVESIM = true;
%% Pretrain Analysis

% load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-27-2018/MeanSimValuesPostTrain1e2.mat')
% load('/scratch/jmg1030/WeightAnalysis/Data/Weight_Pre')
% [ exNeuPre,t_ccgPre,ccgPre,currxPre,condxPre,t_lagsPre ] = GetPlotValues( SimValuesPreTrain,PostTrainPopParams,timewin )

%load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-27-2018/SimValuesPostTrain1e2.mat')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Post')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Scrambled')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Mean')

load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Post')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Scrambled')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Mean')
%%
timewin = [10000-200 10000];

[ exNeuPost,t_ccgPost,ccgPost,currxPost,condxPost,t_lagsPost ] = GetPlotValues( SimValuesPostTrain,PostTrainPopParams,timewin )
% [ exNeuScrambled,t_ccgScrambled,ccgScrambled,currxScrambled,condxScrambled,t_lagsScrambled ] = GetPlotValues( ScrambledSimValuesPostTrain,ScrambledPopParams,timewin )
% [ exNeuMean,t_ccgMean,ccgMean,currxMean,condxMean,t_lagsMean ] = GetPlotValues( MeanSimValuesPostTrain,MeanPopParams,timewin )

%%
%load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-27-2018/ScrambledSimValuesPostTrain1e2.mat')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Scrambled')
% [ exNeuScrambled,t_ccgScrambled,ccgScrambled,currxScrambled,condxScrambled,t_lagsScrambled ] = GetPlotValues( ScrambledSimValuesPostTrain,ScrambledPopParams,timewin )

%load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-27-2018/MeanSimValuesPostTrain1e2.mat')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/Weight_Mean')
% [ exNeuMean,t_ccgMean,ccgMean,currxMean,condxMean,t_lagsMean ] = GetPlotValues( MeanSimValuesPostTrain,MeanPopParams,timewin )

%%
timewin = [9800 10000];
[ exNeuPost,t_ccgPost,ccgPost,currxPost,condxPost,t_lagsPost ] = GetPlotValues( SimValuesPostTrain,PostTrainPopParams,timewin )
[ exNeuScrambled,t_ccgScrambled,ccgScrambled,currxScrambled,condxScrambled,t_lagsScrambled ] = GetPlotValues( ScrambledSimValuesPostTrain,ScrambledPopParams,timewin )
[ exNeuMean,t_ccgMean,ccgMean,currxMean,condxMean,t_lagsMean ] = GetPlotValues( MeanSimValuesPostTrain,MeanPopParams,timewin )
%%
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/TrainingWeight_START')
load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Other/TrainingWeight_END')
%%
timewin = [9800 10000];

%[ exNeuSTART,t_ccgSTART,ccgSTART,currxSTART,condxSTART,t_lagsSTART ] = GetPlotValues( SimValuesTrainingSTART,PopParamsTrainingSTART,timewin )
[ exNeuEND,t_ccgEND,ccgEND,currxEND,condxEND,t_lagsEND ] = GetPlotValues( SimValuesPostTrain,PostTrainPopParams,timewin )

%%
% [ exNeu,t_ccg,ccg,currx,condx,t_lags ] = GetPlotValues( SimValues,PopParams,timewin )
% %%
% 
% close all
% 
% figure
% 
% subplot(2,2,1)
%     
%     plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','markersize',1)
%     hold on
%     plot([9800 10000],[2000 2000],'r','linewidth',2)
%     xlim([9800 10000]);ylim([0 2500])
%     xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
% 
% subplot(4,2,5)
% 
%     plot(SimValues.t,exNeu.E.I_syne,'b')
%     hold on
%     plot(SimValues.t,exNeu.E.I_syni,'r')
%     hold on
%     plot(SimValues.t,exNeu.E.I,'k')
%     xlim([9800 10000]);
%     legend('Excitatory','Inhibitory')
%     xlabel('Time (ms)');ylabel('Synaptic Conductance');title('Example Excitatory cell Cell')
% 
% subplot(4,2,2)
%     
%     plot(t_ccg*1000,ccg(:,1,1)./length(SimValues.EcellIDX),'b','linewidth',1)
%     hold on
%     plot(t_ccg*1000,ccg(:,1,2)./length(SimValues.IcellIDX),'r','linewidth',1)
%     legend('Excitatory','Inhibitory')
%     xlabel('t lag from E spike (ms)');ylabel('Rate')
% 
% subplot(4,2,4)
%     
%     plot(t_ccg*1000,ccg(:,2,1)./length(SimValues.EcellIDX),'b','linewidth',1)
%     hold on
%     plot(t_ccg*1000,ccg(:,2,2)./length(SimValues.IcellIDX),'r','linewidth',1)
%     legend('Excitatory','Inhibitory')
%     xlabel('t lag from I spike (ms)');ylabel('Rate')
% 
% subplot(4,2,6)
% 
%     plot(currx.tlags,currx.meanE,'b','linewidth',1)
%     hold on
%     plot(condx.tlags,condx.meanE,'b--','linewidth',1)
%     plot(currx.tlags,currx.meanI,'r','linewidth',1)
%     plot(condx.tlags,condx.meanI,'r--','linewidth',1)
%     plot([0 0],[-1 1],'k:')
%     plot(t_lags([1 end]),[0 0],'k')
%     legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
%     xlabel('t lag');ylabel('Mean Input Correlation')
% 
% figname = 'EndTrain';
% NiceSave(figname,figfolder,[])

%%
% figure
% 
% subplot(2,2,1)
%      
% %     plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','markersize',1)
% %     hold on
%     plot([9800 10000],[2000 2000],'r','linewidth',2)
%     xlim([9800 10000]);ylim([0 2500])
%     xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
% 
% subplot(4,2,5)
% 
% %     plot(SimValues.t,exNeu.E.I_syne,'b')
% %     hold on
% %     plot(SimValues.t,exNeu.E.I_syni,'r')
% %     hold on
% %     plot(SimValues.t,exNeu.E.I,'k')
%     xlim([9800 10000]);
%     legend('Excitatory','Inhibitory')
%     xlabel('Time (ms)');ylabel('Synaptic Conductance');title('Example Excitatory cell Cell')
% 
% subplot(4,2,2)
%     
% %     plot(t_ccg*1000,ccg(:,1,1)./length(SimValues.EcellIDX),'b','linewidth',1)
% %     hold on
% %     plot(t_ccg*1000,ccg(:,1,2)./length(SimValues.IcellIDX),'r','linewidth',1)
%     legend('Excitatory','Inhibitory')
%     xlabel('t lag from E spike (ms)');ylabel('Rate')
% 
% subplot(4,2,4)
%     
% %     plot(t_ccg*1000,ccg(:,2,1)./length(SimValues.EcellIDX),'b','linewidth',1)
% %     hold on
% %     plot(t_ccg*1000,ccg(:,2,2)./length(SimValues.IcellIDX),'r','linewidth',1)
%     legend('Excitatory','Inhibitory')
%     xlabel('t lag from I spike (ms)');ylabel('Rate')
% 
% subplot(4,2,6)
% 
% %     plot(currx.tlags,currx.meanE,'b','linewidth',1)
% %     hold on
% %     plot(condx.tlags,condx.meanE,'b--','linewidth',1)
% %     plot(currx.tlags,currx.meanI,'r','linewidth',1)
% %     plot(condx.tlags,condx.meanI,'r--','linewidth',1)
%     plot([0 0],[-1 1],'k:')
%     plot(t_lags([1 end]),[0 0],'k')
%     legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
%     xlabel('t lag');ylabel('Mean Input Correlation')
% 
% figname = 'StartTrain';
% figfolder = '~/Desktop';
% NiceSave(figname,figfolder,[])

%%

timewin = [9800 10000];

%%

close all

figure

subplot(4,2,2)
    
    plot(SimValuesTrainingEND.spikes(:,1),SimValuesTrainingEND.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[2000 2000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
    
subplot(4,2,1)
    
    plot(SimValuesTrainingSTART.spikes(:,1),SimValuesTrainingSTART.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[2000 2000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');

subplot(4,2,4)

    plot(SimValuesTrainingEND.t,exNeuEND.E.I_syne,'b')
    hold on
    plot(SimValuesTrainingEND.t,exNeuEND.E.I_syni,'r')
    hold on
    plot(SimValuesTrainingEND.t,exNeuEND.E.I,'k')
    xlim([9800 10000]);
    %legend('Excitatory','Inhibitory')
    xlabel('Time (ms)');ylabel('Synaptic Conductance');title('Example Excitatory cell Cell')
    
subplot(4,2,3)

    plot(SimValuesTrainingSTART.t,exNeuSTART.E.I_syne,'b')
    hold on
    plot(SimValuesTrainingSTART.t,exNeuSTART.E.I_syni,'r')
    hold on
    plot(SimValuesTrainingSTART.t,exNeuSTART.E.I,'k')
    xlim([9800 10000]);
    %legend('Excitatory','Inhibitory')
    xlabel('Time (ms)');ylabel('Synaptic Conductance');title('Example Excitatory cell Cell')

subplot(4,2,8)

    plot(currxEND.tlags,currxEND.meanE,'b','linewidth',1)
    hold on
    plot(condxEND.tlags,condxEND.meanE,'b--','linewidth',1)
    plot(currxEND.tlags,currxEND.meanI,'r','linewidth',1)
    plot(condxEND.tlags,condxEND.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lagsEND([1 end]),[0 0],'k')
    %legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')
    
    
subplot(4,4,11)
    
    plot(t_ccgEND*1000,ccgEND(:,1,1)./length(SimValuesTrainingEND.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgEND*1000,ccgEND(:,1,2)./length(SimValuesTrainingEND.IcellIDX),'r','linewidth',1)
    xlim([-25 25])
    %legend('Excitatory','Inhibitory')
    xlabel('t lag from E spike (ms)');ylabel('Rate')

subplot(4,4,12)
    
    plot(t_ccgEND*1000,ccgEND(:,2,1)./length(SimValuesTrainingEND.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgEND*1000,ccgEND(:,2,2)./length(SimValuesTrainingEND.IcellIDX),'r','linewidth',1)
    xlim([-25 25])
    %legend('Excitatory','Inhibitory')
    xlabel('t lag from I spike (ms)');ylabel('Rate')
    
subplot(4,4,9)
    
    plot(t_ccgSTART*1000,ccgSTART(:,1,1)./length(SimValuesTrainingSTART.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgSTART*1000,ccgSTART(:,1,2)./length(SimValuesTrainingSTART.IcellIDX),'r','linewidth',1)
    xlim([-25 25])
    %legend('Excitatory','Inhibitory')
    xlabel('t lag from E spike (ms)');ylabel('Rate')

subplot(4,4,10)
    
    plot(t_ccgSTART*1000,ccgSTART(:,2,1)./length(SimValuesTrainingSTART.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgSTART*1000,ccgSTART(:,2,2)./length(SimValuesTrainingSTART.IcellIDX),'r','linewidth',1)
    xlim([-25 25])
    %legend('Excitatory','Inhibitory')
    xlabel('t lag from I spike (ms)');ylabel('Rate')

subplot(4,2,7)

    plot(currxSTART.tlags,currxSTART.meanE,'b','linewidth',1)
    hold on
    plot(condxSTART.tlags,condxSTART.meanE,'b--','linewidth',1)
    plot(currxSTART.tlags,currxSTART.meanI,'r','linewidth',1)
    plot(condxSTART.tlags,condxSTART.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lagsSTART([1 end]),[0 0],'k')
    %legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')

figname = 'ComparisonTrain';
NiceSave(figname,figfolder,[])

%%

close all

figure

% Post Trained
subplot(4,3,1)
    
    plot(SimValuesPostTrain.spikes(:,1),SimValuesPostTrain.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[2000 2000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
    
subplot(4,3,4)
    
    plot(t_ccgPost*1000,ccgPost(:,1,1)./length(ScrambledSimValuesPostTrain.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgPost*1000,ccgPost(:,1,2)./length(ScrambledSimValuesPostTrain.IcellIDX),'r','linewidth',1)
    %legend('Excitatory','Inhibitory')
    xlim([-25 25]);ylim([0 20])
    xlabel('t lag from E spike (ms)');ylabel('Rate')

subplot(4,3,7)
    
    plot(t_ccgPost*1000,ccgPost(:,2,1)./length(ScrambledSimValuesPostTrain.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgPost*1000,ccgPost(:,2,2)./length(ScrambledSimValuesPostTrain.IcellIDX),'r','linewidth',1)
    %legend('Excitatory','Inhibitory')
    xlim([-25 25]);ylim([0 20])
    xlabel('t lag from I spike (ms)');ylabel('Rate')

%Scrambled Trained
subplot(4,3,2)
    
    plot(ScrambledSimValuesPostTrain.spikes(:,1),ScrambledSimValuesPostTrain.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[2000 2000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
    
subplot(4,3,5)
    
    plot(t_ccgScrambled*1000,ccgScrambled(:,1,1)./length(ScrambledSimValuesPostTrain.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgScrambled*1000,ccgScrambled(:,1,2)./length(ScrambledSimValuesPostTrain.IcellIDX),'r','linewidth',1)
    %legend('Excitatory','Inhibitory')
    xlim([-25 25]);ylim([0 20])
    xlabel('t lag from E spike (ms)');ylabel('Rate')

subplot(4,3,8)
    
    plot(t_ccgScrambled*1000,ccgScrambled(:,2,1)./length(ScrambledSimValuesPostTrain.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgScrambled*1000,ccgScrambled(:,2,2)./length(ScrambledSimValuesPostTrain.IcellIDX),'r','linewidth',1)
    %legend('Excitatory','Inhibitory')
    xlim([-25 25]);ylim([0 20])
    xlabel('t lag from I spike (ms)');ylabel('Rate')
    
%Mean Trained
subplot(4,3,3)
    
    plot(MeanSimValuesPostTrain.spikes(:,1),MeanSimValuesPostTrain.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[2000 2000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
    
subplot(4,3,6)
    
    plot(t_ccgMean*1000,ccgMean(:,1,1)./length(MeanSimValuesPostTrain.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgMean*1000,ccgMean(:,1,2)./length(MeanSimValuesPostTrain.IcellIDX),'r','linewidth',1)
    %legend('Excitatory','Inhibitory')
    xlim([-25 25]);ylim([0 20])
    xlabel('t lag from E spike (ms)');ylabel('Rate')

subplot(4,3,9)
    
    plot(t_ccgMean*1000,ccgMean(:,2,1)./length(MeanSimValuesPostTrain.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccgMean*1000,ccgMean(:,2,2)./length(MeanSimValuesPostTrain.IcellIDX),'r','linewidth',1)
    %legend('Excitatory','Inhibitory')
    xlim([-25 25]);ylim([0 25])
    xlabel('t lag from I spike (ms)');ylabel('Rate')
    
figname = 'RasterWeights';
NiceSave(figname,figfolder,[])

%%

% close all

figure

subplot(4,3,1)

    plot(SimValuesPostTrain.t,exNeuPost.E.I_syne,'b')
    hold on
    plot(SimValuesPostTrain.t,exNeuPost.E.I_syni,'r')
    hold on
    plot(SimValuesPostTrain.t,exNeuPost.E.I,'k')
    xlim([9800 10000]);
    %legend('Excitatory','Inhibitory')
    xlabel('Time (ms)');ylabel('Synaptic Current');title('Example Excitatory cell Cell')

subplot(4,3,2)

    plot(ScrambledSimValuesPostTrain.t,exNeuScrambled.E.I_syne,'b')
    hold on
    plot(ScrambledSimValuesPostTrain.t,exNeuScrambled.E.I_syni,'r')
    hold on
    plot(ScrambledSimValuesPostTrain.t,exNeuScrambled.E.I,'k')
    xlim([9800 10000]);
    %legend('Excitatory','Inhibitory')
    xlabel('Time (ms)');ylabel('Synaptic Current');title('Example Excitatory cell Cell')

subplot(4,3,3)

    plot(MeanSimValuesPostTrain.t,exNeuMean.E.I_syne,'b')
    hold on
    plot(MeanSimValuesPostTrain.t,exNeuMean.E.I_syni,'r')
    hold on
    plot(MeanSimValuesPostTrain.t,exNeuMean.E.I,'k')
    xlim([9800 10000]);
    %legend('Excitatory','Inhibitory')
    xlabel('Time (ms)');ylabel('Synaptic Current');title('Example Excitatory cell Cell')

subplot(4,3,4)

    plot(currxPost.tlags,currxPost.meanE,'b','linewidth',1)
    hold on
    %plot(condxPost.tlags,condxPost.meanE,'b--','linewidth',1)
    plot(currxPost.tlags,currxPost.meanI,'r','linewidth',1)
    %plot(condxPost.tlags,condxPost.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lagsPost([1 end]),[0 0],'k')
    xlim([-50 50])
    %legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')
    
subplot(4,3,5)

    plot(currxScrambled.tlags,currxScrambled.meanE,'b','linewidth',1)
    hold on
    %plot(condxScrambled.tlags,condxScrambled.meanE,'b--','linewidth',1)
    plot(currxScrambled.tlags,currxScrambled.meanI,'r','linewidth',1)
    %plot(condxScrambled.tlags,condxScrambled.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lagsScrambled([1 end]),[0 0],'k')
    xlim([-50 50])
    %legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')
    
subplot(4,3,6)

    plot(currxMean.tlags,currxMean.meanE,'b','linewidth',1)
    hold on
    %plot(condxMean.tlags,condxMean.meanE,'b--','linewidth',1)
    plot(currxMean.tlags,currxMean.meanI,'r','linewidth',1)
    %plot(condxMean.tlags,condxMean.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lagsMean([1 end]),[0 0],'k')
    xlim([-50 50])
    %legend('Curr.->E','Curr.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')

figname = 'Inputs';
NiceSave(figname,figfolder,[])

%%

close all

figure

% Post Trained
subplot(4,3,1)
    
    plot(SimValuesPostTrain.spikes(:,1),SimValuesPostTrain.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[1000 1000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');


% Scrambled Trained
subplot(4,3,2)
    
    plot(ScrambledSimValuesPostTrain.spikes(:,1),ScrambledSimValuesPostTrain.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[1000 1000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
    

    
% Scrambled Trained
subplot(4,3,3)
    
    plot(MeanSimValuesPostTrain.spikes(:,1),MeanSimValuesPostTrain.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[1000 1000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
    

    
figname = 'AllRasterWeights';
NiceSave(figname,figfolder,[])