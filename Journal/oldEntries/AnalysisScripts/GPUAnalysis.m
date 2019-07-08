SimValuesCPU = load('CPUSimValues.mat');
SimValuesGPU = load('GPUSimValues.mat');

%%
figure
subplot(3,1,1)
plot(SimValuesCPU.spikes(:,1),SimValuesCPU.spikes(:,2),'.k','MarkerSize',1)
xlim([9800 1e4]);ylim([0 2500])
xlabel('Time (ms)');ylabel('Neuron ID');title('CPU')
subplot(3,1,2)
plot(SimValuesGPU.spikes(:,1),SimValuesGPU.spikes(:,2),'.k','MarkerSize',1)
xlim([9800 1e4]);ylim([0 2500])
xlabel('Time (ms)');ylabel('Neuron ID');title('GPU')
subplot(3,1,3)
plot(SimValuesCPU.spikes(:,1)-SimValuesGPU.spikes(:,1),'.k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Time Differences (ms)');title('CPU v. GPU')

NiceSave('CPUvGPUSpikes','~/Desktop/GPUAnalysis',[])
%%
r = randi(2500,[10,1]);

figure
subplot(3,1,1)
plot(SimValuesCPU.t,SimValuesCPU.V(r,:),'k','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('Voltage (mV)');title('CPU')
subplot(3,1,2)
plot(SimValuesGPU.t,SimValuesGPU.V(r,:),'k','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('Voltage (mV)');title('GPU')
subplot(3,1,3)
plot(SimValuesGPU.t,SimValuesCPU.V-SimValuesGPU.V,'k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Voltage Differences (mV)');title('CPU v. GPU')

NiceSave('CPUvGPUVoltages','~/Desktop/GPUAnalysis',[])
%%
figure
subplot(3,1,1)
plot(SimValuesCPU.t,SimValuesCPU.x(r,:),'k','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('x');title('CPU')
subplot(3,1,2)
plot(SimValuesGPU.t,SimValuesGPU.x(r,:),'k','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('x');title('GPU')
subplot(3,1,3)
plot(SimValuesGPU.t,SimValuesCPU.x-SimValuesGPU.x,'k','MarkerSize',1)
xlabel('Time (ms)');ylabel('x Differences');title('CPU v. GPU')

NiceSave('CPUvGPUPlasticity','~/Desktop/GPUAnalysis',[])
%%
figure
subplot(3,1,1)
plot(SimValuesCPU.t,SimValuesCPU.Input(r,:),'k','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('x');title('CPU')
subplot(3,1,2)
plot(SimValuesGPU.t,SimValuesGPU.Input(r,:),'k','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('x');title('GPU')
subplot(3,1,3)
plot(SimValuesGPU.t,SimValuesCPU.Input-SimValuesGPU.Input,'k','MarkerSize',1)
xlabel('Time (ms)');ylabel('x Differences');title('CPU v. GPU')

%%
figure
subplot(3,1,1)
plot(SimValuesCPU.t,SimValuesCPU.g_e(r,:),'b','MarkerSize',1)
hold on
plot(SimValuesCPU.t,SimValuesCPU.g_i(r,:),'r','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('Conductance (nS)');title('CPU')
subplot(3,1,2)
plot(SimValuesGPU.t,SimValuesGPU.g_e(r,:),'b','MarkerSize',1)
hold on
plot(SimValuesGPU.t,SimValuesGPU.g_i(r,:),'r','MarkerSize',1)
xlim([9800 1e4])
xlabel('Time (ms)');ylabel('Conductance (nS)');title('GPU')
subplot(3,1,3)
plot(SimValuesGPU.t,SimValuesCPU.g_e-SimValuesGPU.g_e,'k','MarkerSize',1)
hold on
plot(SimValuesGPU.t,SimValuesCPU.g_i-SimValuesGPU.g_i,'k','MarkerSize',1)
xlabel('Time (ms)');ylabel('Conductance Differences (nS)');title('CPU v. GPU')

NiceSave('CPUvGPUConductances','~/Desktop/GPUAnalysis',[])
