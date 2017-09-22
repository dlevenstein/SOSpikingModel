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

PopParams.Wee   = 10;
PopParams.Wii   = 50;
PopParams.Wie   = 10;
PopParams.Wei   = 50; 

PopParams.Pee   = 0.1;
PopParams.Pii   = 0.5;
PopParams.Pie   = 0.1;
PopParams.Pei   = 0.5;

TimeParams.dt      = 0.01;
TimeParams.SimTime = 1000;

[SimValues] = RK2AdLIFfunction(PopParams,TimeParams,'showfig',true)

full_isi = [];

for i=0:max(SimValues.spikes(:,2))

    isi = diff(SimValues.spikes(SimValues.spikes(:,2)==i));
    for j=1:length(isi)
        full_isi = [full_isi j];
    end
        
end

disp(mean(full_isi));
disp(std(full_isi)./mean(full_isi));

figure
[t,w] = hist(full_isi, linspace(0,1000,50));
plot(w,t, 'r', 'Linewidth',2)


% figure
% imagesc(SimValues.a)
% colorbar
% figure
% plot(SimValues.TimeSpace,SimValues.noise,'k')
% figure
% plot(SimValues.TimeSpace,SimValues.g_i,'r')
%hold on
%plot(SimValues.TimeSpace,SimValues.g_e,'b')


%[SimValues] = RK4AdLIFfunction(PopParams,TimeParams,'showfig',true)
%[SimValues] = AdLIFfunction(PopParams,TimeParams,'showfig',true)
%%
figure
plot(SimValues.spikes(:,1),SimValues.spikes(:,2),'.','MarkerSize',10)
xlabel('Time (ms)');ylabel('Neuron ID'), title('Raster Plot')