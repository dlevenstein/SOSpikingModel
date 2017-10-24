%AdLIF RK4 
%by Jonathan Gornet and DLevenstein
%Last update: 9/8/2017

%INPUTS
%   PopParams       a structure that gives all the parameters of the population
%       .EPopNum	Number of excitatory neurons
%       .IPopNum	Number of inhibitory neurons
%       .E_L     	Reversal potential of the leak current (i.e. Vrest)
%       .g_L     	Conductance of the leak current 
%       .C          Membrane Capacitance
%       .I_e        Input current to the E population
%       .V_th       Membrane Threshold
%       .V_reset    Reset Potential
%       .tau_e      Time constant of excitatory synapses
%       .E_e        Reversal potential of excitatory synapses
%       .tau_i      Time constant of inhibitory synapses
%       .E_i        Reversal potential of inhibitory synapses
%       .adapt      Adaptation current jump
%       .tau_a      Adaptation time constant
%       .t_ref      Refractory period
%       .delta_T    Threshold softness
%
%                   SYNAPTIC WEIGHT (what are the units?)
%       .Wee        E->E synapse weight
%       .Wii        I->I synapse weight
%       .Wie        E->I synapse weight
%       .Wei        I->E synapse weight
%                   CONNECTION PROBABILITY
%       .Pee        E->E
%       .Pii        I->I
%       .Pie        E->I
%       .Pei        I->E
%   TimeParams
%       .dt        timestep (ms)
%       .SimTime   total simulation time (s)
%   'showfig'       (optional) show the figure? (default:true)
%
%--------------------------------------------------------------------------
function [SimValues] = RK2AdLIFfunction(PopParams,TimeParams,varargin)

%--------------------------------------------------------------------------
%Parse optional inputs
p = inputParser;
addParameter(p,'showfig',true,@islogical)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;

%--------------------------------------------------------------------------
%Simulation Parameters
EPopNum     = PopParams.EPopNum;    %Number of excitatory neurons
IPopNum     = PopParams.IPopNum;    %Number of excitatory neurons

PopNum      = EPopNum + IPopNum;    %Number of all neurons

SimTime     = TimeParams.SimTime;   %Simulation Time (ms)
dt          = TimeParams.dt;        %differential (ms)

%Calculate time vector from time parameters
TimeSpace   = [0:dt:SimTime];       %Time Space
TimeLength  = length(TimeSpace);    %Time Steps

%--------------------------------------------------------------------------
%Weight Matrices
EE_mat = zeros(PopNum);
II_mat = zeros(PopNum);
IE_mat = zeros(PopNum);
EI_mat = zeros(PopNum);

Econnect = 1:EPopNum;
Iconnect = EPopNum+1:PopNum;

%Here we assign four 2x2 matrices of matrix (tensor?). There are positive values on the locations where there are connections.
%For example, there are values for the EE connections on the 1x1 matrix, II
%on the 2x2 matrix, and etc (this is based on the indexing of the neuron population). 

%NOTE: I have adjusted this be such that presynaptic neurons are columns and
%postsynaptic neurons are rows.

Wee = PopParams.Wee;
Pee = PopParams.Pee;

EE_mat(Econnect,Econnect) = rand(EPopNum)<=Pee;
EE_mat = EE_mat.*Wee;
EE_mat(diag(diag(true(size(EE_mat)))))=0; %Remove selfconnections

Wii = PopParams.Wii;
Pii = PopParams.Pii;

II_mat(Iconnect,Iconnect) = rand(IPopNum)<=Pii;
II_mat = II_mat.*Wii;
II_mat(diag(diag(true(size(II_mat)))))=0; %Remove selfconnections

Wie = PopParams.Wie;
Pie = PopParams.Pie;

IE_mat(Iconnect,Econnect) = rand(IPopNum,EPopNum)<=Pie;
IE_mat = IE_mat.*Wie;
IE_mat(diag(diag(true(size(IE_mat)))))=0; %Remove selfconnections

Wei = PopParams.Wei;
Pei = PopParams.Pei;

EI_mat(Econnect,Iconnect) = rand(EPopNum,IPopNum)<=Pei;
EI_mat = EI_mat.*Wei;
EI_mat(diag(diag(true(size(EI_mat)))))=0; %Remove selfconnections

%--------------------------------------------------------------------------
%Simulation Parameters
%LIF Parameters
E_L         = PopParams.E_L;      %Reversal potential (mV)
g_L         = PopParams.g_L;     %conductance (units?)
C           = PopParams.C;       %capacitance (nF)
I_e         = PopParams.I_e;      %current (nA)
V_th        = PopParams.V_th;    %spike threshhold (mV)
V_reset     = PopParams.V_reset; %reset value (mV)
t_ref       = PopParams.t_ref;   %refractory period (ms)
delta_T     = PopParams.delta_T; %threshhold softness

xi = PopParams.noise(2).*randn(PopNum, TimeLength) + PopParams.noise(1); %noise

%--------------------------------------------------------------------------
%Excitatory Synapse Parameters
tau_e       = PopParams.tau_e;   %time constance of excitatory synapse (ms)
E_e         = PopParams.E_e;     %Excitatory reversal potential

%--------------------------------------------------------------------------
%Inhibitory Synapse Parameters
tau_i       = PopParams.tau_i;   %time constance of inhibitory synapse (ms)
E_i         = PopParams.E_i;     %Inhibitory reversal potential

%--------------------------------------------------------------------------
%Adaptation
adapt = PopParams.adapt;    %Threshhold adaptation (parameter b)
tau_a = PopParams.tau_a;    %adaptation time constant

