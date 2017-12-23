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
%
%       .p0spike    (optional) proportion of neurons spiking at t0 (default:0)
%   TimeParams
%       .dt        timestep (ms)
%       .SimTime   total simulation time (ms)
%   'showfig'       (optional) show the figure? (default:true)
%   'showprogress'  (optional) show time counter of progress (default:false)
%   'onsettime'     duration of (removed?) onset time (default: 0ms)
%

%--------------------------------------------------------------------------
function [SimValues] = EMAdLIFfunction(PopParams,TimeParams,varargin)

%--------------------------------------------------------------------------
%Parse optional inputs
p = inputParser;
addParameter(p,'showfig',true,@islogical)
addParameter(p,'showprogress',false,@islogical)
addParameter(p,'onsettime',0,@isnumeric)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;
SHOWPROGRESS = p.Results.showprogress;
onsettime = p.Results.onsettime;

%--------------------------------------------------------------------------
%Simulation Parameters
EPopNum     = PopParams.EPopNum;    %Number of excitatory neurons
IPopNum     = PopParams.IPopNum;    %Number of excitatory neurons

PopNum      = EPopNum + IPopNum;    %Number of all neurons

SimTime     = TimeParams.SimTime;   %Simulation Time (ms)
dt          = TimeParams.dt;        %differential (ms)

%Calculate time vector from time parameters
t           = [-onsettime:dt:SimTime];       %Time Space
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

%NOTE: presynaptic neurons are columns (dim2) and postsynaptic neurons are rows (dim1).

%E->E Synapses
Wee = PopParams.Wee;
Kee = PopParams.Kee;
Pee = Kee./(EPopNum-1); %-1 to account for self-connections (which are then removed)

EE_mat(Ecells,Ecells) = rand(EPopNum)<=Pee;
EE_mat = EE_mat.*Wee;
EE_mat(diag(diag(true(size(EE_mat)))))=0; %Remove selfconnections

%I->I Synapses
Wii = PopParams.Wii;
Kii = PopParams.Kii;
Pii = Kii./(IPopNum-1);

II_mat(Icells,Icells) = rand(IPopNum)<=Pii;
II_mat = II_mat.*Wii;
II_mat(diag(diag(true(size(II_mat)))))=0; %Remove selfconnections

%E->I Synapses
Wie = PopParams.Wie;
Kie = PopParams.Kie;
Pie = Kie./EPopNum;

IE_mat(Icells,Ecells) = rand(IPopNum,EPopNum)<=Pie;
IE_mat = IE_mat.*Wie;

%I->E Synapses
Wei = PopParams.Wei;
Kei = PopParams.Kei;
Pei = Kei./IPopNum;

EI_mat(Ecells,Icells) = rand(EPopNum,IPopNum)<=Pei;
EI_mat = EI_mat.*Wei;

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
if isa(I_e, 'function_handle')
    I_e = I_e(t);
elseif isequal(size(I_e),[1 1])
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

%% EI Parameter Adjustments (ugly. needs cleaning)

if length(E_L) == 2 
E_L         = transpose([E_L(1).*ones(1,EPopNum),     E_L(2).*ones(1,IPopNum)]);
end
if length(g_L) == 2 
g_L         = transpose([g_L(1).*ones(1,EPopNum),     g_L(2).*ones(1,IPopNum)]);
end
if length(C) == 2 
C           = transpose([C(1).*ones(1,EPopNum),       C(2).*ones(1,IPopNum)]);
end
if length(I_e) == 2 
I_e         = transpose([I_e(1).*ones(1,EPopNum),     I_e(2).*ones(1,IPopNum)]);
end
if length(V_th) == 2 
V_th        = transpose([V_th(1).*ones(1,EPopNum),    V_th(2).*ones(1,IPopNum)]);
end
if length(V_reset) == 2 
V_reset     = transpose([V_reset(1).*ones(1,EPopNum), V_reset(2).*ones(1,IPopNum)]);
elseif length(V_reset) == 1
V_reset     = transpose([V_reset.*ones(1,EPopNum), V_reset.*ones(1,IPopNum)]);
end
if length(t_ref) == 2 
t_ref       = transpose([t_ref(1).*ones(1,EPopNum),   t_ref(2).*ones(1,IPopNum)]);
elseif length(t_ref) == 1
t_ref       = transpose([t_ref.*ones(1,EPopNum),   t_ref.*ones(1,IPopNum)]);
end
if length(sigma) == 2 
sigma       = transpose([sigma(1).*ones(1,EPopNum),   sigma(2).*ones(1,IPopNum)]);
end
if length(theta) == 2 
theta       = transpose([theta(1).*ones(1,EPopNum),   theta(2).*ones(1,IPopNum)]);
end

