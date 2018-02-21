




%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures/EIBalance'];


%%
synparams.w_e = 400; %synaptic weight (pS?)
synparams.w_i = 200; %synaptic weight (pS?)
synparams.tau_se = 0.01;
synparams.tau_si = 0.01;
synparams.K_e = 500;
synparams.K_i = 500;

rates.R_e = 1;
rates.R_i = 4;
rates.g_h = 0;

cellparams.v_r = -55;
cellparams.v_th = -45;
cellparams.g_L = 182/18;
cellparams.C = 182;


cellparams.E_e = 0;
cellparams.E_i = -70;
cellparams.E_L = -65;
cellparams.E_h = 0;


R_es = logspace(-1,1,10);
R_is = logspace(-1,1,10);

for ee = 1:length(R_es)
    ee
    rates.R_e = R_es(ee);
    for ii = 1:length(R_is)
        ii
        rates.R_i = R_is(ii);
    [ spikestats(ee,ii) ] = NoisyInputSims( cellparams,synparams,rates,'showfig',false );
    
    spkrate(ee,ii) = spikestats(ee,ii).rate;
    ISICV(ee,ii) = spikestats(ee,ii).ISI_CV;
    end
end
    
%% Calculate sub-superthrehsold
D_e = cellparams.E_e - cellparams.v_th;
D_i = cellparams.E_i - cellparams.v_th;
D_L = cellparams.E_L - cellparams.v_th;

A_e = D_e.*synparams.w_e.*synparams.tau_se.*synparams.K_e;
A_i = D_i.*synparams.w_i.*synparams.tau_si.*synparams.K_i;


%%
figure
    subplot(2,2,1)
        imagesc(log10(R_es),log10(R_is),log10(spkrate)')
        hold on
        plot(log10(R_es),log10(A_e.*R_es./A_i - D_L./A_i),'r')
        colorbar
        axis xy
        LogScale('xy',10)
        xlabel('R_e');ylabel('R_i')
    subplot(2,2,2)
        imagesc(log10(R_es),log10(R_is),ISICV')
        hold on
        plot(log10(R_es),log10(A_e.*R_es./A_i - D_L./A_i),'r')
        colorbar
        caxis([0 1.5])
        axis xy
        LogScale('xy',10)
        xlabel('R_e');ylabel('R_i')
        
        
        
%%
synparams.w_e = 400; %synaptic weight (pS?)
synparams.w_i = 200; %synaptic weight (pS?)
synparams.tau_se = 0.01;
synparams.tau_si = 0.01;
synparams.K_e = 500;
synparams.K_i = 500;

rates.R_e = 1;
rates.R_i = 5;
rates.g_h = 0;

cellparams.v_r = -55;
cellparams.v_th = -45;
cellparams.g_L = 182/18;
cellparams.C = 182;


cellparams.E_e = 0;
cellparams.E_i = -70;
cellparams.E_L = -65;
cellparams.E_h = 0;


w_es = linspace(0,2000,21);
w_is = linspace(0,2000,21);

for ee = 1:length(w_es)
    ee
    synparams.w_e = w_es(ee);
    for ii = 1:length(w_is)
        ii
        synparams.w_i = w_is(ii);
    [ spikestats(ee,ii) ] = NoisyInputSims( cellparams,synparams,rates,'showfig',false );
    
    spkrate(ee,ii) = spikestats(ee,ii).rate;
    ISICV(ee,ii) = spikestats(ee,ii).ISI_CV;
    end
end


%% Calculate sub-superthrehsold
B_e = D_e.*synparams.tau_se.*synparams.K_e;
B_i = D_i.*synparams.tau_si.*synparams.K_i;

%% esitmate (interpolate) R = RE line




%%

figure
newmap = [[1 1 1];colormap(gcf)];
colormap(newmap)
    subplot(2,2,1)
        imagesc(w_es,w_is,log10(spkrate)')
        hold on
        plot(w_es,-(w_es.*B_e.*rates.R_e)./(B_i.*rates.R_i) - D_L./(B_i.*rates.R_i),...
            'r','LineWidth',2)
        colorbar
        axis xy
        %LogScale('xy',10)
        xlabel('w_e');ylabel('w_i')
    subplot(2,2,2)
        imagesc(w_es,w_is,ISICV')
        hold on
        plot(w_es,-(w_es.*B_e.*rates.R_e)./(B_i.*rates.R_i) - D_L./(B_i.*rates.R_i),...
            'r','LineWidth',2)
        colorbar
        caxis([0 1.5])
        axis xy
       % LogScale('xy',10)
        xlabel('w_e');ylabel('w_i')