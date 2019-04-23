%Conductance-Based Adapting LIF Model, Euler Mayurama   implementation 
%with Conductance-based Jump-decay STDP synapses
%by Jonathan Gornet and DLevenstein
%Last update: 4/17/2019

%INPUTS
%   PopParams       a structure that gives all the parameters of the population
%       .EPopNum	Number of excitatory neurons
%       .IPopNum	Number of inhibitory neurons
%       .E_L     	Reversal potential of the leak current (i.e. Vrest)
%       .g_L     	Conductance of the leak current 
%       .C          Membrane Capacitance
%       .I_e        Input current to the population. Can either be a
%                   constant, input to [E I] populations,
%                   or a function I_e(t) that returns input at time t
%                   time t. Add: 
%       .V_th       Membrane Threshold
%       .V_reset    Reset Potential
%
%       .sigma      Standard deviation of noise
%       .theta      TimeScale of noise
% 
%       .E_e        Reversal potential of excitatory synapses
%       .E_i        Reversal potential of inhibitory synapses
%       .tau_s      Time of synaptic decay
% 
%       .tau_a      Adaptation time constant
%       .t_ref      Refractory period
%       .tau_w    Adaptation threshold softness
%       .gwnorm     Adaptation normalizer
%       .b          Adaptation activation strength
%       .bw         Time of adaptative decay
%       .w_r        Adaptation Rest
%
%                   SYNAPTIC WEIGHT (conductance jump: nS?)
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
%   'onsettime'     (optional) duration of (removed?) onset time (default: 0ms)
%   'save_dt'       (optional) dt for the saved output (default: 0.1ms)
%

%--------------------------------------------------------------------------
function [SimValues] = AdLIFfunction_STDP_GPU(PopParams,TimeParams,varargin)
%--------------------------------------------------------------------------
%Parse optional inputs
p = inputParser;
addParameter(p,'showfig',true,@islogical)
addParameter(p,'showprogress',false,@islogical)
addParameter(p,'onsettime',0,@isnumeric)
addParameter(p,'save_dt',0.5,@isnumeric)
addParameter(p,'save_weights',10,@isnumeric)
addParameter(p,'cellout',false,@islogical)
addParameter(p,'recordInterval',[],@isnumeric)
addParameter(p,'useGPU',true,@islogical)
addParameter(p,'train',false,@islogical)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;
SHOWPROGRESS = p.Results.showprogress;
onsettime = p.Results.onsettime;
save_dt = p.Results.save_dt;
save_weights = p.Results.save_weights;
cellout = p.Results.cellout;
recordIntervals = p.Results.recordInterval;
useGPU = p.Results.useGPU;
train = p.Results.train;

recordVALs = createRecorder(recordIntervals,TimeParams);

%% Check if GPU Available
try
    gpuArray();
    if useGPU
        gpuAvail = true;
        disp('code is moving to GPU');
    else
        gpuAvail = false;
        disp('code is moving to CPU');
    end
catch
    gpuAvail = false;
    disp('code is moving to CPU');
end

if train && PopParams.LearningRate > 0
train = true;
disp('Network is training and PLASTIC');
elseif PopParams.LearningRate > 0
train = false;
disp('Network is PLASTIC');
else
train = false;
disp('Network is STATIC');
end

%%
%--------------------------------------------------------------------------
%Simulation Parameters
EPopNum     = PopParams.EPopNum;    %Number of excitatory neurons
IPopNum     = PopParams.IPopNum;    %Number of excitatory neurons

PopNum      = EPopNum + IPopNum;    %Number of all neurons

SimTime     = TimeParams.SimTime;   %Simulation Time (ms)
dt          = TimeParams.dt;        %differential (ms)

%Calculate time vector from time parameters
SimTimeLength  = length([-onsettime:dt:SimTime]);   %Time Steps (simulated)
SaveTimeLength  = length([0:save_dt:SimTime]);      %Time Steps (saved)
WeightSaveLength  = length([0:save_weights:SimTime]);      %Time Steps (saved)

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

