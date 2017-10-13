function [ Ivals,rate ] = SimulateFICurve(simfunction,PopParams,Irange )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS
%   simfunction     simulation function. function should be passed through 
%                   as @SimFunctionName. And should have input/output:
%                   SimValues = simfunction(PopParams,TimeParams)                   
%   PopParams       population parameters structure to pass through to the
%                   simulation function
%   Irange          [min max] input current values
%
%
%% DEV
simfunction = @EMAdLIFfunction;
Irange = [150 500];
numI = 26;
noiselevel = 100;

simtime = 2000; %ms
onsettransient = 500; %ms

UPDOWN = false; %if looking for UP/DOWN bistability, simulate with ON and OFF initial conditions

%% POP PARMS 4 DEV
PopParams.EPopNum = 1;
PopParams.IPopNum = 1;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.V_th    = -55;
PopParams.V_reset = -85;

PopParams.E_e     = 0;
PopParams.E_i     = -80;


PopParams.E_w     = -70;
PopParams.b_w     = 0.1;

PopParams.b_s     = 1;

PopParams.dw      = 0.2;
PopParams.ds      = 0.5;

PopParams.a       = 0.5;
PopParams.b       = 0.1;

PopParams.t_ref   = 0.2;
PopParams.delta_T = 10;

PopParams.Wee   = 0;
PopParams.Wii   = 0;
PopParams.Wie   = 0;
PopParams.Wei   = 0; 

PopParams.Pee   = 0.1;
PopParams.Pii   = 0.1;
PopParams.Pie   = 0.1;
PopParams.Pei   = 0.1;



%[SimValues] = EMAdLIFfunction(PopParams,TimeParams,'showfig',true)

%% Set the parameters

PopParams.noise   = noiselevel;
TimeParams.dt      = 0.01;
TimeParams.SimTime = simtime;
%% Run the simulations
Ivals = linspace(Irange(1),Irange(2),numI);
clear SimValues
for ii = 1:numI
    ii
PopParams.I_e     = Ivals(ii);
[SimValues(ii)] = simfunction(PopParams,TimeParams,'showfig',false);
end

%% Calculate Rate, Variable distributions
%rate = zeros(1,numI);
voltagebins = linspace(PopParams.V_reset,PopParams.V_th,100);
conductancebins = linspace(0,1,100);
totaltime = simtime-onsettransient;
clear voltagedist
clear adaptdist
for ii = 1:numI
    afteronsetspikes = SimValues(ii).spikes(:,1)>onsettransient;
    Espikes = ismember(SimValues(ii).spikes(:,2),SimValues(ii).EcellIDX);
    Ispikes = ismember(SimValues(ii).spikes(:,2),SimValues(ii).IcellIDX);

    rate.E(ii) = sum(afteronsetspikes&Espikes)./PopParams.EPopNum./(totaltime./1000); %units: spikes/cell/s
    rate.I(ii) = sum(afteronsetspikes&Ispikes)./PopParams.IPopNum./(totaltime./1000); %units: spikes/cell/s
    
    voltagedist.E(:,ii) = hist(SimValues(ii).V(SimValues(ii).EcellIDX,:),voltagebins);
    voltagedist.I(:,ii) = hist(SimValues(ii).V(SimValues(ii).IcellIDX,:),voltagebins);
    
    adaptdist.E(:,ii) = hist(SimValues(ii).g_w(SimValues(ii).EcellIDX,:),conductancebins);
    adaptdist.I(:,ii) = hist(SimValues(ii).g_w(SimValues(ii).IcellIDX,:),conductancebins);
end

%% Example Voltage Traces
numextraces = 5;
extraces = round(linspace(1,numI,numextraces));
excells = [randsample(SimValues(1).EcellIDX,1) randsample(SimValues(1).IcellIDX,1)];
exrange = onsettransient + [0 200]; 
extimeIDX = SimValues(1).TimeSpace>=exrange(1) & SimValues(1).TimeSpace<=exrange(2);
extime = SimValues(1).TimeSpace(extimeIDX);
clear exampletrace
for ii = 1:numextraces
    exampletrace.E(:,ii) = SimValues(extraces(ii)).V(excells(1),extimeIDX)';
    exampletrace.I(:,ii) = SimValues(extraces(ii)).V(excells(2),extimeIDX)';
end
%%
figure
    subplot(3,2,1)
        plot(Ivals,rate.I,'ro--','markersize',4)
        hold on
        plot(Ivals,rate.E,'ko--','markersize',4)
        legend('I','E','location','northwest')
        xlabel('I (units?)');ylabel('Rate (spks/cell/s)')
        xlim(Ivals([1 end]))

    subplot(6,2,5)
    imagesc(Ivals,voltagebins,voltagedist.E)
    axis xy
    
    subplot(6,2,7)
    imagesc(Ivals,voltagebins,voltagedist.I)
    axis xy
    
    subplot(6,2,9)
    imagesc(Ivals,conductancebins,adaptdist.E)
    axis xy
    
    subplot(6,2,11)
    imagesc(Ivals,conductancebins,adaptdist.I)
    axis xy

    
    

%%
figure
for ee = 1:numextraces
subplot(numextraces,2,ee.*2)
plot(extime,exampletrace.E(:,ee),'k')
hold on
plot(extime,exampletrace.I(:,ee),'r')
ylim([PopParams.V_reset PopParams.V_th])
xlabel('t (ms)');ylabel(['V: ex.cell'])
end


%%
%distribition/mean of Vm (single cell or pop?), E/I synaptic output, adaptation
%as function of I
