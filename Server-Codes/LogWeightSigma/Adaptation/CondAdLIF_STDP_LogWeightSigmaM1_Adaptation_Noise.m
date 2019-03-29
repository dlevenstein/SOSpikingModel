function CondAdLIF_STDP_LogWeightSigmaM1_Adaptation_Noise(index)

repopath = '/scratch/jmg1030/FIcurve/SOSpikingModel';
addpath(genpath(repopath))

load('/scratch/jmg1030/FIcurve/data/trainedWeights/LogWeightSigma/logWeight_m_1_s_10.mat');

PopParams_in = PopParams;
PopParams_in.tau_w = 300;
PopParams_in.syn_ref = 0.5;
PopParams_in.LearningRate = 0;
PopParams_in.sigma = 10;
PopParams_in.W = SimValues.WeightMat(:,:,end);
PopParams_in.gwnorm = PopParams_in.g_L(1);

PopParams_in.V0 = min(PopParams_in.E_L) + (min(PopParams_in.V_th)-min(PopParams_in.E_L)).*rand(PopParams_in.EPopNum + PopParams_in.IPopNum,1);

TimeParams.dt      = 0.05;

SimTime = 1e4;
RecordTime = 1e4;

TimeParams.SimTime = SimTime+RecordTime;

Ivals = linspace(100,300,41);
bvals = 0:10:100;

ii = mod(index,41)+1;
bb = ceil(index/41);
    
ii
bb 
    
PopParamsAnalysis = PopParams_in;

I_e = Ivals(ii);
b = bvals(bb);

PopParamsAnalysis.I_e = I_e;
PopParamsAnalysis.b = b;

SimValuesArray = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
    'save_weights',SimTime,'save_dt',SimTime,...
    'recordInterval',[0:SimTime:SimTime;(0:SimTime:SimTime) + RecordTime]);

spikes = SimValuesArray.spikes;

save(['/scratch/jmg1030/FIcurve/data/bistabilityTest/Adaptation/LogWeightSigmaM1/AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'],'spikes','-v7.3') 

end