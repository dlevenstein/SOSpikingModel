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

v_inf = [-55 -55];      %Input Voltage from Population
tau   = C./g_L;         %Cell tau
w     = [0.1;0.3;1;3;10]; %Weight of incoming signal
W     = transpose(logspace(-1,1,25));
G     = [1,3,10];              %Background tau

N     = length(w);
NN    = length(W);

%% Allocated Arrays

vE = zeros(N,T,length(G));
vI = zeros(N,T,length(G));

VE = v_inf(1).*ones(NN,T,length(G));
VI = v_inf(2).*ones(NN,T,length(G));

vE(:,1,:) = v_inf(1).*ones(N,1,length(G));
vI(:,1,:) = v_inf(2).*ones(N,1,length(G));

VE(:,1,:) = v_inf(1).*ones(NN,1,length(G));
VI(:,1,:) = v_inf(2).*ones(NN,1,length(G));

s = exp(-t./tau_s);

%% Loop 
for gg = 1:length(G)
for n = 1:T-1
    
    dvE = - vE(:,n,gg) + v_inf(1) - ((w.*s(n))./(g_L(1).*G(gg))).*(vE(:,n,gg) - E_e);
    dvI = - vI(:,n,gg) + v_inf(2) - ((w.*s(n))./(g_L(2).*G(gg))).*(vI(:,n,gg) - E_i);
        
    vE(:,n+1,gg) = vE(:,n,gg) + dvE.*dt.*(G(gg)./tau(1));
    vI(:,n+1,gg) = vI(:,n,gg) + dvI.*dt.*(G(gg)./tau(2));
    
    dVE = - VE(:,n,gg) + v_inf(1) - ((W.*s(n))./(g_L(1).*G(gg))).*(VE(:,n,gg) - E_e);
    dVI = - VI(:,n,gg) + v_inf(2) - ((W.*s(n))./(g_L(2).*G(gg))).*(VI(:,n,gg) - E_i);
        
    VE(:,n+1,gg) = VE(:,n,gg) + dVE.*dt.*(G(gg)./tau(1));
    VI(:,n+1,gg) = VI(:,n,gg) + dVI.*dt.*(G(gg)./tau(2));
    
end
end

%%

for gg = 1:length(G)
figure
subplot(2,1,1)
plot(t,vE(:,:,gg),'b')
xlim([0 100])
xlabel('Time (ms)','fontsize',20);ylabel('Voltage (mV)','fontsize',20);title('EPSP','fontsize',20)
subplot(2,1,2)
plot(t,vI(:,:,gg),'r')
xlim([0 100])
xlabel('Time (ms)','fontsize',20);ylabel('Voltage (mV)','fontsize',20);title('IPSP','fontsize',20)
NiceSave(['Example_EPSP_IPSP_G_' char(num2str(G(gg)))],'/Users/jonathangornet/Documents/GitHub/SOSpikingModel/Figures',[])
end

%%
VEmax = zeros(N,length(G));
VImin = zeros(NN,length(G));

for gg = 1:length(G)
for ii = 1:NN
    
    VEmax(ii,gg) = max(VE(ii,:,gg)) - v_inf(1);
    VImin(ii,gg) = min(VI(ii,:,gg)) - v_inf(2);
        
end
end

%%
figure
subplot(2,1,1)
plot(log10(W),log10(VEmax(:,1)),'.-','Color',[0.7 0.7 1],'linewidth',2,'markersize',25)
hold on
plot(log10(W),log10(VEmax(:,2)),'.-','Color',[0.3 0.3 1],'linewidth',2,'markersize',25)
hold on
plot(log10(W),log10(VEmax(:,3)),'.-','Color',[0 0 0.5],'linewidth',2,'markersize',25)
LogScale('xy',10)
xlabel('Weight (nS)','fontsize',20);ylabel('Voltage mV','fontsize',20);title('EPSP','fontsize',20)
legend('G: 1','G: 3','G: 10','Location','northwest')
subplot(2,1,2)
plot(log10(W),log10(VImin(:,1)),'.-','Color',[1 0.7 0.7],'linewidth',2,'markersize',25)
hold on
plot(log10(W),log10(VImin(:,2)),'.-','Color',[1 0.3 0.3],'linewidth',2,'markersize',25)
hold on
plot(log10(W),log10(VImin(:,3)),'.-','Color',[0.5 0 0],'linewidth',2,'markersize',25)
legend('G: 1','G: 3','G: 10','Location','southwest')
LogScale('xy',10)
xlabel('Weight (nS)','fontsize',20);ylabel('Voltage mV','fontsize',20);title('IPSP','fontsize',20)

NiceSave('EPSP_IPSP','/Users/jonathangornet/Documents/GitHub/SOSpikingModel/Figures',[])

