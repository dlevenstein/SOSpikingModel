%A script for analysis of single neuron input-output properties in the
%Conductance-based adapting LIF model
%DLevenstein and JGornet

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
%repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures'];

%% Define the Population Parameters to feed the FI Cuve function

%Input Noise
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 10;
PopParams.IPopNum = 10;

%Neuron properties
PopParams.E_L     = -65;    %rev potential: leak (mV)
PopParams.g_L     = 30;     %leak conductance (nS)
PopParams.C       = 281;    %capacitance (pF)
PopParams.V_th    = -55;    %spike threshold (mV)
PopParams.V_reset = -85;    %reset potential (mV)
PopParams.t_ref   = 0.2;    %refractory period (ms)

%Neuron properties: Reyes
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
%PopParams.V_reset = [-48 -50];    %reset potential (mV)(original)
PopParams.V_reset = [-55 -55];    %reset potential (mV) 
PopParams.t_ref   = 0.2;    %refractory period (ms)

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.b_s     = 1;      %synaptic decay timescale (1/ms)
PopParams.ds      = 0.5;    %synaptic activation duration (ms)
PopParams.a       = 0.5;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.dw      = 0.2;    %adaptation activation duration (ms)
PopParams.b       = 0.1;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r = 0.1;        %adaptation at rest (0-1)
PopParams.gwnorm = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 0;        %E->E weight
PopParams.Wii   = 0;        %I->I weight
PopParams.Wie   = 0;        %E->I weight
PopParams.Wei   = 0;        %I->E weight
PopParams.Kee   = 0;        %Expected E->E In Degree
PopParams.Kii   = 0;        %Expected I->I In Degree
PopParams.Kie   = 0;        %Expected E->I In Degree
PopParams.Kei   = 0;        %Expected I->E In Degree



%% Run the FI Curve function to calculate single neuron FI curves
simfunction = @EMAdLIFfunction;

Irange = [0 400];
numI = 36;

%Simulate FI for 3 levels of noise
sigvals = [0 20 40];
%sigvals = [0];
for ss = 1:length(sigvals)
PopParams.sigma = sigvals(ss); 
[ Ivals,rate(ss),voltagemean(ss) ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig',['CondAdLIF_Sig',num2str(sigvals(ss))],'figfolder',figfolder);
end



%% Summary plot

figure
subplot(3,2,1)
hold on
for ss=1:length(sigvals)
    plot(Ivals,rate(ss).E,'ko:','markersize',3,'linewidth',1)
end

subplot(3,2,2)
hold on
for ss=1:length(sigvals)
    plot(Ivals,rate(ss).I,'ko:','markersize',3,'linewidth',1)
end

subplot(3,2,3)
hold on
for ss=1:length(sigvals)
    plot(Ivals,voltagemean(ss).E,'ko:','markersize',3,'linewidth',1)
end

subplot(3,2,4)
hold on
for ss=1:length(sigvals)
    plot(Ivals,voltagemean(ss).I,'ko:','markersize',3,'linewidth',1)
end
NiceSave('AllFICurve',figfolder,[])

%%
Ecolor = makeColorMap([1 1 1],[0 0.5 0],[0 0 0]);
Icolor = makeColorMap([1 1 1],[0.8 0 0],[0 0 0]);

figure
plot(Ivals,rate.I,'o--','color',Icolor(end/2,:),'markersize',4)
hold on
plot(Ivals,rate.E,'o--','color',Ecolor(end/2,:),'markersize',4)
hold on
plot(Ivals,rate_low.I,'-.','color',Icolor(end/2,:),'markersize',4)
hold on
plot(Ivals,rate_low.E,'-.','color',Ecolor(end/2,:),'markersize',4)
hold on
plot(Ivals,rate_high.I,':','color',Icolor(end/2,:),'markersize',4)
hold on
plot(Ivals,rate_high.E,':','color',Ecolor(end/2,:),'markersize',4)
legend('I: No Noise','E: No Noise','I: 0.1','E: 0.1','I: 0.3','E: 0.3','location','northwest')
xlabel('I (pA)');ylabel('Rate (spks/cell/s)');title('FI Comparisons')
xlim(Ivals([1 end]))

NiceSave('FI_Comparisons',figfolder,[]);

figure
plot(Ivals,voltagemean.I,'o--','color',Icolor(end/2,:),'markersize',4)
hold on
plot(Ivals,voltagemean.E,'o--','color',Ecolor(end/2,:),'markersize',4)
hold on
plot(Ivals,voltagemean_low.I,'-.','color',Icolor(end/2,:),'markersize',4)
hold on
plot(Ivals,voltagemean_low.E,'-.','color',Ecolor(end/2,:),'markersize',4)
hold on
plot(Ivals,voltagemean_high.I,':','color',Icolor(end/2,:),'markersize',4)
hold on
plot(Ivals,voltagemean_high.E,':','color',Ecolor(end/2,:),'markersize',4)
legend('I: No Noise','E: No Noise','I: 0.1','E: 0.1','I: 0.3','E: 0.3','location','northwest')
xlabel('I (pA)');ylabel('Rate (spks/cell/s)');title('Voltage Comparisons')
xlim(Ivals([1 end]))

NiceSave('Voltage_Comparisons',figfolder,[]);


