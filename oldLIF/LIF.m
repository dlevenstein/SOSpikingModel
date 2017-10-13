%LIF forward euler simulation
%by Jonathan Gornet and DLevenstein
%Last update: 7/31/2017

%need to make into a function

%--------------------------------------------------------------------------
%Simulation Parameters
PopNum      = 5;    %Number of excitatory neurons
SimTime     = 500;    %Simulation Time (ms)
dt          = 0.1; %differential (ms)
%Calcualte time vector from time parameters
TimeSpace   = [0:dt:SimTime];  %Time Space
TimeLength  = length(TimeSpace); %Time Steps

%--------------------------------------------------------------------------
%Weight Matrices
%for now, uniform weights
Wee = 100;   %Units?
%1/root N scaling a la sompolinsky (may not be appropriate here...)
E_mat = Wee.*ones(PopNum)./sqrt(PopNum);  %Excitatory Weights, needs work
%E_mat(i,j) is the weight of synapse from neuron j to neuron i
E_mat(diag(diag(true(size(E_mat)))))=0; %Remove selfconnections

%I_mat = randi([0,1000],[PopNum,1]);  %Inhibitory Weights, needs work

%--------------------------------------------------------------------------
%Simulation Parameters
%LIF Parameters
E_L         = -65;   %Reversal potential (mV)
g_L         = 30.0;  %conductance (units?)
C           = 281.0; %capacitance (units?)
I_e         = 500;   %current (units?)
V_th        = -55;   %spike threshhold (mV)
V_spike     = -30;   %spike release  (DL: what does this parameter supposed to do?)
V_reset     = -85;   %reset value (mV)

%--------------------------------------------------------------------------
%Excitatory Synapse Parameters
tau_e       = 10;    %time constance of excitatory synapse (ms)
E_e         = 0;     %Excitatory reversal potential

%--------------------------------------------------------------------------
%Inhibitory Synapse Parameters
tau_i       = 10;    %time constance of inhibitory synapse (ms)
E_i         = -80;   %Inhibitory reversal potential

%--------------------------------------------------------------------------
%Adaptation
adapt = 200;    %Threshhold adaptation (parameter b)
tau_a = 50;                      %adaptation time constant


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

if any(V(:,t) > V_th)  %Previous code would have implemented spike only if ALL neurons spiked
    spikeneurons = find(V(:,t) > V_th);
    
    %Record the spike times and neuron identity of spikers
    spikes = [spikes; [TimeSpace(t).*ones(size(spikeneurons)),spikeneurons]];

    %V(:,t)     = V_spike;
    V(spikeneurons,t+1)   = V_reset; %only reset the neurons that spiked

    %excitory synapse - postsynaptic effects
    %DL: Jonathan can you check this implementation? Not quite sure how to
    %think about this in terms of the a/b variables
    a_e(:,t+1)  = a_e(:,t+1) + sum(E_mat(:,spikeneurons),2);
    b_e(:,t+1)  = b_e(:,t+1) + sum(E_mat(:,spikeneurons),2);

    %inhibitory synapse
    %DL: this code was written as if all synapses are BOTH inhibitory AND
    %excitatory... which is not physiologically realistic.
    %See https://en.wikipedia.org/wiki/Dale%27s_principle
    %Removing inhibitory synapses for now, we'll put in an inhibitory
    %population next
%     a_i(:,t+1)  = a_i(:,t+1) + I_mat;
%     b_i(:,t+1)  = b_i(:,t+1) + I_mat;

    %adaptation
    a(spikeneurons,t+1)    = a(spikeneurons,t+1)   + adapt;

end

%--------------------------------------------------------------------------

end

%Catch for no spiking in simulation error
if isempty(spikes); spikes = [nan nan]; end

%% Figures
%Mean Population Dynamics Figure
figure
    subplot(3,1,1)
    plot(spikes(:,1),spikes(:,2),'.','MarkerSize',10)
    ylim([0 PopNum+1]);xlim(TimeSpace([1 end]))
    xlabel('Time (ms)');ylabel(['Cell (',num2str(PopNum),')'])
    box off; set(gca,'ytick',[])

    subplot(3,1,2)
    plot(TimeSpace,mean(V,1),'k')
    xlabel('Time (ms)');ylabel('Mean V')

    subplot(3,1,3)
    plot(TimeSpace,mean(a,1),'k')
    xlabel('Time (ms)');ylabel('Mean A')

%Example Neuron Figure
exneuron = randi(PopNum,1);
exspiketimes = spikes(spikes(:,2)==exneuron,1);
figure
    subplot(3,1,1)
    plot(TimeSpace,V(exneuron,:),'k')
    hold on
    plot(exspiketimes,V_th.*(ones(size(exspiketimes))),'r+')
    xlabel('Time (ms)');ylabel('Example Neuron: V')
    
    subplot(3,1,2)
    plot(TimeSpace,g_e(exneuron,:))
    hold on
    plot(TimeSpace,g_i(exneuron,:))
    xlabel('Time (ms)');ylabel('Example Neuron: g_s_y_n')
    
    subplot(3,1,3)
    plot(TimeSpace,a(exneuron,:))
    xlabel('Time (ms)');ylabel('Example Neuron: a')
%%
%Old Figures
% plot(linspace(0,SimTime,TimeLength + 1),V)
% xlabel('Time (ms)');ylabel('Membrane Potential (mV)');title('LIF Membrane Potential');
% 
% figure
% plot(linspace(0,SimTime,TimeLength + 1),g_e,'b')
% hold on
% plot(linspace(0,SimTime,TimeLength + 1),g_i,'r')
% xlabel('Time (ms)');ylabel('Conductance (S/cm^2)?)');title('LIF Conductance');
% 
% figure
% plot(linspace(0,SimTime,TimeLength + 1),a,'b')
% xlabel('Time (ms)');ylabel('Adaptation (pA)');title('LIF Adaptation');