%A script for analysis of single neuron input-output properties in the
%Conductance-based adapting LIF model
%DLevenstein and JGornet

%% Add the approprate folders to the path
%Path of the SOSpikingModel repository
repopath = '/Users/dlevenstein/Project Repos/SOSpikingModel'; 
addpath(genpath(repopath))

%% Define the Population Parameters to feed the FI Cuve function

PopParams.sigma = 50;

%
PopParams.EPopNum = 5;
PopParams.IPopNum = 5;

PopParams.E_L     = -65;
PopParams.g_L     = 30;
PopParams.C       = 281;
PopParams.V_th    = -55;
PopParams.V_reset = -85;

PopParams.E_e     = 0;
PopParams.E_i     = -80;


PopParams.E_w     = -70;
PopParams.b_w     = 0.1;

PopParams.b_s     = 1;

PopParams.dw      = 0.2;
PopParams.ds      = 0.5;

PopParams.a       = 0.5;
PopParams.b       = 0.1;

PopParams.t_ref   = 0.2;
PopParams.delta_T = 10;

PopParams.Wee   = 0;
PopParams.Wii   = 0;
PopParams.Wie   = 0;
PopParams.Wei   = 0; 

PopParams.Kee   = 0;
PopParams.Kii   = 0;
PopParams.Kie   = 0;
PopParams.Kei   = 0;

PopParams.theta = 1/10;

PopParams.gwnorm = 0;

PopParams.w_r = 0.1;

%% Run the FI Curve function
simfunction = @EMAdLIFfunction;
Irange = [150 500];
numI = 11;
[ Ivals,rate ] = SimulateFICurve(simfunction,PopParams,Irange,numI);