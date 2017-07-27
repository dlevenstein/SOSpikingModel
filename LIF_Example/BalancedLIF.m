%Balanced LIF
%Neuron#/types parameters
N=1000;
Ne=N;
Ni=N;
Ntot = Ne+Ni;

Eidx = 1:Ne;
Iidx = Ne+1:Ne+Ni;


%% Weight matrix parms
p=0.2; %connection prob
K=p*N; %expected # of connections

%1/sqrt(K) scaling for connections and inputs ----------------------
%following van Vreeswijk and Sompolinsky
%(Unscaled) Connection weight parameters
jee=1; %1
jie=2; %2
jei=-3; %3    use 1.25 for epilepsy
jii=-2.5; %2.5

je0=1.2; %1.2  0.15 for spontaneous
ji0=0.7; %0.7    0.0875 for spontaneous

%Scaled synaptic weights
Jee=jee/sqrt(K); 
Jie=jie/sqrt(K); 
Jei=jei/sqrt(K); 
Jii=jii/sqrt(K); 
%Scaled External Drive
Je0=je0*sqrt(K); 
Ji0=ji0*sqrt(K); 
J0 = [Je0.*ones(N,1);Ji0.*ones(N,1)];
%---------------------------

%connection matrices
%E to E
cEE=zeros(Ne);
cEE_t=rand(Ne);
cEE(cEE_t< p)=1;
jcEE=Jee.*cEE;



%E to I
cIE=zeros(Ne);
cIE_t=rand(Ne);
cIE(cIE_t<p)=1;
jcIE = cIE.*Jie;

%I to E
cEI=zeros(Ni);
cEI_t=rand(Ni);
cEI(cEI_t<p)=1;
jcEI = cEI.*Jei;

%I to I
cII=zeros(Ni);
cII_t=rand(Ni);
cII(cII_t<p)=1;
jcII = cII.*Jii;

%W(i,j) is the synaptic weight from presynaptic j onto postsynaptic i
W = [jcEE,jcEI;jcIE,jcII];
c = [cEE,cEI;cIE,cII];

%% Run the simulation
T = 10000;
[S] = LIFnet_run(J0,W,T);

%% Network Visualization

%Pick 100 random E and 100 random I cells
ppick = 0.05;
repE = randsample(Eidx,ppick.*Ne);
repI = randsample(Iidx,ppick.*Ni);

samplemat = abs(W([repE,repI],[repE,repI]));
samplemat = MakeSymmetric(samplemat);
%%
plotxy=Kamada(samplemat,0.01);

%%
cellcolors = (cellrate([repE,repI]));
cellcolors(isinf(cellcolors)) = min(~isinf(cellcolors))-1;
cellcolors= cellcolors+min(cellcolors);
figure
graphplot2D(plotxy,samplemat,2,cellcolors)
colorbar
%% Calculate Weight, Rate Distributions
maxweight = max(abs(W(:)));
numbins = 50;
weightdist.bins = linspace(-maxweight,maxweight,numbins);

[weightdist.EE,weightdist.bins] = hist(jcEE(:),weightdist.bins);
[weightdist.IE,weightdist.bins] = hist(jcIE(:),weightdist.bins);
[weightdist.EI,weightdist.bins] = hist(jcEI(:),weightdist.bins);
[weightdist.II,weightdist.bins] = hist(jcII(:),weightdist.bins);

inweight = sum(W,2);
[Ein,EbyIN] = sort(inweight(1:Ne));
[Iin,IbyIN] = sort(inweight(Ne+1:Ne+Ni));
EIbyIN = [EbyIN;IbyIN+Ne];
[inhist.E,inhist.Ebins] = hist(Ein);
[inhist.I,inhist.Ibins] = hist(Iin);

for cc = 1:Ntot
    numspks(cc) = (sum(S(:,2)==cc));
end
cellrate = numspks./(T./1000);

[~,Ebyrate] = sort(cellrate(Eidx));
[~,Ibyrate] = sort(cellrate(Iidx));
EIbyrate_sort = [Ebyrate,Ibyrate+Ne];
[~,EIbyrate] = sort(EIbyrate_sort);