if length(E_w) == 2 
E_w         = transpose([E_w(1).*ones(1,EPopNum),     E_w(2).*ones(1,IPopNum)]);
end
if length(b_w) == 2 
b_w         = transpose([b_w(1).*ones(1,EPopNum),     b_w(2).*ones(1,IPopNum)]);
elseif length(b_w)==1
b_w         = transpose([b_w.*ones(1,EPopNum),     b_w.*ones(1,IPopNum)]);  
end
if length(delta_T) == 2 
delta_T     = transpose([delta_T(1).*ones(1,EPopNum), delta_T(2).*ones(1,IPopNum)]);
elseif length(delta_T) == 1
delta_T     = transpose([delta_T(1).*ones(1,EPopNum), 0.*ones(1,IPopNum)]);
end
if length(dw) == 2 
dw          = transpose([dw(1).*ones(1,EPopNum),      dw(2).*ones(1,IPopNum)]);
elseif length(dw) == 1
dw          = transpose([dw.*ones(1,EPopNum),      dw.*ones(1,IPopNum)]);
end
if length(gwnorm) == 2 
gwnorm      = transpose([gwnorm(1).*ones(1,EPopNum),  gwnorm(2).*ones(1,IPopNum)]);
end
if length(w_r) == 2 
w_r         = transpose([w_r(1).*ones(1,EPopNum),     w_r(2).*ones(1,IPopNum)]);
elseif length(w_r) == 1 
w_r         = transpose([w_r(1).*ones(1,EPopNum),     0.*ones(1,IPopNum)]);
end
if length(b) == 2 
b           = transpose([b(1).*ones(1,EPopNum),       b(2).*ones(1,IPopNum)]);
elseif length(b) == 1
b           = transpose([b.*ones(1,EPopNum),       0.*ones(1,IPopNum)]);
end
if length(b_s) == 2 
b_s         = transpose([b_s(1).*ones(1,EPopNum),     b_s(2).*ones(1,IPopNum)]);
end
if length(ds) == 2 
ds          = transpose([ds(1).*ones(1,EPopNum),      ds(2).*ones(1,IPopNum)]);
elseif length(ds) == 1 
ds          = transpose([ds.*ones(1,EPopNum),      ds.*ones(1,IPopNum)]);
end
if length(a) == 2 
a           = transpose([a(1).*ones(1,EPopNum),       a(2).*ones(1,IPopNum)]);
elseif length(a) == 1
a           = transpose([a.*ones(1,EPopNum),       a.*ones(1,IPopNum)]);
end

%% if no spike adaptation, set to steady state????? or set to alpha(v_th)
b(b==0) = w_r(b==0).*b_w(b==0)./(1 - w_r(b==0)).*exp((V_reset(b==0)-E_L(b==0)).*delta_T(b==0));


%% Initial Conditions - random voltages
%Improvement: set # initial spiking neurons instead of hard coding 
%range: E_L-Vth
if isfield(PopParams,'p0spike') 
    p0spike = PopParams.p0spike;
else
    p0spike = 0.0; %5 chance of initial spiking 
end
V0range = [min(E_L) max(V_th)]; %make this neuron vector
V(:,1) = V0range(1) + (1+p0spike).*diff(V0range).*rand(PopNum,1);

