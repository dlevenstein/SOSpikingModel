%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures/EIBalance'];

%% Define the Population Parameters to feed the FI Cuve function

PopParams.I_e  = [0 0];       %External input
PopParams.sigma = [0 0];        %niose magnitude: variance
PopParams.theta = 0.1;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 100;
PopParams.IPopNum = 100;

%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-55 -55];    %reset potential (mV)
PopParams.t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.tau_s   = [5 5];      %synaptic decay timescale (1/ms)

%Adaptation Properties (No adaptation)
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 0;        %E->E weight (nS)
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degree

PopParams.LearningRate = 0;
PopParams.TargetRate = 2; %Target E rate 1Hz
PopParams.tauSTDP = 20;

PopParams.V0 = PopParams.V_reset(1);

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

sigma       = PopParams.sigma;   %Standard deviation of noise
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

% b_s         = PopParams.b_s;     %Synaptic decay (1/ms)
% a           = PopParams.a;

%%

PopParams.I_e = 210;
I_e = PopParams.I_e;

dt = 0.05;
tEND = 1000; %One Sec
t = 0:dt:100;

Vexc = -(E_L(1) + I_e./g_L(1) - V_reset(1)).*exp(-t./(C(1)./g_L(1))) + (E_L(1) + I_e./g_L(1));
Vinh = -(E_L(2) + I_e./g_L(2) - V_reset(2)).*exp(-t./(C(2)./g_L(2))) + (E_L(2) + I_e./g_L(2));

ESpikeTime = -(C(1)./g_L(1)).*log((E_L(1) + I_e./g_L(1) - V_th(1))./(E_L(1) + I_e./g_L(1) - V_reset(1)));
ISpikeTime = -(C(2)./g_L(2)).*log((E_L(2) + I_e./g_L(2) - V_th(2))./(E_L(2) + I_e./g_L(2) - V_reset(2)));

%%
TimeParams.dt      = dt;
TimeParams.SimTime = 100;
[SimValues] = AdLIFfunction_STDP(PopParams,TimeParams,...
    'showprogress',false,'onsettime',0,'cellout',false,'showfig',false);

figure
plot(SimValues.t,SimValues.V,'k');
hold on
plot(t,Vexc,'g:','LineWidth',1)
hold on
plot(t,Vinh,'r:','LineWidth',1)
xlabel('Time (ms)');ylabel('Voltage (mV)');title('Voltage at I: 210 pA')

%%

TimeParams.dt      = dt;
TimeParams.SimTime = tEND;

Irange = 0:10:450;

ESimTimes = zeros(1,length(Irange));
ISimTimes = zeros(1,length(Irange));
Etimes   = zeros(1,length(Irange));
Itimes   = zeros(1,length(Irange));

ERate    = zeros(1,length(Irange));
IRate    = zeros(1,length(Irange));

%% Exc cell

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 0;

for I = 1:length(Irange)
PopParams.I_e = Irange(I);
I_e = PopParams.I_e;

ESpikeTime = -(C(1)./g_L(1)).*log((E_L(1) + I_e./g_L(1) - V_th(1))./(E_L(1) + I_e./g_L(1) - V_reset(1)));

Etimes(I) = ESpikeTime;

[SimValues] = AdLIFfunction_STDP(PopParams,TimeParams,...
    'showprogress',false,'onsettime',0,'cellout',false,'showfig',false);

ESimTimes(I) = SimValues.spikes(1);
ERate(I)     = (length(SimValues.spikes(:,1))./tEND).*1000;

end

%% Inh cell

% One neuron
PopParams.EPopNum = 0;
PopParams.IPopNum = 1;

for I = 1:length(Irange)
PopParams.I_e = Irange(I);
I_e = PopParams.I_e;

ISpikeTime = -(C(2)./g_L(2)).*log((E_L(2) + I_e./g_L(2) - V_th(2))./(E_L(2) + I_e./g_L(2) - V_reset(2)));

Itimes(I) = real(ISpikeTime);

[SimValues] = AdLIFfunction_STDP(PopParams,TimeParams,...
    'showprogress',false,'onsettime',0,'cellout',false,'showfig',false);

ISimTimes(I) = SimValues.spikes(1);
IRate(I)     = (length(SimValues.spikes(:,1))./tEND).*1000;

end
%%
figure
plot(Irange,ESimTimes,'k*')
hold on
plot(Irange,ISimTimes,'k*')
hold on
plot(Irange,Etimes,'g.')
hold on
plot(Irange,Itimes,'r.')
xlabel('I (pA)');ylabel('Time');title('Time to First Spike')
legend('Exc Simulation','Inh Simulation','Exc Spike','Inh Spike')

%%
I_e = Irange;

ESpikesPerSec = 1000./(-(C(1)./g_L(1)).*log((E_L(1) + I_e./g_L(1) - V_th(1))./(E_L(1) + I_e./g_L(1) - V_reset(1))) + t_ref);
ISpikesPerSec = 1000./(-(C(2)./g_L(2)).*log((E_L(2) + I_e./g_L(2) - V_th(2))./(E_L(2) + I_e./g_L(2) - V_reset(2))) + t_ref);

figure
plot(Irange,ERate,'k*')
hold on
plot(Irange,IRate,'k*')
hold on
plot(I_e,ESpikesPerSec,'g')
hold on
plot(I_e,ISpikesPerSec,'r')
xlabel('I (pA)');ylabel('SpikeRate');title('SpikeRate')
legend('Exc Simulation','Inh Simulation','Exc Spike','Inh Spike')