if isfield(PopParams,'W')
    %If given a weight matrix, extract the E and I matrices
    EE_mat(EcellIDX,EcellIDX) = PopParams.W(EcellIDX,EcellIDX);
    II_mat(IcellIDX,IcellIDX) = PopParams.W(IcellIDX,IcellIDX);
    IE_mat(IcellIDX,EcellIDX) = PopParams.W(IcellIDX,EcellIDX);
    EI_mat(EcellIDX,IcellIDX) = PopParams.W(EcellIDX,IcellIDX);
else
    
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

end
isconnected = (EE_mat+II_mat+EI_mat+IE_mat)>0;

%--------------------------------------------------------------------------
%Simulation Parameters
%LIF Parameters
E_L         = PopParams.E_L;      %Reversal potential (mV)
g_L         = PopParams.g_L;     %conductance (nS)
C           = PopParams.C;       %capacitance (pF)
I_e         = PopParams.I_e;      %current (nA)
V_th        = PopParams.V_th;    %spike threshhold (mV)
V_reset     = PopParams.V_reset; %reset value (mV)

t_ref       = PopParams.t_ref;   %refractory period (ms)
% t_syn       = PopParams.t_syn;   %refractory period (ms)

sigma       = PopParams.sigma;   %Standard deviation of noise
theta       = PopParams.theta;   %Strength to mean (time scale of noise, ms^-1)

%--------------------------------------------------------------------------
%Adaptation
E_w         = PopParams.E_w;     %Adaptation reversal potential, (mV)

tau_w       = PopParams.tau_w;   %Adaptation Decay

gwnorm      = PopParams.gwnorm;  %Adaptation norm (nS)

a           = PopParams.a;       %Subthreshhold Adaptation (nS)
b           = PopParams.b;       %Spike Adaptation (nS)

%--------------------------------------------------------------------------
% Synapse Parameters
E_e         = PopParams.E_e;     %Excitatory reversal potential (mV)
E_i         = PopParams.E_i;     %Inhibitory reversal potential (mV)

tau_s       = PopParams.tau_s;     %Synaptic decay (ms)

%STDP parameters
LearningRate = PopParams.LearningRate;
TargetRateI   = PopParams.TargetRateI; %Target Rate for Inhibitory cells (units of Hz)
TargetRateE   = PopParams.TargetRateE; %Target Rate for Excitatory cells (units of Hz)
tauSTDP      = PopParams.tauSTDP;    %Time Constant for the STDP curve (Units of ms)

alphaI = 2.*(TargetRateI./1000).*tauSTDP; %Alpha parameter from Vogels eqn5
alphaE = 2.*(TargetRateE./1000).*tauSTDP; %Alpha parameter from Vogels eqn5
%Note target rate is converted to spks/ms

%% Input: convert into function of t
if isa(I_e, 'function_handle')
elseif isequal(size(I_e),[1 1])
    I_e = @(t) I_e;
elseif length(I_e) == 2
    I_e = @(t) transpose([I_e(1).*ones(1,EPopNum),     I_e(2).*ones(1,IPopNum)]);
end

%% Variables

%Simulation Variables
V            = zeros(PopNum,1); %Membrane Potential
g_e          = zeros(PopNum,1); %conductance of synapse 
g_i          = zeros(PopNum,1); %conductance of synapse 
g_w          = zeros(PopNum,1); %conductance of adaptation 
a_w          = zeros(PopNum,1); %adaptation rise (1/ms)
s            = zeros(PopNum,1); %synapse 
w            = zeros(PopNum,1); %adaptation
X_t          = zeros(PopNum,1); %OU noise
t_r = zeros(PopNum,1);
% t_s = -dt.*ones(PopNum,1);

x            = zeros(PopNum,1); %Synaptic trace

