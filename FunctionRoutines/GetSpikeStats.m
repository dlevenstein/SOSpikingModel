function [  ] = GetSpikeStats( SimValues,PopParams,timewin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
%   timewin window to show raster (ms)
%% Calcualte each cell's spike rate and rate sortings
cellrates = cellfun(@length,SimValues.spikesbycell)./(SimValues.t(end)./1000);

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,SimValues.EcellIDX,'stable');
sortrate.Ionly = intersect(sortrate.all,SimValues.IcellIDX,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);
%[~,sortrate.rasterE] = sort([sortrate.Eonly nan(size(sortrate.Ionly))]);
%[~,sortrate.rasterI] = sort([nan(size(sortrate.Eonly)) sortrate.Ionly]);

%% Calculate Rate, Vm, S, g, I over time
poprate.dt = 0.5;   overlap = 4;   winsize = poprate.dt.*overlap;
[spikemat,t,~] = SpktToSpkmat(SimValues.spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValues.EcellIDX),2)./(winsize./1000)./length(SimValues.EcellIDX);
poprate.I = sum(spikemat(:,SimValues.IcellIDX),2)./(winsize./1000)./length(SimValues.IcellIDX);

%Membrane Potential (Vm)
vm.bins = linspace(-65,max(SimValues.V(:)),100);
vm.Edist = hist(SimValues.V(SimValues.EcellIDX,:),vm.bins);
vm.Emean = mean(SimValues.V(SimValues.EcellIDX,:),1);
vm.Idist = hist(SimValues.V(SimValues.IcellIDX,:),vm.bins);
vm.Imean = mean(SimValues.V(SimValues.IcellIDX,:),1);

%Synaptic variable (S)
s.bins = linspace(0,1,100);
s.Edist = hist(SimValues.s(SimValues.EcellIDX,:),s.bins);
s.Emean = mean(SimValues.s(SimValues.EcellIDX,:),1);
s.Idist = hist(SimValues.s(SimValues.IcellIDX,:),s.bins);
s.Imean = mean(SimValues.s(SimValues.IcellIDX,:),1);

%Synaptic conductance (g)
g.bins = linspace(0,200,50);
g.EEdist = hist(SimValues.g_e(SimValues.EcellIDX,:),g.bins);
g.EIdist = hist(SimValues.g_i(SimValues.EcellIDX,:),g.bins);
g.IEdist = hist(SimValues.g_e(SimValues.IcellIDX,:),g.bins);
g.IIdist = hist(SimValues.g_i(SimValues.IcellIDX,:),g.bins);

g.EEmean = mean(SimValues.g_e(SimValues.EcellIDX,:),1);
g.EImean = mean(SimValues.g_i(SimValues.EcellIDX,:),1);
g.IEmean = mean(SimValues.g_e(SimValues.IcellIDX,:),1);
g.IImean = mean(SimValues.g_i(SimValues.IcellIDX,:),1);

%Synaptic curents (I_syn)
SimValues.Isyn_e = -SimValues.g_e.*(SimValues.V-PopParams.E_e);
SimValues.Isyn_i = -SimValues.g_i.*(SimValues.V-PopParams.E_i);
SimValues.Isyn_tot = SimValues.Isyn_e+SimValues.Isyn_i;

Isyn.Ebins = linspace(0,5e3,100);
Isyn.Ibins = -fliplr(linspace(0,5e3,100));
Isyn.netbins = linspace(-1000,1000,100);
Isyn.EEdist = hist(SimValues.Isyn_e(SimValues.EcellIDX,:),Isyn.Ebins);
Isyn.EIdist = hist(SimValues.Isyn_i(SimValues.EcellIDX,:),Isyn.Ibins);
Isyn.IEdist = hist(SimValues.Isyn_e(SimValues.IcellIDX,:),Isyn.Ebins);
Isyn.IIdist = hist(SimValues.Isyn_i(SimValues.IcellIDX,:),Isyn.Ibins);
Isyn.Enetdist = hist(SimValues.Isyn_tot(SimValues.EcellIDX,:),Isyn.netbins);
Isyn.Inetdist = hist(SimValues.Isyn_tot(SimValues.IcellIDX,:),Isyn.netbins);

