repopath = '/home/jmg1030/Documents/spikingModel/SOSpikingModel';
addpath(genpath(repopath))

load('/home/jmg1030/Documents/spikingModel/data/ExperimentRate_s_10.mat');

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

for ii = 1:length(Ivals)

I_e = Ivals(ii);
    
parfor bb = 1:length(bvals)
    
PopParamsAnalysis = PopParams_in;

b = bvals(bb);

PopParamsAnalysis.I_e = I_e;
PopParamsAnalysis.b = b;

SimValuesArray(ii,bb) = AdLIFfunction_STDP_GPU(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_dt',1,'save_weights',TimeParams.SimTime);

end
end

for ii = 1:length(Ivals)
for bb = 1:length(bvals)
    
    SimValues = SimValuesArray(ii,bb);
    save(['/home/jmg1030/Documents/spikingModel/data/AdaptationVCurrent_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'],'struct','-v7.3')
    
end
end