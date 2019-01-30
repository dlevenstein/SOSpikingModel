function CondAdLIF_STDP_ExperimentRate_Adaptation(index)

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
addpath(genpath(repopath))

load('/scratch/jmg1030/FIcurve/data/trainedWeights/ExperimentRate/ExperimentRate_s_10.mat');

PopParams_in = PopParams;
PopParams_in.tau_w = 100;
PopParams_in.LearningRate = 0;
PopParams_in.sigma = 10;
PopParams_in.W = SimValues.WeightMat(:,:,end);
PopParams_in.gwnorm = PopParams_in.g_L(1);

PopParams_in.V0 = min(PopParams_in.E_L) + (min(PopParams_in.V_th)-min(PopParams_in.E_L)).*rand(PopParams_in.EPopNum + PopParams_in.IPopNum,1);

TimeParams.dt      = 0.05;
TimeParams.SimTime = 1e4;

Ivals = linspace(0,400,21);
bvals = [0 logspace(-1,2,9)];

ii = mod(index,21)+1;
bb = ceil(index/21);
    
ii
bb 
    
PopParamsAnalysis = PopParams_in;

I_e = Ivals(ii);
b = bvals(bb);

PopParamsAnalysis.I_e = I_e;
PopParamsAnalysis.b = b;

SimValuesArray = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',1,'save_weights',TimeParams.SimTime);
    
SimValues.spikes = SimValuesArray.spikes;
SimValues.V = SimValuesArray.V;

SimValues.g_e = SimValuesArray.g_e;
SimValues.g_i = SimValuesArray.g_i;
SimValues.g_w = SimValuesArray.g_w;

save(['/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/ExperimentRate/AdaptationVCurrent_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'],'SimValues','-struct','-v7.3') 

end