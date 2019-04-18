function CondAdLIF_STDP_LogWeightSigmaM1_Adaptation_Noise(index)

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
addpath(genpath(repopath))

load('/scratch/jmg1030/FIcurve/data/trainedWeights/LogWeightSigma/LognormalE_iSTDPI.mat');

PopParams_in = PopParams;
PopParams_in.tau_w = 300;
PopParams_in.LearningRate = 0;
PopParams_in.sigma = 25;
PopParams_in.W = SimValues.WeightMat(:,:,end);
PopParams_in.gwnorm = PopParams_in.g_L(1);
PopParams_in.t_syn = 0;

PopParams_in.V0 = min(PopParams_in.E_L) + (min(PopParams_in.V_th)-min(PopParams_in.E_L)).*rand(PopParams_in.EPopNum + PopParams_in.IPopNum,1);

TimeParams.dt      = 0.05;

TimeParams.SimTime = 1e4;

Ivals = linspace(100,300,21);
bvals = logspace(-2,2,11);

for II = 1:(length(Ivals)*length(bvals))
    
if mod(II,4)+1 == index
ii = mod(II,length(Ivals))+1;
bb = ceil(II/length(Ivals));
    
ii
bb 
    
PopParamsAnalysis = PopParams_in;

I_e = Ivals(ii);
b = bvals(bb);

PopParamsAnalysis.I_e = I_e;
PopParamsAnalysis.b = b;

SimValuesArray = AdLIFfunction_STDP_GPU(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',true);

spikes = SimValuesArray.spikes;

save(['/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/LogWeightSigmaM1/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'],'spikes','-v7.3') 
end

end

end