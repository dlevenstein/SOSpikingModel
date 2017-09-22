E_range = 0:5:100;
I_range = 0:20:500;

EE_length = length(E_range);
II_length = length(I_range);

cv_isi = zeros(EE_length,II_length);

for EE=1:EE_length

for II=1:II_length
    
PopParams.EPopNum = 500;
PopParams.IPopNum = 100;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.V_th    = -55;
PopParams.V_reset = -85;

PopParams.I_e     = 500;
PopParams.noise   = [0;100];

PopParams.tau_e   = 10;
PopParams.E_e     = 0;

PopParams.tau_i   = 10;
PopParams.E_i     = -80;

PopParams.adapt   = 0;
PopParams.tau_a   = 500;

PopParams.t_ref   = 0.2;
PopParams.delta_T = 10;

PopParams.Wee   = E_range(EE);
PopParams.Wii   = I_range(II);
PopParams.Wie   = E_range(EE);
PopParams.Wei   = I_range(II); 

PopParams.Pee   = 0.1;
PopParams.Pii   = 0.5;
PopParams.Pie   = 0.1;
PopParams.Pei   = 0.5;

TimeParams.dt      = 0.01;
TimeParams.SimTime = 500;

[SimValues] = RK2AdLIFfunction(PopParams,TimeParams,'showfig',false)

full_isi = [];

for i=0:max(SimValues.spikes(:,2))

    isi = diff(SimValues.spikes(SimValues.spikes(:,2)==i));
    for j=1:length(isi)
        full_isi = [full_isi j];
    end
    
    cv_isi(EE,II) = std(full_isi)./mean(full_isi);
end

end
end