function [sol,isi] = ISI_GreensFunction(mu,sigma,gamma)
%Input Noise
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 1;

%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-55 -55];    %reset potential (mV)
PopParams.t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -70;    %rev potential: I (mV)
PopParams.b_s     = [0.5 0.5];      %synaptic decay timescale (1/ms)
PopParams.a       = 0.3;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
K = 150;
PopParams.Kee   = K;        %Expected E->E In Degree
PopParams.Kii   = K;        %Expected I->I In Degree
PopParams.Kie   = K;        %Expected E->I In Degree
PopParams.Kei   = K;        %Expected I->E In Degree

PopParams.Wee   = 0;        
PopParams.Wii   = 0;
PopParams.Wie   = 0;
PopParams.Wei   = 0;

%PopParams.p0spike = 0;
PopParams.V0    = PopParams.V_reset(1);

%%
%--------------------------------------------------------------------------
%Simulation Parameters
%LIF Parameters
E_L         = PopParams.E_L;      %Reversal potential (mV)
g_L         = PopParams.g_L;     %conductance (units?)
C           = PopParams.C;       %capacitance (nF)
V_th        = PopParams.V_th;    %spike threshhold (mV)
V_reset     = PopParams.V_reset; %reset value (mV)

t_ref       = PopParams.t_ref;   %refractory period (ms)
theta       = PopParams.theta;   %Strength to mean (time scale of noise, ms^-1)

%--------------------------------------------------------------------------
%Adaptation
E_w         = PopParams.E_w;     %Adaptation reversal potential, (mV)
b_w         = PopParams.b_w;     %Adaptation decay (1/ms)

delta_T     = PopParams.delta_T; %threshhold softness

gwnorm      = PopParams.gwnorm;  %Adaptation norm (nS)
w_r         = PopParams.w_r;     %Adaptation at rest (E_L)

b           = PopParams.b;       %Spike Adaptation (nS)

%--------------------------------------------------------------------------
% Synapse Parameters
E_e         = PopParams.E_e;     %Excitatory reversal potential (mV)
E_i         = PopParams.E_i;     %Inhibitory reversal potential (mV)

b_s         = PopParams.b_s;     %Synaptic decay (1/ms)
a           = PopParams.a;

%%
%Green's Function

tau_A = C(1)./gamma;

G = @(v,y,t) sqrt(-1./(pi.*(sigma.^2).*(1-exp(2.*t./tau_A)))).*exp(((v - mu - (y - mu).*exp(t./tau_A)).^2)./((sigma.^2).*(1 - exp(2.*t./tau_A))));


%Find solutions
[v,t] = meshgrid(-100:0.1:10,2:0.1:40);

y = V_reset(1);

sol = G(v,V_th(1) - y,t) - G(v,y,t);
isi = G(V_th(1),V_th(1) - y,t) - G(V_th(1),y,t);

%%
%Plot Solutions
figure
plot(t,real(isi))
xlabel('Time (ms)');ylabel('Probability');title('Probability of Spike at time t')
