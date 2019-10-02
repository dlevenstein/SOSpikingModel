function [] = SimulateAdaptvCurrent(simfunction,PopParams_in,Irange,numI,brange,numb,ii,bb,varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS
%   simfunction     simulation function. function should be passed through 
%                   as @SimFunctionName. And should have input/output:
%                   SimValues = simfunction(PopParams,TimeParams)                   
%   PopParams       population parameters structure to pass through to the
%                   simulation function
%   Irange          [min max] input current values
%   (options)

%   'datafolder'     name of folder to save the data
%   'bistableramp'  (true/false) an option to calculate FI curve with
%                   increasing and decreasing input ramps, to test for
%                   bistability/histeresis (NOT YET FUNCTIONAL)
%   'timeparms'     a structure giving timing params for the simulations
%                 .simtime          Duration to simulate 
%                 .onsettransient   Onset transient to ignore
%
%

%% DEV
% simfunction = @EMAdLIFfunction;
% Irange = [150 500];
% numI = 26;

% POP PARMS 4 DEV
% PopParams.EPopNum = 1;
% PopParams.IPopNum = 1;
% PopParams.E_L     = -65;
% PopParams.g_L     = 30;
% PopParams.C       = 281;
% PopParams.V_th    = -55;
% PopParams.V_reset = -85;
% PopParams.E_e     = 0;
% PopParams.E_i     = -80;
% PopParams.E_w     = -70;
% PopParams.b_w     = 0.1;
% PopParams.b_s     = 1;
% PopParams.dw      = 0.2;
% PopParams.ds      = 0.5;
% PopParams.a       = 0.5;
% PopParams.b       = 0.1;
% PopParams.t_ref   = 0.2;
% PopParams.delta_T = 10;
% PopParams.Wee   = 0;
% PopParams.Wii   = 0;
% PopParams.Wie   = 0;
% PopParams.Wei   = 0; 
% PopParams.Kee   = 0;
% PopParams.Kii   = 0;
% PopParams.Kie   = 0;
% PopParams.Kei   = 0;
% PopParams.theta = 1/10;
% PopParams.gwnorm = 0;
% PopParams.w_r = 0.1;
%PopParams.sigma = 0;

%varargin = {};

%% Input options
defaulttimeparms.simtime = 5e4; %ms, time to simulate each "trial"
defaulttimeparms.onsettransient = 100; %ms, onsiet transient time to ignore

p = inputParser;
addParameter(p,'datafolder',[],@ischar)
addParameter(p,'dataname',[],@ischar)
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
parse(p,varargin{:})
datafolder = p.Results.datafolder;
dataname = p.Results.dataname;
timeparms = p.Results.timeparms;

%% Set the parameters
onsettransient = timeparms.onsettransient; %Onset transient to ignore
TimeParams.dt      = 0.05;
TimeParams.SimTime = timeparms.simtime;
%% Run the simulations

Ivals = linspace(Irange(1),Irange(2),numI);
bvals = linspace(brange(1),brange(2),numb);

clear SimValues

disp(['Ival Index: ' char(num2str(ii))])
disp(['bval Index: ' char(num2str(bb))])

PopParms = PopParams_in;

PopParms.I_e = Ivals(ii);
PopParms.b   = bvals(bb);

SimValues = simfunction(PopParms,TimeParams,...
    'showfig',false,'save_dt',1,'save_weights',TimeParams.SimTime,'onsettime',onsettransient,...
    'cellout',true,'showprogress',false);

save([datafolder dataname '_b_' char(num2str(bb)) '_I_' char(num2str(ii)) '.mat'],'SimValues','-v7.3');

end
