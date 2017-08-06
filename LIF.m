%LIF forward euler simulation
%by Jonathan Gornet
%Last update: 7/31/2017

%need to make into a function

%--------------------------------------------------------------------------
%Simulation Parameters
SimTime     = 500;    %Simulation Time
TimeLength  = 100000; %Time Steps
TimeSpace   = linspace(0,SimTime,TimeLength);  %Time Space
dt          = TimeSpace(2); %differential
PopNum      = 100;    %Population of neurons

%--------------------------------------------------------------------------
%Simulation Variables
V           = zeros(PopNum,TimeLength); %Membrane Potential

a_e         = zeros(PopNum,TimeLength); %a term of alpha synapse
b_e         = zeros(PopNum,TimeLength); %b term of alpha synapse
g_e         = zeros(PopNum,TimeLength); %conductance of synapse

a_i         = zeros(PopNum,TimeLength); %a term of alpha synapse
b_i         = zeros(PopNum,TimeLength); %b term of alpha synapse
g_i         = zeros(PopNum,TimeLength); %conductance of synapse

a           = zeros(PopNum,TimeLength); %adaptation

%--------------------------------------------------------------------------
%Simulation Parameters
%LIF Parameters
E_L         = -65;   %Reversal potential
g_L         = 30.0;  %conductance
C           = 281.0; %capacitance
I_e         = 700;   %current
V_th        = -55;   %spike threshhold
V_spike     = -30;   %spike release
V_reset     = -85;   %reset value

%--------------------------------------------------------------------------
%Excitatory Synapse Parameters
tau_e       = 10;    %time constance of excitatory synapse
E_e         = 0;     %Excitatory reversal potential

%--------------------------------------------------------------------------
%Inhibitory Synapse Parameters
tau_i       = 10;    %time constance of inhibitory synapse
E_i         = -80;   %Inhibitory reversal potential

%--------------------------------------------------------------------------
%Weight Matrices
E_mat = randi([0,1000],[PopNum,1]);  %Excitatory Weights, needs work
I_mat = randi([0,1000],[PopNum,1]);  %Inhibitory Weights, needs work

%--------------------------------------------------------------------------
%Adaptation
adapt = 1000.*ones(PopNum,1);    %Threshhold adaptation
tau_a = 50;                      %adaptation time constant

%--------------------------------------------------------------------------
%Initial Conditions
V0range = [V_reset V_spike];
V(:,1) =  randi(V0range,[PopNum,1]);
%%

for t=1:TimeLength

%forward euler method 

%differential   prior value    LIF Equation                   excitatory synapse           inhibitory synapse            adaptation   current
V(:,t+1)        = V(:,t)        + (-g_L.*(V(:,t) - E_L)./C   + -g_e(:,t).*(V(:,t)-E_e)./C  + -g_i(:,t).*(V(:,t)-E_i)./C + -a(:,t)./C + I_e./C).*dt;

%--------------------------------------------------------------------------

%alpha synapses, excitatory
a_e(:,t+1)      = a_e(:,t)      + -a_e(:,t).*dt./tau_e;
b_e(:,t+1)      = b_e(:,t)      + -b_e(:,t).*dt;

%conductance term
g_e(:,t+1)      = (a_e(:,t) - b_e(:,t)).*dt;

%--------------------------------------------------------------------------

%alpha synapses, excitatory
a_i(:,t+1)      = a_i(:,t)      + -a_i(:,t).*dt./tau_i;
b_i(:,t+1)      = b_i(:,t)      + -b_i(:,t).*dt;

%conductance term
g_i(:,t+1)      = (a_i(:,t) - b_i(:,t)).*dt;

%--------------------------------------------------------------------------

%adaptation
a(:,t+1)        = a(:,t)   + -a(:,t).*dt./tau_a;

%--------------------------------------------------------------------------

if V(:,t) > V_th

%V(:,t)     = V_spike;
V(:,t+1)   = V_reset;

%excitory synapse
a_e(:,t+1)  = a_e(:,t+1) + E_mat;
b_e(:,t+1)  = b_e(:,t+1) + E_mat;

%inhibitory synapse
a_i(:,t+1)  = a_i(:,t+1) + I_mat;
b_i(:,t+1)  = b_i(:,t+1) + I_mat;

%adaptation
a(:,t+1)    = a(:,t+1)   + adapt;

end

%--------------------------------------------------------------------------

end

%%
figure
plot(linspace(0,SimTime,TimeLength + 1),V)
xlabel('Time (ms)');ylabel('Membrane Potential (mV)');title('LIF Membrane Potential');

figure
plot(linspace(0,SimTime,TimeLength + 1),g_e,'b')
hold on
plot(linspace(0,SimTime,TimeLength + 1),g_i,'r')
xlabel('Time (ms)');ylabel('Conductance (S/cm^2)?)');title('LIF Conductance');

figure
plot(linspace(0,SimTime,TimeLength + 1),a,'b')
xlabel('Time (ms)');ylabel('Adaptation (pA)');title('LIF Adaptation');