function [ Ivals,rate ] = SimulateFICurve(simfunction,PopParams,Irange,noiselevel,varargin)
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
%   (options)
%   'showfig'       default:true
%
%
%% DEV
simfunction = @EMAdLIFfunction;
Irange = [150 500];
numI = 26;
noiselevel = 0;

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

PopParams.Kee   = 0;
PopParams.Kii   = 0;
PopParams.Kie   = 0;
PopParams.Kei   = 0;

PopParams.theta = 1/10;

PopParams.gwnorm = 0;

PopParams.w_r = 0.1;


%% Input options
if ~exist('varargin','var')
    SHOWFIG=true;
else
p = inputParser;
addParameter(p,'showfig',true,@islogical)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;
end
%% Set the parameters

PopParams.sigma   = noiselevel;
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
extimeIDX = SimValues(1).t>=exrange(1) & SimValues(1).t<=exrange(2);
extime = SimValues(1).t(extimeIDX);
clear exampletrace
for ii = 1:numextraces
    exampletrace.E(:,ii) = SimValues(extraces(ii)).V(excells(1),extimeIDX)';
    exampletrace.I(:,ii) = SimValues(extraces(ii)).V(excells(2),extimeIDX)';
end
%% 
if SHOWFIG
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
        xlabel('I (units?)');ylabel('V (E cells)');    
    subplot(6,2,7)
        imagesc(Ivals,voltagebins,voltagedist.I)
        axis xy
        xlabel('I (units?)');ylabel('V (I cells)');
    subplot(6,2,9)
        imagesc(Ivals,conductancebins,adaptdist.E)
        axis xy
        xlabel('I (units?)');ylabel('g_w (E cells)');
    subplot(6,2,11)
        imagesc(Ivals,conductancebins,adaptdist.I)
        axis xy
        xlabel('I (units?)');ylabel('g_w (I cells)');

    %add synaptic conductances...
    %add noise etc parm text in figure
    

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

end