%Saved Variables
SimValues.t               = nan(1,SaveTimeLength);
SimValues.V               = nan(PopNum,SaveTimeLength);
SimValues.g_w             = nan(PopNum,SaveTimeLength);
SimValues.g_e             = nan(PopNum,SaveTimeLength);
SimValues.g_i             = nan(PopNum,SaveTimeLength);
SimValues.s               = nan(PopNum,SaveTimeLength);
SimValues.w               = nan(PopNum,SaveTimeLength);
SimValues.x               = nan(PopNum,SaveTimeLength);
SimValues.a_w             = nan(PopNum,SaveTimeLength);
SimValues.Input           = nan(PopNum,SaveTimeLength);
SimValues.t_weight        = nan(1,WeightSaveLength);
SimValues.WeightMat       = nan(PopNum,PopNum,WeightSaveLength);
SimValues.WeightChange    = nan(2,SaveTimeLength);

if train
    SimValues.spikeRate   = zeros(2,SaveTimeLength);
end

if length(recordIntervals) == 0
recordVALs = ones(1,SimTimeLength);
spikes = nan(PopNum.*(SimTime+onsettime).*20,2,'single'); %assume mean rate 20Hz
else
spikes = nan(PopNum.*(round(length(find(recordVALs~=0)).*TimeParams.dt)+onsettime).*20,2,'single'); %assume mean rate 20Hz
end

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
% if length(t_syn) == 2 
% t_syn       = transpose([t_syn(1).*ones(1,EPopNum),   t_syn(2).*ones(1,IPopNum)]);
% elseif length(t_syn) == 1
% t_syn       = transpose([t_syn.*ones(1,EPopNum),   t_syn.*ones(1,IPopNum)]);
% end
if length(sigma) == 2 
sigma       = transpose([sigma(1).*ones(1,EPopNum),   sigma(2).*ones(1,IPopNum)]);
end
if length(theta) == 2 
theta       = transpose([theta(1).*ones(1,EPopNum),   theta(2).*ones(1,IPopNum)]);
end

if length(E_w) == 2 
E_w         = transpose([E_w(1).*ones(1,EPopNum),     E_w(2).*ones(1,IPopNum)]);
end
if length(tau_w) == 2 
tau_w       = transpose([tau_w(1).*ones(1,EPopNum), tau_w(2).*ones(1,IPopNum)]);
elseif length(tau_w) == 1
tau_w       = transpose([tau_w.*ones(1,EPopNum), tau_w.*ones(1,IPopNum)]);
end
if length(gwnorm) == 2 
gwnorm      = transpose([gwnorm(1).*ones(1,EPopNum),  gwnorm(2).*ones(1,IPopNum)]);
end
if length(a) == 2 
a         = transpose([a(1).*ones(1,EPopNum),     a(2).*ones(1,IPopNum)]);
elseif length(a)==1
a         = transpose([a.*ones(1,EPopNum),     a.*ones(1,IPopNum)]);  
end
if length(b) == 2 
b           = transpose([b(1).*ones(1,EPopNum),       b(2).*ones(1,IPopNum)]);
elseif length(b) == 1
b           = transpose([b.*ones(1,EPopNum),       0.*ones(1,IPopNum)]);
end
if length(tau_s) == 2 
tau_s         = transpose([tau_s(1).*ones(1,EPopNum),     tau_s(2).*ones(1,IPopNum)]);
end

%% if no spike adaptation, set to steady state????? or set to alpha(v_th)
%b(b==0) = w_r(b==0).*b_w(b==0)./(1 - w_r(b==0)).*exp((V_reset(b==0)-E_L(b==0)).*tau_w(b==0));

%% If no noise
if sigma==0
    dX = 0;
end

%% Initial Conditions - random voltages
%Improvement?: set # initial spiking neurons instead of hard coding 
%range: E_L-Vth
if isfield(PopParams,'p0spike') 
    p0spike = PopParams.p0spike;
else
    p0spike = 0.0; %chance of initial spiking 
end
if isfield(PopParams,'V0')
    V(:,1) = PopParams.V0;
else
    V0range = [min(E_L) min(V_th)]; %make this neuron vector
    V(:,1) = V0range(1) + (1+p0spike).*diff(V0range).*rand(PopNum,1);
