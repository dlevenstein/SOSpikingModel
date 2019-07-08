addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/RunCodes')
addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/FunctionRoutines')
addpath('/Users/jonathangornet/Documents/GitHub/SOSpikingModel/MiscUtilities')

close all

%% Example Neuron Properties

%Input 
PopParams.sigma = 0;        %niose magnitude: variance
PopParams.theta = 0;        %noise time scale (1/ms)

% One neuron
PopParams.EPopNum = 100;
PopParams.IPopNum = 50;

%Neuron properties
PopParams.E_L     = [-65 -67];    %rev potential: leak (mV)
PopParams.g_L     = [182/18 119/8];     %leak conductance (nS)
PopParams.C       = [182 119];    %capacitance (pF)
PopParams.V_th    = [-45 -47];    %spike threshold (mV)
PopParams.V_reset = [-55 -55];    %reset potential (mV)
PopParams.t_ref   = 0.5;    %refractory period (ms)

%Synaptic Properties 
PopParams.E_e     = 0;      %rev potential: E (mV)
PopParams.E_i     = -80;    %rev potential: I (mV)
PopParams.tau_s   = [2 2];      %synaptic decay timescale (1/ms)
PopParams.a       = 10;    %synaptic activation rate (1/ms)

%Adaptation Properties
PopParams.E_w     = -70;    %rev potential: adaptation (mV)
PopParams.b_w     = 0.01;   %adaptation decay timescale (1/ms)
PopParams.b       = 0;    %adaptation activation rate (1/ms)
PopParams.delta_T = 0;     %subthreshold adaptation steepness
PopParams.w_r     = 0.1;     %adaptation at rest (0-1)
PopParams.gwnorm  = 0;       %magnitude of adaptation

%Network Properties
PopParams.Wee   = 10;        %E->E weight
PopParams.Wii   = 10;        %I->I weight
PopParams.Wie   = 10;        %E->I weight
PopParams.Wei   = 10;        %I->E weight
PopParams.Kee   = 5;        %Expected E->E In Degree
PopParams.Kii   = 5;        %Expected I->I In Degree
PopParams.Kie   = 5;        %Expected E->I In Degree
PopParams.Kei   = 5;        %Expected I->E In Degree

% Convert weight matrix
PopParams.W = SimValues.WeightMat;

PopParams.p0spike = 0;

%STDP Properties

PopParams.EELearningRate = 0;
PopParams.IILearningRate = 0;
PopParams.IELearningRate = 0;
PopParams.EILearningRate = 0;

PopParams.EEtau = 1;
PopParams.IItau = 1;
PopParams.IEtau = 1;
PopParams.EItau = 1;

%% Time Parameters
TimeParams.dt      = 0.05;
TimeParams.SimTime = 1500;

%% UP

OFFtime = 500;

Ivals = -2000:50:1000;
Ilength = length(Ivals);

dbin = 0.5;

timebins = OFFtime+dbin:dbin:TimeParams.SimTime;
tbinLength = length(timebins);

rateUP = zeros(tbinLength,Ilength);

for ii = 1:Ilength
    
    PopParams.I_e = @(t) 1500.*heaviside(OFFtime-t)+Ivals(ii);
    
    SimValuesUP(ii) = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showfig',false);

    for tt = 1:tbinLength

        rateUP(tt,ii) = length(find(SimValuesUP(ii).spikes(:,1) >= timebins(tt) - dbin & SimValuesUP(ii).spikes(:,1) < timebins(tt)))./(dbin*(PopParams.EPopNum+PopParams.IPopNum));

    end
        
end

%% Time Parameters
TimeParams.dt      = 0.05;
TimeParams.SimTime = 1000;

%% DOWN

dbin = 0.5;

timebins = dbin:dbin:TimeParams.SimTime;
tbinLength = length(timebins);

rateDOWN = zeros(tbinLength,Ilength);

for ii = 1:Ilength
    
    PopParams.I_e = Ivals(ii);
    
    SimValuesDOWN(ii) = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showfig',false);

    for tt = 1:tbinLength

        rateDOWN(tt,ii) = length(find(SimValuesDOWN(ii).spikes(:,1) >= timebins(tt) - dbin & SimValuesDOWN(ii).spikes(:,1) < timebins(tt)))./(dbin*(PopParams.EPopNum+PopParams.IPopNum));

    end
        
end

%% Rate UP

ratebins = linspace(0,0.5,20);
rateLength = length(ratebins);

rateVectorUP = zeros(rateLength,Ilength);

meanRateUP = zeros(1,Ilength);
varRateUP = zeros(1,Ilength);

for ii = 1:Ilength
for rr = 1:rateLength-1
    
    rateVectorUP(:,ii) = hist(rateUP(:,ii),ratebins);
    meanRateUP(ii) = mean(rateUP(:,ii));
    varRateUP(ii) = var(rateUP(:,ii));
    
end
end

%% Rate DOWN

ratebins = linspace(0,0.5,20);
rateLength = length(ratebins);

rateVectorDOWN = zeros(rateLength,Ilength);

meanRateDOWN = zeros(1,Ilength);
varRateDOWN = zeros(1,Ilength);

for ii = 1:Ilength
for rr = 1:rateLength-1
    
    rateVectorDOWN(:,ii) = hist(rateDOWN(:,ii),ratebins);
    
    meanRateDOWN(ii) = mean(rateDOWN(:,ii));
    varRateDOWN(ii) = var(rateDOWN(:,ii));
    
end
end

%%

figure 
subplot(2,1,1)
imagesc(Ivals,ratebins,rateVectorUP)
caxis([0,500])
colorbar
xlabel('Current I (pA)');ylabel('Rate');title('FI Curve UP State')
set(gca,'Ydir','Normal')

subplot(2,1,2)
imagesc(Ivals,ratebins,rateVectorDOWN)
caxis([0,500])
colorbar
xlabel('Current I (pA)');ylabel('Rate');title('FI Curve DOWN State')
set(gca,'Ydir','Normal')

%%

figure
plot(Ivals,meanRateDOWN,'b','LineWidth',1);
hold on
plot(Ivals,meanRateUP,'r','LineWidth',1);
xlabel('Current I (pA)');ylabel('Mean Rate');title('FI Curve UP and DOWN State')
legend('DOWN','UP')

figure
plot(Ivals,varRateDOWN,'b','LineWidth',1);
hold on
plot(Ivals,varRateUP,'r','LineWidth',1);
xlabel('Current I (pA)');ylabel('Variance Rate');title('FI Curve UP and DOWN State')
legend('DOWN','UP')

