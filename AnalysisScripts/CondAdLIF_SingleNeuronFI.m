%A script for analysis of single neuron input-output properties in the
%Conductance-based adapting LIF model
%DLevenstein and JGornet

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

%repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
repopath = '/Users/jonathangornet/Documents/GitHub/SOSpikingModel'; 
addpath(genpath(repopath))

figfolder = [repopath,'/Figures'];

%% Define the Population Parameters to feed the FI Cuve function

%Input Noise
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 1;
PopParams.IPopNum = 1;

%Neuron properties
PopParams.E_L     = -65;    %rev potential: leak (mV)
PopParams.g_L     = 30;     %leak conductance (nS)
PopParams.C       = 281;    %capacitance (pF)
PopParams.V_th    = -55;    %spike threshold (mV)
PopParams.V_reset = -85;    %reset potential (mV)
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
PopParams.delta_T = 10;     %subthreshold adaptation steepness
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
Irange = [150 450];
numI = 26;
[ Ivals,rate,voltagemean ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','CondAdLIF_NoNoise','figfolder',figfolder);

%% Run the FI curve function for low and high magnitutes of noise
%Jonathan: please run the FI curve function for two valules 
%for noise here, one low and one high (find two good illustrative values)

%Input Noise
PopParams.sigma = 0.1;       %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

simfunction = @EMAdLIFfunction;
Irange = [150 450];
numI = 26;
[ Ivals,rate_low,voltagemean_low ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','CondAdLIF_Low_Noise_01','figfolder',figfolder);

%%
%Input Noise
PopParams.sigma = 0.3;      %niose magnitude: variance
PopParams.theta = 1/10;     %noise time scale (1/ms)

simfunction = @EMAdLIFfunction;
Irange = [150 450];
numI = 26;
[ Ivals,rate_high,voltagemean_high ] = SimulateFICurve(simfunction,PopParams,Irange,numI,...
    'showfig','CondAdLIF_High_Noise_03','figfolder',figfolder);

%% Summary plot: overlay the F-I curves for 3 representative magnitudes of noise (none low high)
%Jonathan: please make a summary figure here that shows the input-output
%functions for all three valules of noise (none,low,high) on the same plot.
%Combine this with the saved figures showing Vm distirbutions and possibly
%some example traces to make a final summary figure we can discuss with
%John!

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

