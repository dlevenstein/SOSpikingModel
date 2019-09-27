%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/spikingModel/SOSpikingModel';

addpath(genpath(repopath))

load('/home/jmg1030/Documents/spikingModel/data/logWeight_m_1_s_10.mat');

PopParamsAnalysis = PopParams;
PopParamsAnalysis.LearningRate = 0;
PopParamsAnalysis.sigma = 0;
PopParamsAnalysis.W = SimValues.WeightMat(:,:,end);

PopParamsAnalysis.V0 = PopParamsAnalysis.E_L(1);

Ivals = linspace(0,400,51);
sVals = [0,10,30];

TimeParams.dt = 0.05;
TimeParams.SimTime = 1000;

t = 0:TimeParams.dt:TimeParams.SimTime;

for simnum = 1:25
    
    rng(simnum,'twister');
    
for ss = 2:length(sVals)
    
    PopParamsAnalysis.sigma = sVals(ss);
    
parfor ii = 1:length(Ivals)
    
    PopParams_in = PopParamsAnalysis;
    PopParams_in.I_e = Ivals(ii).*heaviside(t-500);
    
    SimValuesArray(ss,ii) = AdLIFfunction_STDP_GPU(PopParams_in,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_dt',TimeParams.SimTime,'save_weights',TimeParams.SimTime)
    
end
end

    save(['/home/jmg1030/Documents/spikingModel/data/UP/simulation_num_' char(num2str(simnum)) '_SimValues.mat'],'SimValuesArray','-v7.3')
    
    clear SimValuesArray
    
end

