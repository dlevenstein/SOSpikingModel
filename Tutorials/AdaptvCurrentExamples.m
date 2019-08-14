%% Lognormal Network Training
% NOTE: If you already have a trained network, skip this part
% One neuron
PopParams.EPopNum = 2000;
PopParams.IPopNum = 500;

PopParams.Kee   = 250;        %Expected E->E In Degree
PopParams.Kii   = 250;        %Expected I->I In Degree
PopParams.Kie   = 250;        %Expected E->I In Degree
PopParams.Kei   = 250;        %Expected I->E In Degrees

PopParams.m = 1;    %Mean scaling of network
PopParams.s = 10;   %Variance scaling of network

[W,PopParams] = CreateNetwork(PopParams,'EE_type','lognormal','IE_type','uniform');

% NOTE: if want to record the whole simulation set SimTime to 0 and RecordTime to simulation time

timeparms.dt         = 0.05;    %ms, time step
timeparms.SimTime    = 0;       %if want to record the whole simulation set SimTime to 0 and RecordTime to simulation time
timeparms.RecordTime = 1e3; 	

% Input Values

inputparms.I_e       = 250;  %pA, mean input current
inputparms.sigma     = 50;   %pA, noise of input current
inputparms.theta     = 1/10; %time filtration of noise

% Learning Values

learningparms.LearningRate   = 1e-2; %learning rate
learningparms.TargetRateE    = 2;    %Hz, excitatory target rate
learningparms.TargetRateI    = nan;  %Hz, inhibitory target rate (set to nan to turn off training for that connection)
learningparms.tauSTDP        = 20;   %ms, STDP curve

% Train Network

[SimValues,PopParams_in] = TrainNetwork(PopParams,'timeparms',timeparms,'inputparms',...
                                            inputparms,'learningparms',learningparms,'showfig',true);
                                  
%% Run Frozen Network for analysis

[SimValuesTest,PopParams_in] = SimulateFrozenNetwork(SimValues,SimValues.PopParams);

%% Simulate Adapt V Current
% NOTE: Use a trained SimValues Network, and use in this FunctionRoutine

PopParams_in.W  = SimValues.WeightMat(:,:,end);
PopParams_in.V0 = SimValuesTest.V(:,end);
PopParams_in.s0 = SimValuesTest.s(:,end);
PopParams_in.w0 = 0;

Aarray = -2:0.5:4;
Irange = [150 300];
numI   = 20;
modnum = 1;

SimValuesArray = SimulateAdaptvCurrent(PopParams_in,II,modnum,Irange,numI,Aarray,'serverArraySize',1);