%% Variables
%--------------------------------------------------------------------------
%Simulation Variables
v           = zeros(PopNum,TimeLength); %Membrane Potential

a_e         = zeros(PopNum,TimeLength); %a term of alpha synapse
b_e         = zeros(PopNum,TimeLength); %b term of alpha synapse
g_e         = zeros(PopNum,TimeLength); %conductance of synapse 

a_i         = zeros(PopNum,TimeLength); %a term of alpha synapse
b_i         = zeros(PopNum,TimeLength); %b term of alpha synapse 
g_i         = zeros(PopNum,TimeLength); %conductance of synapse 

a           = zeros(PopNum,TimeLength); %adaptation 

tperiod = 10.*ones(PopNum,1);

spikes = [];

%--------------------------------------------------------------------------
%Initial Conditions
V0range = [V_reset V_th+10];
v(:,1) =  randi(V0range,[PopNum,1]);

%%

for n=1:TimeLength-1

%--------------------------------------------------------------------------

a1 = - (a(:,n))./tau_a;

a_e1 = - (a_e(:,n));
b_e1 = - (b_e(:,n)).*tau_e;

a_i1 = - (a_i(:,n));
b_i1 = - (b_i(:,n)).*tau_i;

g_e1 = g_e(:,n) + (a_e1 - b_e1);
g_i1 = g_i(:,n) + (a_i1 - b_i1);

v1 = - g_L.*((v(:,n))-E_L)./C - g_e(:,n).*((v(:,n))-E_e)./C - g_i(:,n).*((v(:,n))-E_i)./C + (I_e + xi(:,n))./C - (a(:,n))./C;

%--------------------------------------------------------------------------

a2 = - (a(:,n) + dt.*a1)./tau_a;

a_e2 = - (a_e(:,n) + dt.*a_e1);
b_e2 = - (b_e(:,n) + dt.*b_e1).*tau_e;

a_i2 = - (a_i(:,n) + dt.*a_i1);
b_i2 = - (b_i(:,n) + dt.*b_i1).*tau_i;

g_e2 = g_e(:,n) + (a_e2 - b_e2);
g_i2 = g_i(:,n) + (a_i2 - b_i2);

v2 = - g_L.*((v(:,n) + dt.*v1)-E_L)./C - g_e1.*((v(:,n) + dt.*v1)-E_e)./C - g_i1.*((v(:,n) + dt.*v1)-E_i)./C + (I_e + xi(:,n))./C - (a(:,n) + a1)./C;

%--------------------------------------------------------------------------

v(:,n+1) = v(:,n) + dt./2.*(v1 + v2);
a(:,n+1) = a(:,n) + dt./2.*(a1 + a2);

a_e(:,n+1) = a_e(:,n) + dt./2.*(a_e1 + a_e2);
b_e(:,n+1) = b_e(:,n) + dt./2.*(b_e1 + b_e2);

a_i(:,n+1) = a_i(:,n) + dt./2.*(a_i1 + a_i2);
b_i(:,n+1) = b_i(:,n) + dt./2.*(b_i1 + b_i2);

g_e(:,n+1) = (a_e(:,n+1) - b_e(:,n+1));
g_i(:,n+1) = (a_i(:,n+1) - b_i(:,n+1));

%--------------------------------------------------------------------------

tperiod = tperiod + dt;

%--------------------------------------------------------------------------

if any(v(:,n) > V_th)
    
spikeneurons = find(v(:,n+1) > V_th);

spikes = [spikes; [TimeSpace(n).*ones(size(spikeneurons)),spikeneurons]];

%--------------------------------------------------------------------------

v(spikeneurons,n+1) = V_reset;

a(spikeneurons,n+1) = a(spikeneurons,n+1) + adapt;

%--------------------------------------------------------------------------

a_e(:,n+1) = a_e(:,n+1) + sum(EE_mat(:,spikeneurons),2);
b_e(:,n+1) = b_e(:,n+1) + sum(EE_mat(:,spikeneurons),2);

a_e(:,n+1) = a_e(:,n+1) + sum(IE_mat(:,spikeneurons),2);
b_e(:,n+1) = b_e(:,n+1) + sum(IE_mat(:,spikeneurons),2);

%--------------------------------------------------------------------------

a_i(:,n+1) = a_i(:,n+1) + sum(II_mat(:,spikeneurons),2);
b_i(:,n+1) = b_i(:,n+1) + sum(II_mat(:,spikeneurons),2);

a_i(:,n+1) = a_i(:,n+1) + sum(EI_mat(:,spikeneurons),2);
b_i(:,n+1) = b_i(:,n+1) + sum(EI_mat(:,spikeneurons),2);

%--------------------------------------------------------------------------

tperiod(spikeneurons) = 0;

%--------------------------------------------------------------------------

end

if any(tperiod <= t_ref)

refractoryneurons = find(tperiod <= t_ref);
v(refractoryneurons,n+1) = E_L;

end

end

%Catch for no spiking in simulation error
if isempty(spikes); spikes = [nan nan]; end

exneuron = randi(PopNum,1);
exspiketimes = spikes(spikes(:,2)==exneuron,1);

SimValues.TimeSpace       = TimeSpace;
SimValues.v               = v;
SimValues.a               = a;
SimValues.g_e             = g_e;
SimValues.g_i             = g_i;
SimValues.spikes          = spikes;

SimValues.noise           = I_e + xi;
%% Figure
if SHOWFIG
figure
plot(spikes(:,1),spikes(:,2),'k.', 'Markersize' , 0.1)
end

end



