function [ exNeu,t_ccg,ccg,currx,condx,t_lags ] = GetPlotValues( SimValues,PopParams,timewin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% DEV
%timewin = [39000 40000];
%%
%% Calcualte each cell's spike rate and rate sortings
cellrates = cellfun(@length,SimValues.spikesbycell)./(SimValues.t(end)./1000);

[~,sortrate.all] =sort(cellrates);
sortrate.Eonly = intersect(sortrate.all,SimValues.EcellIDX,'stable');
sortrate.Ionly = intersect(sortrate.all,SimValues.IcellIDX,'stable');
sortrate.ratetype = [sortrate.Eonly sortrate.Ionly];

[~,sortrate.raster] = sort(sortrate.ratetype);


%% Pop Rate
poprate.dt = 0.5;   overlap = 4;   winsize = poprate.dt.*overlap;
[spikemat,t_rate,~] = SpktToSpkmat(SimValues.spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValues.EcellIDX),2)./(winsize./1000)./length(SimValues.EcellIDX);
poprate.I = sum(spikemat(:,SimValues.IcellIDX),2)./(winsize./1000)./length(SimValues.IcellIDX);

%% Spike statistics

%ISI distirbutions
ISIdist.bins = linspace(0,3.5,50);
ISIs = cellfun(@diff,SimValues.spikesbycell,'uniformoutput',false);
ISIdist.E = hist(log10(cat(1,ISIs{SimValues.EcellIDX})),ISIdist.bins);
ISIdist.E = ISIdist.E./sum(ISIdist.E);
ISIdist.I = hist(log10(cat(1,ISIs{SimValues.IcellIDX})),ISIdist.bins);
ISIdist.I = ISIdist.I./sum(ISIdist.I);

ISIdist.all = cellfun(@(X) hist(log10(X),ISIdist.bins),ISIs,'uniformoutput',false);
ISIdist.all = cat(1,ISIdist.all{:});
ISIdist.allscaled = bsxfun(@(X,Y) X./Y,ISIdist.all,max(ISIdist.all,[],2));


%ISI statistics
ISIstats.mean = cellfun(@mean,ISIs);
ISIstats.std = cellfun(@std,ISIs);
ISIstats.CV = ISIstats.std./ISIstats.mean;

ISIstats.CVdist.bins = linspace(0,3,30);
ISIstats.CVdist.E = hist(ISIstats.CV(SimValues.EcellIDX),ISIstats.CVdist.bins);
ISIstats.CVdist.I = hist(ISIstats.CV(SimValues.IcellIDX),ISIstats.CVdist.bins);

Espikes = cat(1,SimValues.spikesbycell{SimValues.EcellIDX});
Ispikes = cat(1,SimValues.spikesbycell{SimValues.IcellIDX});
[ccg,t_ccg] = CCG({double(Espikes./1000),double(Ispikes./1000)},[],'binSize',0.0001,'duration',0.1,'norm','rate');


%Rate Statistics
binsizes = logspace(-0.5,2,20);
popcorr = zeros(size(binsizes));
for bb = 1:length(binsizes)
    [popmat] = SpktToSpkmat({Espikes,Ispikes}, [], binsizes(bb));
    popcorr(bb) = corr(popmat(:,1),popmat(:,2),'type','spearman');
end
        
%% Conductance/Current Balance

%Current/Conductance correlations
currents.E = SimValues.g_e.*(SimValues.V-PopParams.E_e);
currents.I = SimValues.g_i.*(SimValues.V-PopParams.E_i);

gcorr = corr(SimValues.g_e',SimValues.g_i','type','spearman');
gcorr = diag(gcorr);
currcorr = corr(currents.E',currents.I','type','spearman');
currcorr = diag(currcorr);

corrhist.bins = linspace(-1,1,101);
corrhist.currE = hist(currcorr(SimValues.EcellIDX),corrhist.bins);
corrhist.currI = hist(currcorr(SimValues.IcellIDX),corrhist.bins);
corrhist.gE = hist(gcorr(SimValues.EcellIDX),corrhist.bins);
corrhist.gI = hist(gcorr(SimValues.IcellIDX),corrhist.bins);

[~,sortgcorr] = sort(gcorr);
[~,sortcurrcorr] = sort(currcorr);

% Spike-triggered averages
maxlag = 50;  %ms
maxlag_dt = maxlag./SimValues.t(2);  %convert to dt units
numcells = PopParams.EPopNum+PopParams.IPopNum;
EIcurrx = zeros(2.*maxlag_dt+1,numcells); EIcondx = zeros(2.*maxlag_dt+1,numcells);
currPETH.e = zeros(2.*maxlag_dt+1,numcells);
currPETH.i = zeros(2.*maxlag_dt+1,numcells);
for nn = 1:(PopParams.EPopNum+PopParams.IPopNum)
    [EIcurrx(:,nn),t_lags] = xcov(currents.E(nn,:),currents.I(nn,:),maxlag_dt,'coeff');
    [EIcondx(:,nn),t_lags] = xcov(SimValues.g_e(nn,:),SimValues.g_i(nn,:),maxlag_dt,'coeff'); 
    [currPETH.e(:,nn)] = EventVsContinousCCG(currents.E(nn,:)',SimValues.t',SimValues.spikesbycell{nn},maxlag);
    [currPETH.i(:,nn)] = EventVsContinousCCG(currents.I(nn,:)',SimValues.t',SimValues.spikesbycell{nn},maxlag);
    [currPETH.syn(:,nn)] = EventVsContinousCCG(currents.I(nn,:)'+currents.E(nn,:)',SimValues.t',SimValues.spikesbycell{nn},maxlag);
end

currPETH.tlags=t_lags;
currPETH.meanEE = nanmean(currPETH.e(:,SimValues.EcellIDX),2);
currPETH.meanEI = nanmean(currPETH.i(:,SimValues.EcellIDX),2);
currPETH.meanEsyn = nanmean(currPETH.syn(:,SimValues.EcellIDX),2);
currPETH.meanIE = nanmean(currPETH.e(:,SimValues.IcellIDX),2);
currPETH.meanII = nanmean(currPETH.i(:,SimValues.IcellIDX),2);
currPETH.meanIsyn = nanmean(currPETH.syn(:,SimValues.IcellIDX),2);

currx.tlags = t_lags; condx.tlags = t_lags;
currx.meanE = nanmean(EIcurrx(:,SimValues.EcellIDX),2);
currx.meanI = nanmean(EIcurrx(:,SimValues.IcellIDX),2);
condx.meanE = nanmean(EIcondx(:,SimValues.EcellIDX),2);
condx.meanI = nanmean(EIcondx(:,SimValues.IcellIDX),2);

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


%% Network - in degree, eigenvalues

indegree.E = sum(SimValues.WeightMat(:,SimValues.EcellIDX)~=0,2);
indegree.I = sum(SimValues.WeightMat(:,SimValues.IcellIDX)~=0,2);
indegree.EIratio =     indegree.E./indegree.I;


%% Calculate pop Synch/Rate distribution, Pop Autocorrelation
%i.e. population dynamic measures
poprate.bins = linspace(0,150,75);
poprate.Edist = hist(poprate.E,poprate.bins);
poprate.Idist = hist(poprate.I,poprate.bins);
poprate.EIdist = hist3([poprate.E,poprate.I],{poprate.bins,poprate.bins});

[poprate.autocorr,poprate.tcorr] = xcorr([poprate.E,poprate.I]);
poprate.tcorr = poprate.tcorr.*poprate.dt;

end