Isyn.EEmean = mean(SimValues.Isyn_e(SimValues.EcellIDX,:),1);
Isyn.EImean = mean(SimValues.Isyn_i(SimValues.EcellIDX,:),1);
Isyn.IEmean = mean(SimValues.Isyn_e(SimValues.IcellIDX,:),1);
Isyn.IImean = mean(SimValues.Isyn_i(SimValues.IcellIDX,:),1);
Isyn.Enetmean = mean(SimValues.Isyn_tot(SimValues.EcellIDX,:),1);
Isyn.Inetmean = mean(SimValues.Isyn_tot(SimValues.IcellIDX,:),1);

%% Figure: Spike Raster and Spike Rate
figure
    subplot(2,1,1)
        plot(SimValues.spikes(:,1),sortrate.raster(SimValues.spikes(:,2)),'k.','markersize',4)
        hold on
        plot(SimValues.t([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        ylim(max(SimValues.IcellIDX).*[0 1]);   xlim(timewin);
        ylabel('Cell (Sorted by rate)')
        
    subplot(6,1,4)
        plot(t,poprate.E,'k','Linewidth',1)
        hold on
        plot(t,poprate.I,'r','Linewidth',1)
        axis tight
           xlim(timewin); 
           xlabel('t (s)');ylabel('Pop. Rate (Spks/cell/s)')
 NiceSave('raster2',pwd,'Balanced')
%% Figure: Synaptic Inputs
Ecolormap = makeColorMap([1 1 1],[0 0.5 0],[0.5 1 0.5]);
Icolormap = makeColorMap([1 1 1],[0.8 0 0],[1 0.5 0.5]);
EIcolormap = [flipud(Icolormap);Ecolormap];
figure
    subplot(3,1,1)
        colormap(gca,EIcolormap)
        imagesc(SimValues.t,Isyn.Ebins,Isyn.EEdist)
        hold on
        imagesc(SimValues.t,Isyn.Ibins,-Isyn.EIdist)
        plot(SimValues.t,Isyn.EEmean,'k')
        plot(SimValues.t,Isyn.EImean,'k')
        caxis(max([Isyn.EEdist(:);Isyn.EIdist(:)]).*[-1 1])
        %colorbar
        axis xy
        xlim(timewin);
        ylim([min(Isyn.Ibins) max(Isyn.Ebins)])
        ylabel('E Cells: I_s_y_n')
        title('Synaptic Current Inputs Distribution')
    subplot(6,1,3)
        colormap(gca,Ecolormap)
        imagesc(SimValues.t,Isyn.netbins,Isyn.Enetdist)
        hold on
        plot(SimValues.t,Isyn.Enetmean,'k')
        plot(timewin,[0 0],'k--')
        axis xy
        xlim(timewin);
        ylim(Isyn.netbins([1 end]))
        ylabel('E Cells: I_s_y_n_,_n_e_t')
        
    subplot(3,1,3)
        colormap(gca,EIcolormap)
        imagesc(SimValues.t,Isyn.Ebins,Isyn.IEdist)
        hold on
        imagesc(SimValues.t,Isyn.Ibins,-Isyn.IIdist)
        plot(SimValues.t,Isyn.IEmean,'k')
        plot(SimValues.t,Isyn.IImean,'k')
        caxis(max([Isyn.IEdist(:);Isyn.IIdist(:)]).*[-1 1])
        %colorbar
        axis xy
        xlim(timewin);
        ylim([min(Isyn.Ibins) max(Isyn.Ebins)])
        ylabel('I Cells: I_s_y_n')
        xlabel('t (s)')
    subplot(6,1,4)
        colormap(gca,Icolormap)
        imagesc(SimValues.t,Isyn.netbins,Isyn.Inetdist)
        hold on
        plot(SimValues.t,Isyn.Inetmean,'k')
        plot(timewin,[0 0],'k--')
        axis xy
        xlim(timewin);
        ylim(Isyn.netbins([1 end]))
        ylabel('I Cells: I_s_y_n_,_n_e_t')
        
        
%% Figure: Synaptic Conductances

figure
subplot(4,1,1)
    imagesc(SimValues.t,g.bins,(g.EEdist))
    colormap(gca,Ecolormap)
    hold on
    plot(SimValues.t,g.EEmean,'k')
    axis xy
    ylim([min(g.bins) max(g.bins)]);   xlim(timewin);
    ylabel('g_E_E')
    title('Synaptic Conductance Distribution')
subplot(4,1,2)
    imagesc(SimValues.t,g.bins,(g.EIdist))
    colormap(gca,Icolormap)
    hold on
    plot(SimValues.t,g.EImean,'k')
    axis xy
    ylim([min(g.bins) max(g.bins)]);   xlim(timewin);
    ylabel('g_E_I')
    
subplot(4,1,3)
    imagesc(SimValues.t,g.bins,(g.IEdist))
    colormap(gca,Ecolormap)
    hold on
    plot(SimValues.t,g.IEmean,'k')
    axis xy
    ylim([min(g.bins) max(g.bins)]);   xlim(timewin);
    ylabel('g_E_E')
subplot(4,1,4)
    imagesc(SimValues.t,g.bins,(g.IIdist))
    colormap(gca,Icolormap)
    hold on
    plot(SimValues.t,g.IImean,'k')
    axis xy
    ylim([min(g.bins) max(g.bins)]);   xlim(timewin);
    ylabel('g_E_I')
    xlabel('t (s)')

%% Figure: Synaptic Variable



figure
subplot(4,1,1)
    imagesc(SimValues.t,s.bins,log10(s.Edist))
    colormap(gca,Ecolormap)
    hold on
    plot(SimValues.t,s.Emean,'k')
    axis xy
    ylim([0 2]);xlim(timewin);
    ylabel('s_E')
    title('Synaptic Variable/Membrane Potential Distributions')
subplot(4,1,2)
    imagesc(SimValues.t,s.bins,log10(s.Idist))
    colormap(gca,Icolormap)
    hold on
    plot(SimValues.t,s.Imean,'k')
    axis xy
    ylim([0 2]);   xlim(timewin);
    xlabel('t (ms)');ylabel('s_I')
    
subplot(4,1,3)
    imagesc(SimValues.t,vm.bins,(vm.Edist))
    colormap(gca,Ecolormap)
    hold on
    plot(SimValues.t,vm.Emean,'k')
    axis xy
    ylim([min(vm.bins) max(vm.bins)]);   xlim(timewin);
    ylabel('V_E')
subplot(4,1,4)
    imagesc(SimValues.t,vm.bins,(vm.Idist))
    colormap(gca,Icolormap)
    hold on
    plot(SimValues.t,vm.Imean,'k')
    axis xy
    ylim([min(vm.bins) max(vm.bins)])   ;   xlim(timewin);
    xlabel('t (ms)');ylabel('V_I')
    


        


%% Calculate ISI distirbution, Vm distribution, Spike/Vm Autocorr

ISIdist.bins = linspace(0,4,60);
ISIs = cellfun(@diff,SimValues.spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{SimValues.EcellIDX})),ISIdist.bins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{SimValues.IcellIDX})),ISIdist.bins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
ISIdist.all = cat(1,ISIdist.all{:});
ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,sum(ISIdist.all,2));