end

%%
if gpuAvail
    %Time Parameters
    dt      = gpuArray(dt);
    
    %Noise Parameters
    theta = gpuArray(theta);
    sigma = gpuArray(sigma);
    
    %Voltage Parameters
    C = gpuArray(C);
    
    g_L = gpuArray(g_L);
    E_L = gpuArray(E_L);
    
    gwnorm = gpuArray(gwnorm);
    E_w = gpuArray(E_w);
    E_e = gpuArray(E_e);
    E_i = gpuArray(E_i);
    
    %Weight Parameters
    EE_mat = gpuArray(EE_mat);
    II_mat = gpuArray(II_mat);
    IE_mat = gpuArray(IE_mat);
    EI_mat = gpuArray(EI_mat);
    
    %Spike Parameters
    V_th = gpuArray(V_th);
    t_r  = gpuArray(t_r);
%     t_s  = gpuArray(t_s);
    V_reset = gpuArray(V_reset);
    
    %Adaptation Parameters
    a = gpuArray(a);
    b = gpuArray(b);
    tau_w = gpuArray(tau_w);
    
    %Plasticity Parameters
    tauSTDP = gpuArray(tauSTDP);
    LearningRate = gpuArray(LearningRate);
    alphaE = gpuArray(alphaE);
    alphaI = gpuArray(alphaI);
    
    %Variables
    X_t = gpuArray(X_t);
    V = gpuArray(V);
    s = gpuArray(s);
    w = gpuArray(w);
    x = gpuArray(x);
    
    g_w = gpuArray(g_w);
    g_e = gpuArray(g_e);
    g_i = gpuArray(g_i);
    
    I_e = gpuArray(I_e(gather(-onsettime:dt:SimTime)));
    if length(I_e) == 1
        I_e = I_e.*ones(length(-onsettime:dt:SimTime),1);
    end
    
    % Random Numbers
    gpurng(0, 'Philox4x32-10');
    
    SimValues.V               = gpuArray(SimValues.V);
    SimValues.g_w             = gpuArray(SimValues.g_w);
    SimValues.g_e             = gpuArray(SimValues.g_e);
    SimValues.g_i             = gpuArray(SimValues.g_i);
    SimValues.s               = gpuArray(SimValues.s);
    SimValues.w               = gpuArray(SimValues.w);
    SimValues.x               = gpuArray(SimValues.x);
    SimValues.a_w             = gpuArray(SimValues.a_w);
    SimValues.Input           = gpuArray(SimValues.Input);
    
    SimValues.t_weight        = gpuArray(SimValues.t_weight);
    SimValues.WeightMat       = gpuArray(SimValues.WeightMat);
    SimValues.WeightChange    = gpuArray(SimValues.WeightChange);
    
    if train
    SimValues.spikeRate       = gpuArray(SimValues.spikeRate);
    end

end

