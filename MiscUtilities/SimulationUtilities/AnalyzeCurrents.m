function [EEcurrent,EIcurrent,Ecurrent] = AnalyzeCurrents(PopParams,SimValues);
%[EEcurrent,EIcurrent,Ecurrent] = AnalyzeCurrents(PopParams,SimValues)
%Calculate the currents from the simulations
%
%INPUTS
%   PopParams     parameters of used neuron model
%   SimValues     Simulation values of a past simulation
%
%OUTPUTS
%   EEcurrent     E->E  current
%   EIcurrent     I->E  current
%   Ecurrent      total excitatory current
%JGornet Summer 2019

%%
EEcurrent = zeros(length(SimValues.EcellIDX),length(SimValues.t));
EIcurrent = zeros(length(SimValues.EcellIDX),length(SimValues.t));
Ecurrent  = zeros(length(SimValues.EcellIDX),length(SimValues.t));

EEcurrentMean = zeros(1,length(SimValues.t));
EIcurrentMean = zeros(1,length(SimValues.t));
EcurrentMean  = zeros(1,length(SimValues.t));

for ee = 1:length(SimValues.EcellIDX)

    EEcurrent(ee,:) = - SimValues.g_e(ee,:).*(SimValues.V(ee,:)-PopParams.E_e);
    EIcurrent(ee,:) = - SimValues.g_i(ee,:).*(SimValues.V(ee,:)-PopParams.E_i);
    Ecurrent(ee,:) = EEcurrent(ee,:) + EIcurrent(ee,:) + SimValues.Input(ee,:);

end

for tt = 1:length(SimValues.t)

    EEcurrentMean(tt) = mean(EEcurrent(:,tt));
    EIcurrentMean(tt) = mean(EEcurrent(:,tt));
    EcurrentMean(tt) = mean(EEcurrent(:,tt));
    
end
    
%%
% figure
% plot(SimValues.t,EEcurrent(1,:),'b')
% hold on
% plot(SimValues.t,EIcurrent(1,:),'r')
% hold on
% plot(SimValues.t,Ecurrent(1,:),'k')
% xlim(timewin)
% 
% figure
% plot(SimValues.t,EEcurrentMean,'b')
% hold on
% plot(SimValues.t,EIcurrentMean,'r')
% hold on
% plot(SimValues.t,EcurrentMean,'k')
% xlim(timewin)
% title('Mean Currents')

end