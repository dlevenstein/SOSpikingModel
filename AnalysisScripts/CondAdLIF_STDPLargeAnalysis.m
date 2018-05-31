%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel';
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel';
%repopath = '/home/jmg1030/SOSpikingModel';
addpath(genpath(repopath))

SAVESIM = true;
%% Pretrain Analysis

load('/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/05-31-2018/Weight_Pre')

%%
figure

subplot(2,2,1)
    
    plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.k','markersize',1)
    hold on
    plot([9800 10000],[2000 2000],'r','linewidth',2)
    xlim([9800 10000]);ylim([0 2500])
    xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');

subplot(2,2,3)

    plot(SimValues.t,exNeu.E.I_syne,'b')
    hold on
    plot(SimValues.t,exNeu.E.I_syni,'r')
    hold on
    plot(SimValues.t,exNeu.E.I,'k')
    xlim([9800 10000]);
    legend('Excitatory','Inhibitory')
    xlabel('Time (ms)');ylabel('Synaptic Conductance');title('Example Excitatory cell Cell')

subplot(4,2,2)
    
    plot(t_ccg*1000,ccg(:,1,1)./length(SimValues.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccg*1000,ccg(:,1,2)./length(SimValues.IcellIDX),'r','linewidth',1)
    legend('Excitatory','Inhibitory')
    xlabel('t lag from E spike (ms)');ylabel('Rate')

subplot(4,2,4)
    
    plot(t_ccg*1000,ccg(:,2,1)./length(SimValues.EcellIDX),'b','linewidth',1)
    hold on
    plot(t_ccg*1000,ccg(:,2,2)./length(SimValues.IcellIDX),'r','linewidth',1)
    legend('Excitatory','Inhibitory')
    xlabel('t lag from I spike (ms)');ylabel('Rate')

subplot(2,2,4)

    plot(currx.tlags,currx.meanE,'b','linewidth',1)
    hold on
    plot(condx.tlags,condx.meanE,'b--','linewidth',1)
    plot(currx.tlags,currx.meanI,'r','linewidth',1)
    plot(condx.tlags,condx.meanI,'r--','linewidth',1)
    plot([0 0],[-1 1],'k:')
    plot(t_lags([1 end]),[0 0],'k')
    legend('Curr.->E','Curr.->I','Cond.->E','Cond.->I')
    xlabel('t lag');ylabel('Mean Input Correlation')