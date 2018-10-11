%% Time Parameters
dt      = 0.05;
tEND    = 1e3;
t       = 0:dt:tEND;
T       = length(t);

%% Neuron Parameters

%Neuron properties
E_L     = [-65 -67];    %rev potential: leak (mV)
g_L     = [182/18 119/8];     %leak conductance (nS)
C       = [182 119];    %capacitance (pF)
V_th    = [-45 -47];    %spike threshold (mV)
V_reset = [-55 -55];    %reset potential (mV)
t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties
E_e     = 0;      %rev potential: E (mV)
E_i     = -80;    %rev potential: I (mV)
tau_s   = 5;      %synaptic decay timescale (1/ms)

%Adaptation Properties (No adaptation)
E_w     = -70;    %rev potential: adaptation (mV)
b_w     = 0.01;   %adaptation decay timescale (1/ms)
b       = 0;    %adaptation activation rate (1/ms)
delta_T = 0;     %subthreshold adaptation steepness
w_r     = 0.1;     %adaptation at rest (0-1)
gwnorm  = 0;       %magnitude of adaptation


%% Normalized Paramets
N     = 30;

v_inf = [-55 -55];            %Input Voltage from Population
tau   = C./g_L;         %Cell tau
w     = transpose(1:N); %Weight of incoming signal
G     = 3;             %Background tau

%% Allocated Arrays

vE = zeros(N,T);
vI = zeros(N,T);

vE(:,1) = v_inf(1).*ones(N,1);
vI(:,1) = v_inf(2).*ones(N,1);

s = exp(-t./tau_s);

%% Loop 

for n = 1:T-1
    
    dvE = - vE(:,n) + v_inf(1) - w.*s(n).*(vE(:,n) - E_e);
    dvI = - vI(:,n) + v_inf(2) - w.*s(n).*(vI(:,n) - E_i);
        
    vE(:,n+1) = vE(:,n) + dvE.*dt.*(G./tau(1));
    vI(:,n+1) = vI(:,n) + dvI.*dt.*(G./tau(2));
    
end

%%

figure
subplot(2,1,1)
plot(t,vE,'b')
subplot(2,1,2)
plot(t,vI,'r')

%%
vEmax = zeros(N,1);
vImin = zeros(N,1);

for ii = 1:N
    
    vEmax(ii) = max(vE(ii,:));
    vImin(ii) = min(vI(ii,:));
        
end

%%
figure
subplot(2,1,1)
plot(1:N,vEmax,'.b')
xlabel('Weight (nS)');ylabel('Voltage mV');title('EPSP')
subplot(2,1,2)
plot(log10(1:N),vImin,'.r')
xlabel('Weight (nS)');ylabel('Voltage mV');title('IPSP')
NiceSave('EPSP_IPSP','~/Desktop',[])