%% Time Loop
for n=1:TimeLength-1
    %% Time Counter
    if SHOWPROGRESS && mod(n,round(TimeLength./10))==0
        display('10% More Done!') %clearly, this needs improvement
    end
    %% Dynamics
    %Noise input
    X_t(:,n+1) = X_t(:,n) + ...
        -theta(:).*X_t(:,n).*dt + sqrt(2.*theta).*sigma(:).*randn(PopNum,1).*sqrt(dt);

    %V - Voltage Equation
    V(:,n+1)   = V(:,n) +...
        (-g_L.*(V(:,n)-E_L)./C -g_w(:,n).*(V(:,n)-E_w)./C ...
        -g_e(:,n).*(V(:,n)-E_e)./C -g_i(:,n).*(V(:,n)-E_i)./C + ...
                I_e(:,n)./C + X_t(:,n)./C).*dt;
    %     if any(isnan(V))  %bug checking with delta_T too high
    %         test
    %     end
    %s - Synaptic Output       
    s(:,n+1)   = s(:,n) + (a_s(:,n).*(1-s(:,n)) - b_s(:).*s(:,n)).*dt;
    %w - Adaptation Variable
    w(:,n+1)   = w(:,n) + (a_w(:,n).*(1-w(:,n)) - b_w(:).*w(:,n)).*dt;
    %a_w - Adaptation rate
    a_w(:,n+1) = w_r(:).*b_w(:)./(1 - w_r(:)).*exp((V(:,n+1)-E_L(:)).*delta_T(:));

    %% Spiking
    if any(V(:,n) > V_th)
        %Find neurons that crossed threshold and record the spiketimes 
        spikeneurons = find(V(:,n+1) > V_th(:));
        spikes = [spikes; [t(n).*ones(size(spikeneurons)),spikeneurons]];

        %Set spiking neurons refractory period 
        %(TO DO: single refractory period)
        t_r(spikeneurons) = t_ref(spikeneurons);
        t_w(spikeneurons) = dw(spikeneurons);
        t_s(spikeneurons) = ds(spikeneurons);
    end

    %%  Refractory period Countdowns (no need for three separate)
    if any(t_r > 0) || any(t_s > 0) || any(t_w > 0)
        %Voltage Refractory Period
        refractoryneurons = t_r > 0;
        V(refractoryneurons,n+1) = V_reset(refractoryneurons);
        t_r(refractoryneurons) = t_r(refractoryneurons) - dt;
        %Synaptic Activation
        synneurons = t_s > 0;
        a_s(synneurons,n+1) = a(synneurons);
        t_s(synneurons) = t_s(synneurons) - dt;
        %Spike Adaptation
        adaptneurons = find(t_w > 0);
        a_w(adaptneurons,n+1) = b(adaptneurons);        
        t_w(adaptneurons) = t_w(adaptneurons) - dt;
    end


    %% Synaptic,Adaptaion Conductances
        g_w(:,n+1) = gwnorm(:).*w(:,n+1); %only E cells adapt

        g_e(:,n+1) = EE_mat*s(:,n+1) + IE_mat*s(:,n+1);
        g_i(:,n+1) = II_mat*s(:,n+1) + EI_mat*s(:,n+1);

end

%%
%Catch for no spiking in simulation error
if isempty(spikes); spikes = [nan nan]; end

for cc = 1:PopNum
    spikesbycell{cc} = spikes(spikes(:,2)==cc,1);
end

SimValues.t               = t;
SimValues.V               = V;
SimValues.g_w             = g_w;
SimValues.g_e             = g_e;
SimValues.g_i             = g_i;
SimValues.s               = s;
SimValues.w               = w;
SimValues.a_w             = a_w;
SimValues.spikes          = spikes;
SimValues.spikesbycell    = spikesbycell;
SimValues.EcellIDX        = Ecells;
SimValues.IcellIDX        = Icells;
SimValues.WeightMat       = EE_mat+II_mat+EI_mat+IE_mat;

SimValues.Input           = I_e + X_t;

%% Figure
if SHOWFIG
    
    
exneuron = randi(PopNum,1);
exspiketimes = spikes(spikes(:,2)==exneuron,1);
    
    
figure
plot(spikes(:,1),spikes(:,2),'k.', 'Markersize' , 0.1)
xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
xlim([-onsettime SimTime])
end

end