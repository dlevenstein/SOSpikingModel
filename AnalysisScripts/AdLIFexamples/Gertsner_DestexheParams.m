%Gerstner/Destexhe Parameters

%%
cd ..
addpath(pwd);
%%
TimeParams.dt      = 0.01;
TimeParams.SimTime = 1000;
TimeParams.delta   = 10;

PopParams.EPopNum = 1;
PopParams.IPopNum = 0;

PopParams.E_L     = -70.6; %mV
PopParams.g_L     = 30;    %nS
PopParams.C       = 281;   %pF
PopParams.V_th    = -50.4;   %mV
PopParams.V_reset = -70.6;   %mV

PopParams.E_e     = 0;    %mV, Not found in Gertsner, using Destexhe
PopParams.E_i     = -80;  %mV, Not found in Gertsner, using Destexhe

PopParams.I_e     = linspace(0,5000,length(0:0.01:1000)); %pA, but should be range
PopParams.sigma   = zeros(1,length(0:0.01:1000)); %pA
PopParams.theta   = 10; %

PopParams.E_w     = -70.6; %mV, Not found in paper
PopParams.b_w     = 1./100; %1/ms

PopParams.b_s     = 0.2; %1/ms, Destexhe 

PopParams.dw      = 0.2; %ms, not known
PopParams.ds      = 0.5; %ms, not known

PopParams.a       = 1;   %excitatory 1 nS, inhibitory 5 nS
PopParams.b       = 0.1; %1/ms, around 1/500 1/ms if want subthreshold aspect

PopParams.t_ref   = 5; %ms, Destexhe
PopParams.gwnorm  = 0; %not known
PopParams.w_r     = 0.1; %not known
PopParams.delta_T = 10;  %around 1/500 1/ms if want subthreshold aspect

PopParams.Wee   = 1;
PopParams.Wii   = 1;
PopParams.Wie   = 1;
PopParams.Wei   = 1; 

PopParams.Kee   = 1;
PopParams.Kii   = 1;
PopParams.Kie   = 1;
PopParams.Kei   = 1;

[SimValues] = EMAdLIFfunction(PopParams,TimeParams,'showfig',true)