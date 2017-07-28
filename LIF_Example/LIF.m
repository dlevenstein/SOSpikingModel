%Simulation Parameters
SimTime     = 1000;
PopNum      = 100;
Iterations  = 1000;

TimeSpace   = linspace(0,SimTime,Iterations);

dt = TimeSpace(2);
%%

%Variables
V       = -65.*ones(PopNum,Iterations);
g_e     = zeros(PopNum,Iterations);
g_i     = zeros(PopNum,Iterations);
a       = zeros(PopNum,Iterations);

%LIF Parameters
I_e     = 1.7;
g       = 0.1;
E_L     = -65;
V_reset = -80;

%Synapse Leak Values
E_e   = 0;
E_i   = -80;

%Time Constants
tau_V       = 1;
tau_a       = 100;
tau_syn     = 10;

%Adaptation
adapt       = 0.005;

%Synaptic Weights
EWeightMat   = 0.1.*rand(PopNum,1);
IWeightMat   = 0.2.*rand(PopNum,1);

%%
%%Simulation
for t=1:Iterations
    
    %LIF equation
    V(:,t+1)        = V(:,t)./tau_V + (-g.*(V(:,t) - E_L) - g_e(:,t).*(V(:,t) - E_e) - g_i(:,t).*(V(:,t) - E_i) - 10.*a(:,t) + I_e).*dt;
    %Excitatory Exponential Synapse
    g_e(:,t+1)      = g_e(:,t)      + -g_e(:,t).*dt;
    %Inhibibitory Exponential Synapse
    g_i(:,t+1)      = g_i(:,t)      + -g_i(:,t).*dt;
    %Adaptation (doesn't work)
    a(:,t+1)        = a(:,t)        + adapt.*(V(:,t)-E_L)-a(:,t).*dt;
    
    %Jump Function
    if V(:,t+1) > -55
        
        V(:,t+1)     = V_reset;
        g_e(:,t+1) = g_e(:,t)  + EWeightMat;
        g_i(:,t+1) = g_i(:,t)  + IWeightMat;
        
    end
    
end

%%
%Figures

figure
plot(linspace(0,SimTime,length(V)),V)
xlabel('Time (ms)');ylabel('Membrane Potential (mV)');title('Membrane Potential of Population')

figure
imagesc(V)
xlabel('Time (ms)');ylabel('Membrane Potential (mV)');title('Heatmap of Population')
colorbar

figure
plot(a)
xlabel('Time (ms)');ylabel('Adaptation (pA)');title('Adaptation of Population')

figure
plot(g_e,'b')
hold on
plot(g_i,'r')
xlabel('Time (ms)');ylabel('Conductance (Ohm/cm^2)^-1');title('Synaptic Conductance of Population')
