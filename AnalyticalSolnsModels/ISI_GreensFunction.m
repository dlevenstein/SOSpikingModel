function [sol,isi] = ISI_GreensFunction(mu,sigma,gamma)
%This function solves the isi distribution for a leaky integrate and fire
%neuron using the Fokker Planck with drift mu, diffusion sigma, and time
%constant C/gl*gamma

%JGornet and DLevenstein 2018
%%
C           = 182;       %capacitance (nF)
V_th        = -45;    %spike threshhold (mV)
V_reset     = -55; %reset value (mV)
g_L         = 182/18; %leak conductance (nS)

%%
%Green's Function

tau_A = C./(g_L.*gamma);

G = @(v,y,t) sqrt(1./(pi.*sigma.^2.*(1-exp(-2.*t./tau_A)))).*exp((1./sigma.^2).*(-(v - mu - (y - mu).*exp(-t./tau_A)).^2./(1-exp(-2.*t./tau_A))));
%G = @(v,y,t) sqrt(-1./(pi.*(sigma.^2).*(1-exp(2.*t./tau_A)))).*exp(((v - mu - (y - mu).*exp(t./tau_A)).^2)./((sigma.^2).*(1 - exp(2.*t./tau_A))));


%Find solutions
v_plot = -100:0.1:10;
t_plot = 2:0.1:40;
[v,t] = meshgrid(v_plot,t_plot);

y = V_reset;

sol = G(v,y,t)-G(v,V_th(1) - y,t);
isi = G(V_th(1),y,t)-G(V_th(1),V_th(1) - y,t);

%%
%Plot Solutions
figure
subplot(2,1,1)
plot(t_plot,real(isi))
xlabel('Time (ms)');ylabel('Probability');title('Probability of Spike at time t')

subplot(2,1,2)
imagesc(v_plot,t_plot,sol)
axis xy
colorbar