%% Time Loop
savecounter = 1;
weightcounter = 1;
timecounter = -onsettime-gather(dt);
spikecounter = 0;
tic
for tt=1:SimTimeLength
    %% Time Counter
    if SHOWPROGRESS && mod(tt,round(SimTimeLength./10))==0
        disp([num2str(round(100.*tt./SimTimeLength)),'% Done!']) %clearly, this needs improvement
    end
    %% Dynamics: update noise, V,s,w based on values in previous timestep
    
    %Noise input (independent for each neuron... could also be correlated)
    
    if gpuAvail
        if sigma~=0
            dX = -theta.*X_t.*dt + sqrt(2.*theta).*sigma.*gpuArray.randn(PopNum,1).*sqrt(dt);
        end

        %V - Voltage Equation
        dVdt =  (- g_L.*(V-E_L) ...                      %Leak
                 - g_w.*(V-E_w) ...                      %Adaptation
                 - g_e.*(V-E_e) - g_i.*(V-E_i) ...       %Synapses
                 + I_e(tt) + X_t)./C;           %External input
    else
        if sigma~=0
            dX = -theta.*X_t.*dt + sqrt(2.*theta).*sigma.*randn(PopNum,1).*sqrt(dt);
        end

        %V - Voltage Equation
        dVdt =  (- g_L.*(V-E_L) ...                      %Leak
                 - g_w.*(V-E_w) ...                      %Adaptation
                 - g_e.*(V-E_e) - g_i.*(V-E_i) ...       %Synapses
                 + I_e(timecounter) + X_t)./C;           %External input
    end
    
    %s - Synaptic Output 
    dsdt =  - s./tau_s;
    %w - Adaptation Variable
    dwdt =  (- w + a.*(V - E_w))./tau_w;
    %x - Synaptic Trace for STDP
    dxdt =  - x./tauSTDP;
    
    X_t = X_t + dX;
    V   = V + dVdt.*dt;
    s   = s + dsdt.*dt;
    w   = w + dwdt.*dt;
    x   = x + dxdt.*dt;

    timecounter = round(timecounter+gather(dt),4);  %Round to deal with computational error

    %% Spiking
    if any(V > V_th)
        %Find neurons that crossed threshold and record the spiketimes 
        spikeneurons = find(V > V_th);

        numspikers = length(spikeneurons);
        
        if recordVALs(tt)
            spikes(spikecounter+1:spikecounter+numspikers,:) = ...
                [timecounter.*ones(numspikers,1),gather(spikeneurons)];
        end
        
        spikecounter = spikecounter+numspikers;
        
        %Set spiking neurons refractory period and synaptic delay counters
        t_r(spikeneurons) = t_ref(spikeneurons);
