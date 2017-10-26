%Conductance-Based Addapting LIF Model, Euler Mayurama   implementation 
%by Jonathan Gornet and DLevenstein
%Last update: 10/13/2017

%INPUTS
%   PopParams       a structure that gives all the parameters of the population
%       .EPopNum	Number of excitatory neurons
%       .IPopNum	Number of inhibitory neurons
%       .E_L     	Reversal potential of the leak current (i.e. Vrest)
%       .g_L     	Conductance of the leak current 
%       .C          Membrane Capacitance
%       .I_e        Input current to the population (constant and same for
%                                                    all cells.... for now)
%       .V_th       Membrane Threshold
%       .V_reset    Reset Potential
%
%       .sigma      Standard deviation of noise
%       .theta      TimeScale of noise
% 
%       .E_e        Reversal potential of excitatory synapses
%       .E_i        Reversal potential of inhibitory synapses
%       .a          Synaptic activation strength
%       .bs         Time of synaptic decay
%       .ds         Time synapses are activated
% 
%       .tau_a      Adaptation time constant
%       .t_ref      Refractory period
%       .delta_T    Adaptation threshold softness
%       .gwnorm     Adaptation normalizer
%       .b          Adaptation activation strength
%       .bw         Time of adaptative decay
%       .dw         Time adaptation is activated
%       .w_r        Adaptation Rest
%
%                   SYNAPTIC WEIGHT (what are the units?)
%       .Wee        E->E synapse weight
%       .Wii        I->I synapse weight
%       .Wie        E->I synapse weight
%       .Wei        I->E synapse weight
%                   CONNECTION PROBABILITY (Expected In-Degree)
%       .Kee        E->E
%       .Kii        I->I
%       .Kie        E->I
%       .Kei        I->E
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
t           = [0:dt:SimTime];       %Time Space
TimeLength  = length(t);    %Time Steps

%--------------------------------------------------------------------------
%Weight Matrices
EE_mat = zeros(PopNum);
II_mat = zeros(PopNum);
IE_mat = zeros(PopNum);
EI_mat = zeros(PopNum);

Ecells = 1:EPopNum;             EcellIDX = ismember(1:PopNum,Ecells);
Icells = EPopNum+1:PopNum;      IcellIDX = ismember(1:PopNum,Icells);

%Here we assign four 2x2 matrices of matrix (tensor?). There are positive values on the locations where there are connections.
%For example, there are values for the EE connections on the 1x1 matrix, II
%on the 2x2 matrix, and etc (this is based on the indexing of the neuron population). 

%NOTE: I have adjusted this be such that presynaptic neurons are columns and
%postsynaptic neurons are rows.

Wee = PopParams.Wee;
Kee = PopParams.Kee;
Pee = Kee./PopNum;

EE_mat(Ecells,Ecells) = rand(EPopNum)<=Pee;
EE_mat = EE_mat.*Wee;
EE_mat(diag(diag(true(size(EE_mat)))))=0; %Remove selfconnections

Wii = PopParams.Wii;
Kii = PopParams.Kii;
Pii = Kii./PopNum;

II_mat(Icells,Icells) = rand(IPopNum)<=Pii;
II_mat = II_mat.*Wii;
II_mat(diag(diag(true(size(II_mat)))))=0; %Remove selfconnections

Wie = PopParams.Wie;
Kie = PopParams.Kie;
Pie = Kie./PopNum;

IE_mat(Icells,Ecells) = rand(IPopNum,EPopNum)<=Pie;
IE_mat = IE_mat.*Wie;
IE_mat(diag(diag(true(size(IE_mat)))))=0; %Remove selfconnections

Wei = PopParams.Wei;
Kei = PopParams.Kei;
Pei = Kei./PopNum;

EI_mat(Ecells,Icells) = rand(EPopNum,IPopNum)<=Pei;
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

sigma       = PopParams.sigma;   %Standard deviation of noise
theta       = PopParams.theta;   %Strength to mean (time scale of noise, ms^-1)

%--------------------------------------------------------------------------
%Adaptation
E_w         = PopParams.E_w;     %Adaptation leakage, (mV)
b_w         = PopParams.b_w;     %Adaptation decay (1/ms)

delta_T     = PopParams.delta_T; %threshhold softness
dw          = PopParams.dw;      %Time adaptation is activated (ms)