vm.celldist = hist(SimValues.V',vm.bins)';




%% Figure ISI, Vm distributions
isicolormap = [makeColorMap([1 1 1],[0.8 0 0]);makeColorMap([0.8 0 0],[0.2 0 0])];
figure
    subplot(2,2,1)
        imagesc(ISIdist.bins,[0 max(SimValues.IcellIDX)],(ISIdist.allscaled(sortrate.ratetype,:)))
        hold on
        plot(ISIdist.bins([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        LogScale('x',10)
        title('ISI Distribution');
        ylabel('Neuron (sorted by Rate, Type)')
        colorbar
        colormap(isicolormap)
        %caxis([0 1])
        xlabel('ISI (ms)')
        
    subplot(2,2,2)
        imagesc(vm.bins,[0 max(SimValues.IcellIDX)],(vm.celldist(sortrate.ratetype,:)))
        hold on
        plot(vm.bins([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        colorbar
        %colormap(isicolormap)
        %caxis([0 1])
        xlabel('Vm (mV)')
        title('V_m Distribution');

subplot(3,2,5)
hist(log10(cellrates(SimValues.EcellIDX)),20)
xlabel('Firing Rate (Hz)');ylabel('# E Cells')
LogScale('x',10)
subplot(3,2,6)
hist(log10(cellrates(SimValues.IcellIDX)),20)
xlabel('Firing Rate (Hz)');ylabel('# I Cells')
LogScale('x',10)
        
NiceSave('ISIVmdists2',pwd,'Balanced')

%% Figure: Example Cell

Excellidx = {SimValues.EcellIDX(1),SimValues.IcellIDX(1)};
Excelltype = {'E','I'};
for ee = 1:length(Excellidx)
    exNeu.(Excelltype{ee}).I = SimValues.Input(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).V = SimValues.V(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).g_e = SimValues.g_e(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).g_i = SimValues.g_i(Excellidx{ee},:);
    exNeu.(Excelltype{ee}).I_syne = -exNeu.E.g_e.*(exNeu.E.V-PopParams.E_e);
    exNeu.(Excelltype{ee}).I_syni = -exNeu.E.g_i.*(exNeu.E.V-PopParams.E_i);
end


figure
subplot(3,1,1)
    plot(SimValues.t,exNeu.E.g_e,'k')
    hold on
    plot(SimValues.t,exNeu.E.g_i,'r')
    xlim(timewin);
    ylabel('Synaptic Conductance')
    title('Example Excitatory cell Cell')
subplot(3,1,2)
    plot(SimValues.t,exNeu.E.I_syne,'k')
    hold on
    plot(SimValues.t,exNeu.E.I_syni,'r')
    plot(SimValues.t,exNeu.E.I,'k')
    ylabel('Synaptic Currents')
    xlim(timewin);
subplot(3,1,3)
    plot(SimValues.t,exNeu.E.V,'k')
    ylabel('Vm')
    xlabel('t (ms)')
    xlim(timewin);

   
%% Network - in degree, eigenvalues

indegree.E = sum(SimValues.WeightMat(:,SimValues.EcellIDX)~=0,2);
indegree.I = sum(SimValues.WeightMat(:,SimValues.IcellIDX)~=0,2);
indegree.EIratio =     indegree.E./indegree.I;

%% Figure: In Degree and rate (join with rate dist, ISI/Vm dist)
%i.e. population heterogeneity measures
figure
    subplot(2,2,1)
        scatter(indegree.E,indegree.I,2,log10(cellrates))
        hold on
        xlabel('In Degree (E)');ylabel('In Degree (I)')
        title('Network and Cell Rate (color)')
        
    subplot(2,2,2)
        plot((indegree.EIratio(SimValues.EcellIDX)),log10(cellrates(SimValues.EcellIDX)),'k.','markersize',4)
        hold on
        plot((indegree.EIratio(SimValues.IcellIDX)),log10(cellrates(SimValues.IcellIDX)),'r.','markersize',4)
        %LogScale('x',2)
        LogScale('y',10)
        xlabel('E:I In degree Ratio');ylabel('Firing Rate')
         NiceSave('InDegreeRate2',pwd,'Balanced')
%% Calculate pop Synch/Rate distribution, Pop Autocorrelation
%i.e. population dynamic measures
poprate.bins = linspace(0,150,75);
poprate.Edist = hist(poprate.E,poprate.bins);
poprate.Idist = hist(poprate.I,poprate.bins);
poprate.EIdist = hist3([poprate.E,poprate.I],{poprate.bins,poprate.bins});

[poprate.autocorr,poprate.tcorr] = xcorr([poprate.E,poprate.I]);
poprate.tcorr = poprate.tcorr.*poprate.dt;

%%
figure
    subplot(2,2,1)
        plot(log10(poprate.bins),poprate.Edist,'k')
        hold on
        plot(log10(poprate.bins),poprate.Idist,'r')
        LogScale('x',10)
        xlabel('Population Rate (Spks/cell/s)');ylabel('P(time)')
    subplot(2,2,2)
        imagesc((poprate.bins(2:end)),(poprate.bins(2:end)),log10(poprate.EIdist)')
        axis xy
        xlabel('E Pop Rate (Spks/cell/s)');ylabel('I Pop Rate (Spks/cell/s)')
        %LogScale('xy',10)
    subplot(2,2,3)
        plot(poprate.tcorr,poprate.autocorr(:,1),'k')
        hold on
        plot(poprate.tcorr,poprate.autocorr(:,4),'r')
        plot(poprate.tcorr,poprate.autocorr(:,2),'k--')
        xlim([-50 50])



end