%         t_s(spikeneurons) = t_syn(spikeneurons);
        %Jump the adaptation
        w(spikeneurons) = w(spikeneurons) + b(spikeneurons); 
        
        %------------------------------------------------------------------
        
        %Jump the postsynaptic conductance
        s(spikeneurons) = 1; %Do this later... after delay
        %Jump the postsynaptic trace
        x(spikeneurons) = x(spikeneurons) + 1;  %Do this later... after delay
        
        %------------------------------------------------------------------
        
        if LearningRate ~= 0
        %Implement STDP (Vogels 2011 SuppEqn 4/5) I->E only
        %Presynaptic I Cells - adjust synapses postsynaptic to spiking I cells
        %PreIspikes = intersect(spikeneurons,Icells);
        PreIspikes = spikeneurons(spikeneurons > EPopNum);
        II_mat(IcellIDX,PreIspikes) = II_mat(IcellIDX,PreIspikes) + LearningRate.*(x(IcellIDX)-alphaI);
        EI_mat(EcellIDX,PreIspikes) = EI_mat(EcellIDX,PreIspikes) + LearningRate.*(x(EcellIDX)-alphaE);
        %Postsynaptic E cells - adjust synapses presynaptic to spiking E cells
        %PostEspikes = intersect(spikeneurons,Ecells);
        PostEspikes = spikeneurons(spikeneurons <= EPopNum);
        PostIspikes = PreIspikes;
        II_mat(PostIspikes,IcellIDX) = II_mat(PostIspikes,IcellIDX) + LearningRate.*(x(IcellIDX)');
        EI_mat(PostEspikes,IcellIDX) = EI_mat(PostEspikes,IcellIDX) + LearningRate.*(x(IcellIDX)');
        
        II_mat = II_mat.*isconnected; %Keep only connected pairs
        II_mat(II_mat<=0) = 0; %Get rid of any negative synapses...
        %II_mat(II_mat>30) = 30; %Cap at 30 nS
        
        EI_mat = EI_mat.*isconnected; %Keep only connected pairs
        EI_mat(EI_mat<=0) = 0; %Get rid of any negative synapses...
        %EI_mat(EI_mat>30) = 30; %Cap at 30 nS
        end
        
    end

    %%  Refractory period Countdowns
    if any(t_r > 0) %|| any(t_s >= 0)
        refractoryneurons = t_r > 0;
%         delayneurons = t_s >= 0;
        
        %Count down the refractory periods
        t_r(refractoryneurons) = t_r(refractoryneurons) - dt;
%         t_s(delayneurons) = t_s(delayneurons) - dt;
        
        %Hold voltage, synaptic/adaptation rates at spike levels
        V(refractoryneurons) = V_reset(refractoryneurons);
        
        %------------------------------------------------------------------
        
%         activatedsynapses = delayneurons & (t_s < 0);
            
        %Jump the postsynaptic conductance
%         s(activatedsynapses) = 1; %Do this later... after delay
%         %Jump the postsynaptic trace
%         x(activatedsynapses) = x(activatedsynapses) + 1;  %Do this later... after delay
        
        
        %Implement STDP (Vogels 2011 SuppEqn 4/5) I->E only
        %Presynaptic I Cells - adjust synapses postsynaptic to spiking I cells
        %PreIspikes = intersect(spikeneurons,Icells);
%         PreIspikes = activatedsynapses(activatedsynapses > EPopNum);
%         EI_mat(EcellIDX,PreIspikes) = EI_mat(EcellIDX,PreIspikes) + LearningRate.*(x(EcellIDX)-alpha);
        %Postsynaptic E cells - adjust synapses presynaptic to spiking E cells
        %PostEspikes = intersect(spikeneurons,Ecells);
%         PostEspikes = activatedsynapses(activatedsynapses <= EPopNum);
%         EI_mat(PostEspikes,IcellIDX) = EI_mat(PostEspikes,IcellIDX) + LearningRate.*(x(IcellIDX)');
        
%         EI_mat = EI_mat.*isconnected; %Keep only connected pairs
%         EI_mat(EI_mat<=0) = 0; %Get rid of any negative synapses...
        
    end
        
    %% Synaptic,Adaptaion Conductances for the next time step
        g_w = gwnorm.*w;
        g_e = EE_mat*s + IE_mat*s;
        g_i = II_mat*s + EI_mat*s;
        
    %% Add data to the output variables
    %Question: is accessing structure slower than doubles?
    
    if any(V == inf)
        warning('Numerical Error');
    elseif any(isnan(V))
        warning('Numerical Error');
    end
    
    if ~train
    if mod(timecounter,save_dt)==0 && timecounter>=0
        if recordVALs(tt)
            
         SimValues.t(savecounter)                 = timecounter;
         SimValues.V(:,savecounter)               = V;
         SimValues.g_w(:,savecounter)             = g_w;
         SimValues.g_e(:,savecounter)             = g_e;
         SimValues.g_i(:,savecounter)             = g_i;
         SimValues.s(:,savecounter)               = s;
         SimValues.w(:,savecounter)               = w;
         SimValues.x(:,savecounter)               = x;
         SimValues.a_w(:,savecounter)             = a_w;
         if gpuAvail
         SimValues.Input(:,savecounter)           = I_e(tt) + X_t;
         else
         SimValues.Input(:,savecounter)           = I_e(timecounter) + X_t;
         end
         
         savecounter = savecounter+1;
         
        end
    end
    
    %Save the weights (less frequently for space concerns)
    if mod(timecounter,save_weights)==0 && timecounter>=0 
        if recordVALs(tt)
        SimValues.t_weight(weightcounter)            = timecounter;
        SimValues.WeightMat(:,:,weightcounter)       = EE_mat+II_mat+EI_mat+IE_mat;
    	weightcounter = weightcounter+1;
        end
    end
    end
    
    if mod(timecounter,save_dt)==0 && timecounter>=0 && train
        SimValues.t(savecounter)                   = timecounter;
        SimValues.WeightChange(1,savecounter)      = mean(EI_mat(EI_mat>0));
        SimValues.WeightChange(2,savecounter)      = mean(II_mat(II_mat>0));
        
        if exist('spikeneurons','var')
        SimValues.spikeRate(1,savecounter)           = sum(spikeneurons<=EPopNum)./EPopNum.*1e3;
        SimValues.spikeRate(2,savecounter)           = sum(spikeneurons>EPopNum)./IPopNum.*1e3;
        end
        
        savecounter = savecounter+1;
    end
     
    %%Idea: add a catch for silent network or excessive firing network?
end
toc

if train
    SimValues.WeightMat = EE_mat+II_mat+EI_mat+IE_mat;
end

%move back to CPU
if gpuAvail
    
    SimValues.V               = gather(SimValues.V);
    SimValues.g_w             = gather(SimValues.g_w);
    SimValues.g_e             = gather(SimValues.g_e);
    SimValues.g_i             = gather(SimValues.g_i);
    SimValues.s               = gather(SimValues.s);
    SimValues.w               = gather(SimValues.w);
    SimValues.x               = gather(SimValues.x);
    SimValues.a_w             = gather(SimValues.a_w);
    SimValues.Input           = gather(SimValues.Input);

    SimValues.t_weight        = gather(SimValues.t_weight);
    SimValues.WeightMat       = gather(SimValues.WeightMat);
    SimValues.WeightChange    = gather(SimValues.WeightChange);
    SimValues.spikeRate       = gather(SimValues.spikeRate);
    
end
%%
%Catch for no spiking in simulation error
spikes(spikecounter+1:end,:)=[];
if isempty(spikes); spikes = [nan nan]; end

%% Output Structure

%Remove onset time
 spikes(spikes(:,1)<=0,:) = [];

if cellout
    for cc = 1:PopNum %This can go very slow with lots of spikes....
        spikesbycell{cc} = spikes(spikes(:,2)==cc,1);
    end
    SimValues.spikesbycell    = spikesbycell;
end

SimValues.spikes          = spikes;

SimValues.EcellIDX        = Ecells;
SimValues.IcellIDX        = Icells;

%% Figure
if SHOWFIG
 
exneuron = randi(PopNum,1);
exspiketimes = spikes(spikes(:,2)==exneuron,1);

[Espikes,Ispikes] = RasterSorter(SimValues);

poprate.dt = 1;   overlap = 6;   winsize = poprate.dt.*overlap;

[spikemat,t_rate,~] = SpktToSpkmat(SimValues.spikesbycell, [], poprate.dt,overlap);
poprate.E = sum(spikemat(:,SimValues.EcellIDX),2)./(winsize./1000)./length(SimValues.EcellIDX);
poprate.I = sum(spikemat(:,SimValues.IcellIDX),2)./(winsize./1000)./length(SimValues.IcellIDX);

figure
plot(Espikes(:,1),Espikes(:,2),'.b','markersize',1)
hold on
plot(Ispikes(:,1),Ispikes(:,2),'.r','markersize',1)
hold on
plot(t_rate,50.*poprate.E,'b','linewidth',2)
hold on
plot(t_rate,50.*poprate.I,'r','linewidth',2)
hold on
plot([0.8650.*TimeParams.SimTime 0.8700.*TimeParams.SimTime],[500 500],'k','LineWidth',2) 
hold on
text(0.8705.*TimeParams.SimTime, 510,'10 Hz','FontSize',16)

xlabel('Time (ms)');ylabel('Neuron ID');title('Raster Plot');
xlim([-onsettime SimTime]);ylim([0 PopNum+1]);
    
if train
    
    figure
    subplot(2,1,1)
    plot(SimValues.t,SimValues.WeightChange(1,:),'b','LineWidth',2)
    hold on
    plot(SimValues.t,SimValues.WeightChange(2,:),'r','LineWidth',2)
    xlabel('Time (ms)');ylabel('Weight (nS)')
    xlim([0 TimeParams.SimTime])
    legend('I->I','I->E')
    subplot(2,1,2)
    plot(SimValues.t,movmean(SimValues.spikeRate(1,:),25),'b','LineWidth',2)
    hold on
    plot(SimValues.t,movmean(SimValues.spikeRate(2,:),25),'r','LineWidth',2)
    xlabel('Time (ms)');ylabel('Rate (Hz)')
    xlim([0 TimeParams.SimTime])
    legend('Excitatory','Inhibitory')
    
end

end

end
