function CondAdLIF_iSTDP_Noise_Tests

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository

repopath = '/home/jmg1030/Documents/GitHub/SOSpikingModel';

addpath(genpath(repopath))

%%
filepath = '/home/jmg1030/Documents/spikingModel/data/Noise_Tests/';

for index = 1:4
%%
if index == 1 %L(1,10) Experimental Rates

filename = 'Lognormal_m_1_s_10_EE_ExperimentalRates_Noise_100ms_50pA';
load([filepath filename])

disp('L(1,10),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 100 ms, 50 pA')

elseif index == 2 %L(1,10) Experimental Rates

filename = 'Lognormal_m_1_s_10_EE_ExperimentalRates_Noise_10ms_100pA';
load([filepath filename])

disp('L(1,10),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 10 ms, 100 pA')

elseif index == 3 %L(1,10) Experimental Rates

filename = 'Lognormal_m_1_s_10_EE_ExperimentalRates_Noise_100ms_100pA';
load([filepath filename])

disp('L(1,10),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 100 ms, 100 pA')

elseif index == 4 %L(1,10) Clusters

filename = 'Lognormal_m_1_s_10_EE_ExperimentalRates_Noise_10ms_50pA_Clusters_50';
load([filepath filename])

disp('L(1,10),Plastic I->E (Experimental Targets), Indegree 250 E->E, 250 I->I, 250 E->I, 250 I->E, Noise 10 ms, 50 pA, Clusters: 25')

end   

savefilename = [filename '_Test'];
savefilepath = [filepath 'DynamicTests/' savefilename];

disp(savefilepath)

%% Simulation
SimValuesTest = SimulateFrozenNetwork(SimValues)

%% Save Files
save(savefilepath,'SimValuesTest','-v7.3')

end
end