%% Figure
maxweight = max(abs(W(:)));
weightcolorrange = maxweight.*[-1 1];
weightcolor = [makeColorMap([0.6 0 0],[1 1 1]);0 0 0;...
                makeColorMap([1 1 1],[0 0.6 0])];
Ecolor = [0 0.6 0];
Icolor = [0.6 0 0];
    
figure
subplot(2,2,1)
    colormap(gca,weightcolor)
    imagesc(W)
    colorbar
    caxis(weightcolorrange)
    xlabel('Presynaptic j');ylabel('Postsynaptic i');
    title('Synaptic Weight Matrix: W_i_j')
subplot(6,2,2)
    bar(weightdist.bins,weightdist.EE,'edgecolor',Ecolor+[0 0.2 0],'facecolor','none')
    hold on
    bar(weightdist.bins,weightdist.IE,'edgecolor',Ecolor-[0 0.2 0],'facecolor','none')
    bar(weightdist.bins,weightdist.EI,'edgecolor',Icolor+[0.2 0 0],'facecolor','none')
    bar(weightdist.bins,weightdist.II,'edgecolor',Icolor-[0.2 0 0],'facecolor','none')
    xlabel('Synaptic Weight')
    
subplot(6,2,6)
    bar(inhist.Ebins,inhist.E,'edgecolor',Ecolor,'facecolor','none')
    hold on
    bar(inhist.Ibins,inhist.I,'edgecolor',Icolor,'facecolor','none')
    xlabel('Total Weight of Input Synapses')
subplot(2,1,2)
    plot(S(ismember(S(:,2),Eidx),1),EIbyrate(S(ismember(S(:,2),Eidx),2)),'.','color',Ecolor)
    hold on
    plot(S(ismember(S(:,2),Iidx),1),EIbyrate(S(ismember(S(:,2),Iidx),2)),'.','color',Icolor)
    %plot(S(:,1),(S(:,2)),'k.')
    xlim([1000 4000])
    
    
%% ISI statistics

for cc = 1:Ntot
    cellspks = S(:,2)==cc;
    spktimes{cc} = S(cellspks,1);
end

ISIs = cellfun(@(X) diff(X),spktimes,'Uniformoutput',false);

%ISI histograms
numbins = 40;
ISIhist.lin.bins = linspace(0,1000,numbins);
ISIhist.log.bins = linspace(0,4.5,numbins);
ISIhist.lin.counts = cellfun(@(X) hist(X,ISIhist.lin.bins)./sum(hist(X,ISIhist.lin.bins)),ISIs,'uniformoutput',false);
ISIhist.log.counts = cellfun(@(X) hist(log10(X),ISIhist.log.bins)./sum(hist(log10(X),ISIhist.log.bins)),ISIs,'uniformoutput',false);
ISIhist.lin.counts = cat(1,ISIhist.lin.counts{:});
ISIhist.log.counts = cat(1,ISIhist.log.counts{:});

%%

figure
colormap('pink')
imagesc(ISIhist.log.bins,[1 Ntot],ISIhist.log.counts(EIbyrate_sort,:))
axis xy
LogScale('x',10)
colorbar
caxis([0 0.25])
xlabel('ISI (ms)');ylabel('Cell, Sorted by Firing Rate (Top: I, Bottom E:)')


%% Weight Eigenvectors

[V,D] = eig(W);

[eigval,primaryeig] = max(real(diag(D)));
primaryvec = V(:,primaryeig);
%%
[~,sortvec] = sort(primaryvec);
%%
figure
plot(real(diag(D)),imag(diag(D)),'.')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% Dimensionality of the dynamics (voltage) %%

%% Run the simulation
T = 5000;
[S_small,V_small] = LIFnet_run(J0,W,T);

%% PCA
[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED] = pca(V_small');

%%
[~,sortpc1] = sort(COEFF(:,1));
[~,spksortpc1] = sort(sortpc1);

%%
figure
subplot(2,2,1)
plot(EXPLAINED)
xlim([0 10])
subplot(2,2,2)
plot(COEFF(:,1))
subplot(2,2,3)
plot(COEFF(:,1),log10(cellrate),'o')

%%
figure
imagesc(V_small(sortpc1,:))
colorbar
%caxis([0 1])
