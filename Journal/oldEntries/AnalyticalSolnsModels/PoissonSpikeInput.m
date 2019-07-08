%Parameters
w = 1;
tau = 0.01;
R = 1;
K = 500;

%Calculate poisson spike times
T = 5;%s
dt = T./(R.*K)./100;

[ s ] = PoissonRateSpikeBins((R.*K),dt,round(T./dt));


%% Simulation loop
TimeStamps = [dt:dt:T]';
g = zeros(size(TimeStamps));
for tt = 2:length(TimeStamps)
    
    dgdt = -g(tt-1)./tau;
    dg = dgdt.*dt+w.*s(tt);
   
    g(tt) = g(tt-1)+dg;
end
   

%% Anaytical estimations for mean/var
gbar = w.*K.*tau.*R;
gvar = (w^2.*K.*tau.*R)./2;
gsd = sqrt(gvar);

[ghist.counts,ghist.bins] = hist(g(TimeStamps>0.1),20);

%Calculate autocorrelation and fourrier 
%% Figure
figure
subplot(2,1,1)
    plot(TimeStamps,g,'k')
    hold on
    plot([0 T],gbar.*[1 1],'r--')
    plot([0 T],gbar+[1 1].*gsd,'r:')
    plot([0 T],gbar-[1 1].*gsd,'r:')
    xlabel('t (s)');ylabel('g_s(t)')
    
subplot(2,2,3)
    bar(ghist.bins,ghist.counts./sum(ghist.counts))
    hold on
    plot(ghist.bins,Gauss(ghist.bins,gbar,gsd)./sum(Gauss(ghist.bins,gbar,gsd)),'r')
    %legend('Simulated g distribution','Estimated gaussian')
   

