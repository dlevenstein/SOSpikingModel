PopParams.EPopNum = 100;
PopParams.IPopNum = 50;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.I_e     = 1000;
PopParams.V_th    = -30;
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

TimeParams.dt      = 0.01;
TimeParams.SimTime = 100;

[SimValues] = RK4AdLIFfunction(PopParams,TimeParams)
 
figure
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.','MarkerSize',10)
xlabel('Time (ms)');ylabel('Neuron ID'), title('Raster Plot')