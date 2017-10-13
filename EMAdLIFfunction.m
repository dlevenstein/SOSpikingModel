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
function [SimValues] = EMAdLIFfunction(PopParams,TimeParams,varargin)

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
I_e         = PopParams.I_e;%.*ones(PopNum,1);      %current (nA)
V_th        = PopParams.V_th;    %spike threshhold (mV)
V_reset     = PopParams.V_reset; %reset value (mV)

t_ref       = PopParams.t_ref;   %refractory period (ms)
dw          = PopParams.dw;   
ds          = PopParams.ds;   

delta_T     = PopParams.delta_T; %threshhold softness

sigma       = PopParams.noise; %noise

%--------------------------------------------------------------------------
%Adaptation
E_w         = PopParams.E_w;     
b_w         = PopParams.b_w;

%--------------------------------------------------------------------------
%Excitatory Synapse Parameters
E_e         = PopParams.E_e;     %Excitatory reversal potential

%--------------------------------------------------------------------------
%Inhibitory Synapse Parameters
E_i         = PopParams.E_i;     %Inhibitory reversal potential

%--------------------------------------------------------------------------
b_s         = PopParams.b_s;
a           = PopParams.a;
b           = PopParams.b;

%% Variables
%--------------------------------------------------------------------------
%Simulation Variables

V            = zeros(PopNum,TimeLength); %Membrane Potential

g_e          = zeros(PopNum,TimeLength); %conductance of synapse 
g_i          = zeros(PopNum,TimeLength); %conductance of synapse 

g_w          = zeros(PopNum,TimeLength); %conductance of synapse 

a_s          = zeros(PopNum,TimeLength); %adaptation 
a_w          = zeros(PopNum,TimeLength); %adaptation 

s            = zeros(PopNum,TimeLength); %adaptation 
w            = zeros(PopNum,TimeLength);

dW_t         = zeros(PopNum,TimeLength);

t_r = zeros(PopNum,1);
t_s = zeros(PopNum,1);
t_w = zeros(PopNum,1);

spikes = [];

%--------------------------------------------------------------------------
%Initial Conditions
V0range = [V_reset V_th+10];
V(:,1) =  randi(V0range,[PopNum,1]);

%%

for n=1:TimeLength-1

%--------------------------------------------------------------------------

dW_t(:,n) = randn(PopNum,1).*sqrt(dt);

V(:,n+1)   = V(:,n) +...
    (-g_L.*(V(:,n)-E_L)./C  -g_w(:,n).*(V(:,n)-E_w)./C...
    -g_e(:,n).*(V(:,n)-E_e)./C -g_i(:,n).*(V(:,n)-E_i)./C...
                      + I_e./C).*dt...
    + sigma.*dW_t(:,n)./C;

s(:,n+1)   = s(:,n) + (a_s(:,n).*(1-s(:,n)) - b_s.*s(:,n)).*dt;

w(:,n+1)   = w(:,n) + (a_w(:,n).*(1-w(:,n)) - b_w.*w(:,n)).*dt;

a_w(:,n+1) = exp((V(:,n+1)-V_th)./delta_T) + (1./(3.*b_w));

%--------------------------------------------------------------------------

if any(V(:,n) > V_th)

spikeneurons = find(V(:,n+1) > V_th);

spikes = [spikes; [TimeSpace(n).*ones(size(spikeneurons)),spikeneurons]];

%--------------------------------------------------------------------------

t_r(spikeneurons) = t_ref;
t_w(spikeneurons) = dw;
t_s(spikeneurons) = ds;

end

%--------------------------------------------------------------------------

if any(t_r > 0)

refractoryneurons = find(t_r > 0);
V(refractoryneurons,n+1) = E_L;

t_r(refractoryneurons) = t_r(refractoryneurons) - dt;

end

if any(t_s > 0)

synneurons = find(t_s > 0);
a_s(synneurons,n+1) = a;

t_s(synneurons) = t_s(synneurons) - dt;

end

if any(t_w > 0)

adaptneurons = find(t_w > 0);
a_w(adaptneurons,n+1) = b;

t_w(adaptneurons) = t_w(adaptneurons) - dt;

end

%--------------------------------------------------------------------------

g_w(:,n+1) = w(:,n+1);

g_e(:,n+1) = EE_mat*s(:,n+1);
g_e(:,n+1) = IE_mat*s(:,n+1);

g_i(:,n+1) = II_mat*s(:,n+1);
g_i(:,n+1) = EI_mat*s(:,n+1);

%--------------------------------------------------------------------------

end

%Catch for no spiking in simulation error
if isempty(spikes); spikes = [nan nan]; end

exneuron = randi(PopNum,1);
exspiketimes = spikes(spikes(:,2)==exneuron,1);

SimValues.TimeSpace       = TimeSpace;
SimValues.V               = V;
SimValues.g_w             = g_w;
SimValues.g_e             = g_e;
SimValues.g_i             = g_i;
SimValues.s               = s;
SimValues.spikes          = spikes;
SimValues.EcellIDX        = Econnect;
SimValues.IcellIDX         = Iconnect;

SimValues.noise           = I_e + dW_t*sigma;

%% Figure
if SHOWFIG
figure
plot(spikes(:,1),spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
end

end



