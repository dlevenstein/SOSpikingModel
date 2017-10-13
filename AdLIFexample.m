PopParams.EPopNum = 500;
PopParams.IPopNum = 100;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.V_th    = -55;
PopParams.V_reset = -85;

PopParams.E_e     = 0;
PopParams.E_i     = -80;

PopParams.I_e     = 500;
PopParams.noise   = 100;

PopParams.E_w     = -70;
PopParams.b_w     = 0.1;

PopParams.b_s     = 1;

PopParams.dw      = 0.2;
PopParams.ds      = 0.5;

PopParams.a       = 0.5;
PopParams.b       = 0.1;

PopParams.t_ref   = 0.2;
PopParams.delta_T = 10;

PopParams.Wee   = 0.5;
PopParams.Wii   = 1;
PopParams.Wie   = 1;
PopParams.Wei   = 10; 

PopParams.Pee   = 0.1;
PopParams.Pii   = 0.1;
PopParams.Pie   = 0.1;
PopParams.Pei   = 0.1;

TimeParams.dt      = 0.01;
TimeParams.SimTime = 100;

[SimValues] = EMAdLIFfunction(PopParams,TimeParams,'showfig',true)
