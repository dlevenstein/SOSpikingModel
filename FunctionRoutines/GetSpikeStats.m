function [ output_args ] = GetSpikeStats( SimValues )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%

isibins = linspace(0,3.5,60);
ISIs = cellfun(@diff,SimValues.spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{SimValues.EcellIDX})),isibins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{SimValues.IcellIDX})),isibins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIhist.all = cellfun(@(X) hist(log10(X),isibins)./length(X),ISIs,'uniformoutput',false);
ISIhist.all = cat(1,ISIhist.all{:});
ISIhist.allscaled = bsxfun(@(X,Y) X./Y,ISIhist.all,max(ISIhist.all,[],2));

%%
cellrates = cellfun(@length,SimValues.spikesbycell)./(TimeParams.SimTime./1000);
sortrate.E = sort(cellrates(SimValues.EcellIDX));
sortrate.I = sort(cellrates(SimValues.IcellIDX));
[~,sortrate.all] =sort(cellrates);


%%
figure
imagesc(isibins,[0 2500],ISIhist.allscaled(sortrate.all,:))
LogScale('x',10)
colorbar
caxis([0 1])
xlabel('ISI (ms)')
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

end

