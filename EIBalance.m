function [] = EIBalance(i)

x = 0:5:100;
y = combvec(x,x);

for j=1:length(y)
    
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

PopParams.Wee   = y(1,i);
PopParams.Wii   = y(2,i);
PopParams.Wie   = y(1,j);
PopParams.Wei   = y(2,j);

PopParams.Pee   = 0.1;
PopParams.Pii   = 0.1;
PopParams.Pie   = 0.1;
PopParams.Pei   = 0.1;

TimeParams.dt      = 0.01;
TimeParams.SimTime = 500;

[SimValues] = RK4AdLIFfunction(PopParams,TimeParams,'showfig',false)

csvwrite(['EE_' num2str(z(1,i)) '_II_' num2str(z(2,i)) '_IE_' num2str(z(3,i)) '_EI_' num2str(z(4,i)) '.csv'], SimValues.spikes)
end
end