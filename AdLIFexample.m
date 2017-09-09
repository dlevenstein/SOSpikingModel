PopParams.EPopNum = 50;
PopParams.IPopNum = 50;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.I_e     = 500;
PopParams.V_th    = -55;
PopParams.V_reset = -85;
PopParams.tau_e   = 10;
PopParams.E_e     = 0;
PopParams.tau_i   = 10;
PopParams.E_i     = -80;
PopParams.adapt   = 200;
PopParams.tau_a   = 50;

PopParams.Wee   = 50;
PopParams.Wii   = 50;
PopParams.Wie   = 50;
PopParams.Wei   = 50;

TimeParams.dt      = 0.1;
TimeParams.SimTime = 500;

[SimValues] = AdLIFfunction(PopParams,TimeParams,'showfig',true)
%%
figure
plot(SimValues.TimeSpace,SimValues.V,'k')
xlabel('Time (ms)');ylabel('Voltage (mV)');title('EI Pop');