gwnorm      = PopParams.gwnorm;  %Adaptation norm (nS)
w_r         = PopParams.w_r;     %Adaptation rest

b           = PopParams.b;       %Spike Adaptation (nS)

%--------------------------------------------------------------------------
%Excitatory Synapse Parameters
E_e         = PopParams.E_e;     %Excitatory reversal potential (mV)

%--------------------------------------------------------------------------
%Inhibitory Synapse Parameters
E_i         = PopParams.E_i;     %Inhibitory reversal potential (mV)

%--------------------------------------------------------------------------
b_s         = PopParams.b_s;     %Synaptic decay (1/ms)
ds          = PopParams.ds;      %Time synapses are activated (ms)

a           = PopParams.a;

%% Input
%--------------------------------------------------------------------------
if isequal(size(I_e),[1 1]);
    I_e = I_e.*ones(PopNum,TimeLength);
end

%% Variables
%--------------------------------------------------------------------------
%Simulation Variables

V            = zeros(PopNum,TimeLength); %Membrane Potential

g_e          = zeros(PopNum,TimeLength); %conductance of synapse 
g_i          = zeros(PopNum,TimeLength); %conductance of synapse 

g_w          = zeros(PopNum,TimeLength); %conductance of adaptation 


a_s          = zeros(PopNum,TimeLength); %synaptic rise (1/ms)
a_w          = zeros(PopNum,TimeLength); %adaptation rise (1/ms)

s            = zeros(PopNum,TimeLength); %synapse 
w            = zeros(PopNum,TimeLength); %adaptation

X_t          = zeros(PopNum,TimeLength); %OU noise
dW_t         = zeros(PopNum,TimeLength); %Stochastic Process


t_r = zeros(PopNum,1);
t_s = zeros(PopNum,1);
t_w = zeros(PopNum,1);

spikes = [];

%--------------------------------------------------------------------------
%Initial Conditions
V0range = [V_reset V_th+10];
V(:,1) =  V_reset + (V_th+10-V_reset).*rand(PopNum,1);

%% EI Parameter Adjustments

if length(E_L) == 2 
E_L         = [E_L(1).*ones(1,EPopNum),     E_L(2).*ones(1,EPopNum)];
end
if length(g_L) == 2 
g_L         = [g_L(1).*ones(1,EPopNum),     g_L(2).*ones(1,EPopNum)];
end
if length(C) == 2 
C           = [C(1).*ones(1,EPopNum),       C(2).*ones(1,EPopNum)];
end
if length(I_e) == 2 
I_e         = [I_e(1).*ones(1,EPopNum),     I_e(2).*ones(1,EPopNum)];
end
if length(V_th) == 2 
V_th        = [V_th(1).*ones(1,EPopNum),    V_th(2).*ones(1,EPopNum)];
end
if length(V_reset) == 2 
V_reset     = [V_reset(1).*ones(1,EPopNum), V_reset(2).*ones(1,EPopNum)];
end
if length(t_ref) == 2 
t_ref       = [t_ref(1).*ones(1,EPopNum),   t_ref(2).*ones(1,EPopNum)];
end
if length(sigma) == 2 
sigma       = [sigma(1).*ones(1,EPopNum),   sigma(2).*ones(1,EPopNum)];
end
if length(theta) == 2 
theta       = [theta(1).*ones(1,EPopNum),   theta(2).*ones(1,EPopNum)];
end

if length(E_w) == 2 
E_w         = [E_w(1).*ones(1,EPopNum),     E_w(2).*ones(1,EPopNum)];
end
if length(b_w) == 2 
b_w         = [b_w(1).*ones(1,EPopNum),     b_w(2).*ones(1,EPopNum)];
end
if length(delta_T) == 2 
delta_T     = [delta_T(1).*ones(1,EPopNum), delta_T(2).*ones(1,EPopNum)];
end
if length(dw) == 2 
dw          = [dw(1).*ones(1,EPopNum),      dw(2).*ones(1,EPopNum)];
end
if length(gwnorm) == 2 
gwnorm      = [gwnorm(1).*ones(1,EPopNum),  gwnorm(2).*ones(1,EPopNum)];
end
if length(w_r) == 2 
w_r         = [w_r(1).*ones(1,EPopNum),     w_r(2).*ones(1,EPopNum)];
end
if length(b) == 2 
b           = [b(1).*ones(1,EPopNum),       b(2).*ones(1,EPopNum)];
end
if length(b_s) == 2 
b_s         = [b_s(1).*ones(1,EPopNum),     b_s(2).*ones(1,EPopNum)];
end
if length(ds) == 2 
ds          = [ds(1).*ones(1,EPopNum),      ds(2).*ones(1,EPopNum)];
end
if length(a) == 2 
a           = [a(1).*ones(1,EPopNum),       a(2).*ones(1,EPopNum)];
end
%%

