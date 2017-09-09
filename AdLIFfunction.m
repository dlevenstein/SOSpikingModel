%AdLIF forward euler simulation
%by Jonathan Gornet and DLevenstein
%Last update: 8/25/2017

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

%       .Wee        E->E synapse weight
%       .Wii        I->I synapse weight
%       .Wie        E->I synapse weight
%       .Wei        I->E synapse weight
%   TimeParams
%       .dt        timestep (ms)
%       .SimTime   total simulation time (s)
%   'showfig'       (optional) show the figure? (default:true)
%
%--------------------------------------------------------------------------
function [SimValues] = AdLIFfunction(PopParams,TimeParams,varargin)

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
dt          = TimeParams.dt;         %differential (ms)

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
%1/root N scaling a la sompolinsky (may not be appropriate here...)
EE_mat(Econnect,Econnect) = Wee.*ones(EPopNum)./sqrt(PopNum);  
EE_mat(diag(diag(true(size(EE_mat)))))=0; %Remove selfconnections

Wii = PopParams.Wii;   
%1/root N scaling a la sompolinsky (may not be appropriate here...)
II_mat(Iconnect,Iconnect) = Wii.*ones(IPopNum)./sqrt(PopNum);  
II_mat(diag(diag(true(size(II_mat)))))=0; %Remove selfconnections

Wie = PopParams.Wie;
%1/root N scaling a la sompolinsky (may not be appropriate here...)
IE_mat(Iconnect,Econnect) = Wie.*ones(IPopNum,EPopNum)./sqrt(PopNum);  
IE_mat(diag(diag(true(size(IE_mat)))))=0; %Remove selfconnections

Wei = PopParams.Wei;   
%1/root N scaling a la sompolinsky (may not be appropriate here...)
EI_mat(Econnect,Iconnect) = Wei.*ones(EPopNum,IPopNum)./sqrt(PopNum);  
EI_mat(diag(diag(true(size(EI_mat)))))=0; %Remove selfconnections

%--------------------------------------------------------------------------
%Simulation Parameters
%LIF Parameters
E_L         = PopParams.E_L;      %Reversal potential (mV)
g_L         = PopParams.g_L;     %conductance (units?)
C           = PopParams.C;       %capacitance (nF)
I_e         = PopParams.I_e;     %current (nA)
V_th        = PopParams.V_th;    %spike threshhold (mV)
V_reset     = PopParams.V_reset; %reset value (mV)

%--------------------------------------------------------------------------
%Excitatory Synapse Parameters
tau_e       = PopParams.tau_e;   %time constance of excitatory synapse (ms)
E_e         = PopParams.E_e;     %Excitatory reversal potential

%--------------------------------------------------------------------------
%Inhibitory Synapse Parameters
tau_i       = PopParams.tau_i; %time constance of inhibitory synapse (ms)
E_i         = PopParams.E_i;   %Inhibitory reversal potential

%--------------------------------------------------------------------------
%Adaptation
adapt = PopParams.adapt;    %Threshhold adaptation (parameter b)
tau_a = PopParams.tau_a;    %adaptation time constant


%% The Simulation Loop
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

spikes = [];

%--------------------------------------------------------------------------
%Initial Conditions
V0range = [V_reset V_th+10];
V(:,1) =  randi(V0range,[PopNum,1]);


for t=1:TimeLength-1

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

%alpha synapses, inhibitory
a_i(:,t+1)      = a_i(:,t)      + -a_i(:,t).*dt./tau_i;
b_i(:,t+1)      = b_i(:,t)      + -b_i(:,t).*dt;

%conductance term
g_i(:,t+1)      = (a_i(:,t) - b_i(:,t)).*dt;

%--------------------------------------------------------------------------

%adaptation
a(:,t+1)        = a(:,t)   + -a(:,t).*dt./tau_a;

%--------------------------------------------------------------------------

if any(V(:,t) > V_th)  %If any neurons have spiked in the timestep, 
                       %initiate synaptic effects and adjust Vm
    spikeneurons = find(V(:,t) > V_th);
    
    %Record the spike times and neuron identity of spikers
    spikes = [spikes; [TimeSpace(t).*ones(size(spikeneurons)),spikeneurons]];

    %V(:,t)     = V_spike;
    V(spikeneurons,t+1)   = V_reset; %only reset the neurons that spiked

    %excitory synapse - postsynaptic effects
    a_e(:,t+1)  = a_e(:,t+1) + sum(EE_mat(:,spikeneurons),2);
    b_e(:,t+1)  = b_e(:,t+1) + sum(EE_mat(:,spikeneurons),2);

    a_e(:,t+1)  = a_e(:,t+1) + sum(IE_mat(:,spikeneurons),2);
    b_e(:,t+1)  = b_e(:,t+1) + sum(IE_mat(:,spikeneurons),2);

    %inhibitory synapse
    a_i(:,t+1)  = a_i(:,t+1) + sum(II_mat(:,spikeneurons),2);
    b_i(:,t+1)  = b_i(:,t+1) + sum(II_mat(:,spikeneurons),2);

    a_i(:,t+1)  = a_i(:,t+1) + sum(EI_mat(:,spikeneurons),2);
    b_i(:,t+1)  = b_i(:,t+1) + sum(EI_mat(:,spikeneurons),2);

    %adaptation
    a(spikeneurons,t+1)    = a(spikeneurons,t+1)   + adapt;

end

%--------------------------------------------------------------------------

end

%Catch for no spiking in simulation error
if isempty(spikes); spikes = [nan nan]; end

SimValues.TimeSpace       = TimeSpace;
SimValues.V               = V;
SimValues.g_e             = g_e;
SimValues.g_i             = g_i;
SimValues.spikes          = spikes;




%% Figure
if SHOWFIG
figure
plot(spikes(:,1),spikes(:,2),'k.')
end

end



