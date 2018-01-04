function [ output_args ] = GetSpikeStats( SimValues )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Calcualte each cell's spike rate and rate sortings
cellrates = cellfun(@length,SimValues.spikesbycell)./(TimeParams.SimTime./1000);

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,SimValues.EcellIDX,'stable');
sortrate.Ionly = intersect(sortrate.all,SimValues.IcellIDX,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);
%[~,sortrate.rasterE] = sort([sortrate.Eonly nan(size(sortrate.Ionly))]);
%[~,sortrate.rasterI] = sort([nan(size(sortrate.Eonly)) sortrate.Ionly]);

%% Calculate Rate, Vm, S over time
dt = 0.5;   overlap = 4;   winsize = dt.*overlap;
[spikemat,t,~] = SpktToSpkmat(SimValues.spikesbycell, [], dt,overlap);
ratemat.E = sum(spikemat(:,SimValues.EcellIDX),2)./(winsize./1000)./length(SimValues.EcellIDX);
ratemat.I = sum(spikemat(:,SimValues.IcellIDX),2)./(winsize./1000)./length(SimValues.IcellIDX);

vm.bins = linspace(-65,max(SimValues.V(:)),100);
vm.Edist = hist(SimValues.V(SimValues.EcellIDX,:),vm.bins);
vm.Emean = mean(SimValues.V(SimValues.EcellIDX,:),1);
vm.Idist = hist(SimValues.V(SimValues.IcellIDX,:),vm.bins);
vm.Imean = mean(SimValues.V(SimValues.IcellIDX,:),1);

s.bins = linspace(0,1,50);
s.Edist = hist(SimValues.s(SimValues.EcellIDX,:),s.bins);
s.Emean = mean(SimValues.s(SimValues.EcellIDX,:),1);
s.Idist = hist(SimValues.s(SimValues.IcellIDX,:),s.bins);
s.Imean = mean(SimValues.s(SimValues.IcellIDX,:),1);
%%

Ecolormap = makeColorMap([1 1 1],[0 0.5 0]);
Icolormap = makeColorMap([1 1 1],[0.8 0 0]);

figure
subplot(4,1,1)
    imagesc(SimValues.t,s.bins,log10(s.Edist))
    colormap(gca,Ecolormap)
    hold on
    plot(SimValues.t,s.Emean,'k')
    axis xy
    ylim([0 max(SimValues.s(:))])
    ylabel('s_E')
subplot(4,1,2)
    imagesc(SimValues.t,s.bins,log10(s.Idist))
    colormap(gca,Icolormap)
    hold on
    plot(SimValues.t,s.Imean,'k')
    axis xy
    ylim([0 max(SimValues.s(:))])   
    xlabel('t (ms)');ylabel('s_I')
    
subplot(4,1,3)
    imagesc(SimValues.t,vm.bins,(vm.Edist))
    colormap(gca,Ecolormap)
    hold on
    plot(SimValues.t,vm.Emean,'k')
    axis xy
    ylim([min(vm.bins) max(vm.bins)])
    ylabel('V_E')
subplot(4,1,4)
    imagesc(SimValues.t,vm.bins,(vm.Idist))
    colormap(gca,Icolormap)
    hold on
    plot(SimValues.t,vm.Imean,'k')
    axis xy
    ylim([min(vm.bins) max(vm.bins)])   
    xlabel('t (ms)');ylabel('V_I')
    
%% 
figure
    subplot(3,1,1:2)
        plot(SimValues.spikes(:,1),sortrate.raster(SimValues.spikes(:,2)),'k.','markersize',2)
        hold on
        plot(SimValues.t([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        ylim(max(SimValues.IcellIDX).*[0 1])
    subplot(3,1,3)
        plot(t,ratemat.E,'k')
        hold on
        plot(t,ratemat.I,'r')

        

%%
figure
subplot(3,2,1)
hist(log10(cellrates(SimValues.EcellIDX)),20)
xlabel('Firing Rate (Hz)');ylabel('# E Cells')
LogScale('x',10)
subplot(3,2,3)
hist(log10(cellrates(SimValues.IcellIDX)),20)
xlabel('Firing Rate (Hz)');ylabel('# I Cells')
LogScale('x',10)


%% Calculate ISI distirbution, Vm distribution, Spike/Vm Autocorr

ISIdist.bins = linspace(0,3.5,60);
ISIs = cellfun(@diff,SimValues.spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{SimValues.EcellIDX})),ISIdist.bins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{SimValues.IcellIDX})),ISIdist.bins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
ISIdist.all = cat(1,ISIdist.all{:});
ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));

vm.celldist = hist(SimValues.V',vm.bins)';




%%
isicolormap = [1 1 1; makeColorMap([1 1 1],[0.8 0 0])];
figure
    subplot(2,2,1)
        imagesc(ISIdist.bins,[0 max(SimValues.IcellIDX)],log10(ISIdist.all(sortrate.ratetype,:)))
        hold on
        plot(ISIdist.bins([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        LogScale('x',10)
        colorbar
        colormap(isicolormap)
        %caxis([0 1])
        xlabel('ISI (ms)')
        
    subplot(2,2,2)
        imagesc(vm.bins,[0 max(SimValues.IcellIDX)],(vm.celldist(sortrate.ratetype,:)))
        hold on
        plot(vm.bins([1 end]),min(SimValues.IcellIDX).*[1 1],'k')
        colorbar
        colormap(isicolormap)
        %caxis([0 1])
        xlabel('Vm (mV)')
%%
figure
plot(isibins,ISIdist.E,'k')
hold on
plot(isibins,ISIdist.I,'r')
LogScale('x',10)

%%
cellrates(cellrates==0) = 0.1;
figure
subplot(3,2,1)
hist(log10(cellrates(SimValues.EcellIDX)),20)
xlabel('Firing Rate (Hz)');ylabel('# E Cells')
LogScale('x',10)
subplot(3,2,3)
hist(log10(cellrates(SimValues.IcellIDX)),20)
xlabel('Firing Rate (Hz)');ylabel('# I Cells')
LogScale('x',10)
%%


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
    ylabel('Synaptic Conductance')
subplot(3,1,2)
    plot(SimValues.t,exNeu.E.I_syne,'k')
    hold on
    plot(SimValues.t,exNeu.E.I_syni,'r')
    plot(SimValues.t,exNeu.E.I,'k')
    ylabel('Synaptic Currents')
subplot(3,1,3)
    plot(SimValues.t,exNeu.E.V,'k')
    ylabel('Vm')
    xlabel('t (ms)')

    
%%
    
    figure
    plot(SimValues.g_e,SimValues.g_i,'.')
    xlabel('g_e');ylabel('g_i')
    
%% Network

indegree.E = sum(SimValues.WeightMat(:,SimValues.EcellIDX)~=0,2);
indegree.I = sum(SimValues.WeightMat(:,SimValues.IcellIDX)~=0,2);
indegree.EIratio =     indegree.E./indegree.I;

%%
figure
    subplot(2,2,1)
        scatter(indegree.E,indegree.I,2,log10(cellrates))
        hold on
        xlabel('In Degree (E)');ylabel('In Degree (I)')
    subplot(2,2,2)
        plot(log10(indegree.EIratio),log10(cellrates),'.')
end