for n=1:TimeLength-1

%--------------------------------------------------------------------------

X_t(:,n+1) = X_t(:,n) + -theta(:).*X_t(:,n).*dt + sigma(:).*randn(PopNum,1).*sqrt(dt);

V(:,n+1)   = V(:,n) +...
    (-g_L(:).*(V(:,n)-E_L(:))./C(:) -g_w(:,n).*(V(:,n)-E_w(:))./C(:) ...
    -g_e(:,n).*(V(:,n)-E_e)./C(:) -g_i(:,n).*(V(:,n)-E_i)./C(:) + ...
            I_e(:,n)./C(:)).*dt + ...
    X_t(:,n)./C(:);

s(:,n+1)   = s(:,n) + (a_s(:,n).*(1-s(:,n)) - b_s(:).*s(:,n)).*dt;

w(:,n+1)   = w(:,n) + (a_w(:,n).*(1-w(:,n)) - b_w(:).*w(:,n)).*dt;

a_w(:,n+1) = w_r(:).*b_w(:)./(1 - w_r(:)).*exp((V(:,n+1)-V_reset(:))./delta_T(:));

%--------------------------------------------------------------------------

if any(V(:,n) > V_th)

spikeneurons = find(V(:,n+1) > V_th(:));

spikes = [spikes; [t(n).*ones(size(spikeneurons)),spikeneurons]];

%--------------------------------------------------------------------------

if length(t_ref) > 1
t_r(spikeneurons) = t_ref(spikeneurons);
else
t_r(spikeneurons) = t_ref;
end

if length(dw) > 1
t_w(spikeneurons) = dw(spikeneurons);
else
t_w(spikeneurons) = dw;
end

if length(ds) > 1
t_s(spikeneurons) = ds(spikeneurons);
else
t_s(spikeneurons) = ds;    
end

end

%--------------------------------------------------------------------------

if any(t_r > 0)

refractoryneurons = find(t_r > 0);
if length(V_reset) > 1
V(refractoryneurons,n+1) = V_reset(refractoryneurons);
else
V(refractoryneurons,n+1) = V_reset;
end
    
t_r(refractoryneurons) = t_r(refractoryneurons) - dt;

end

if any(t_s > 0)

synneurons = find(t_s > 0);
if length(a) > 1
a_s(synneurons,n+1) = a(synneurons);
else
a_s(synneurons,n+1) = a;
end

t_s(synneurons) = t_s(synneurons) - dt;

end

if any(t_w > 0)

adaptneurons = find(t_w > 0);
if length(b) > 1
a_w(adaptneurons,n+1) = b(adaptneurons);
else
a_w(adaptneurons,n+1) = b;
end

t_w(adaptneurons) = t_w(adaptneurons) - dt;

end

%--------------------------------------------------------------------------

g_w(:,n+1) = EcellIDX'.*gwnorm(:).*w(:,n+1);

g_e(:,n+1) = EE_mat*s(:,n+1);
g_e(:,n+1) = IE_mat*s(:,n+1);

g_i(:,n+1) = II_mat*s(:,n+1);
g_i(:,n+1) = EI_mat*s(:,n+1);

%--------------------------------------------------------------------------

end

%%
%Catch for no spiking in simulation error
if isempty(spikes); spikes = [nan nan]; end

exneuron = randi(PopNum,1);
exspiketimes = spikes(spikes(:,2)==exneuron,1);

SimValues.t               = t;
SimValues.V               = V;
SimValues.g_w             = g_w;
SimValues.g_e             = g_e;
SimValues.g_i             = g_i;
SimValues.s               = s;
SimValues.w               = w;
SimValues.a_w             = a_w;
SimValues.spikes          = spikes;
SimValues.EcellIDX        = EcellIDX;
SimValues.IcellIDX        = Icells;

SimValues.noise           = I_e + X_t;

%% Figure
if SHOWFIG
figure
plot(spikes(:,1),spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
end

end