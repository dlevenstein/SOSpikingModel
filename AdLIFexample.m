

PopParams.EPopNum = 500;
PopParams.IPopNum = 100;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.I_e     = 350;
PopParams.V_th    = -55;
PopParams.V_reset = -85;
PopParams.tau_e   = 10;
PopParams.E_e     = 0;
PopParams.tau_i   = 10;
PopParams.E_i     = -80;
PopParams.adapt   = 0;
PopParams.tau_a   = 50;
PopParams.t_ref   = 0.2;
PopParams.delta_T = 10;

PopParams.Wee   = 10;
PopParams.Wii   = 100;
PopParams.Wie   = 10;
PopParams.Wei   = 100;

PopParams.Pee   = 0.1;
PopParams.Pii   = 0.1;
PopParams.Pie   = 0.1;
PopParams.Pei   = 0.1;

TimeParams.dt      = 0.1;
TimeParams.SimTime = 1000;

%[SimValues] = RK4AdLIFfunction(PopParams,TimeParams)
[SimValues] = AdLIFfunction(PopParams,TimeParams,'showfig',true)
%%
figure
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.','MarkerSize',10)
xlabel('Time (ms)');ylabel('Neuron ID'), title('Raster Plot')