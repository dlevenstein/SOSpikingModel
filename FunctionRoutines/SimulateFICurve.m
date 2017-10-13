function [ output_args ] = SimulateFICurve( simfunction,parms, Irange )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS
%   simfunction     function name. function must be formatted like XXX
%   Irange
%
%
%% DEV
simfunction = 'EMAdLIFfunction';
Irange = [0 1000];
numI = 21;
noiselevel = 0;

simtime = 4000; %ms
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

for ii = 1:numI
    ii
PopParams.I_e     = Ivals(ii);
[SimValues(ii)] = EMAdLIFfunction(PopParams,TimeParams,'showfig',false);
end

%% Calculate Rate
rate = zeros(1,numI);
totaltime = simtime-onsettransient;
for ii = 1:numI
    usespikes = SimValues(ii).spikes(:,1);
    usespikes(usespikes<onsettransient) = []; %remove onset transient
    numspikes(ii) = length(usespikes);
    rate(ii) = (numspikes(ii)./totaltime).*1000; %units: spikes/s
end

%% Example Voltage Traces
excell = 
for ii = 1:numI
    
end
%%
figure
subplot(3,2,1)
plot(Ivals,rate,'ko--')
xlabel('I (units?)');ylabel('Rate (spks/cell/s)')
