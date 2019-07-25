function SimValuesArray = SimulateFICurve(PopParams_in,Irange,numI,varargin)
%SimulateFICurve Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS                
%   PopParams_in    population parameters structure to pass through to the
%                   simulation function
%   Irange          [min max] input current values
%   numI            (number) number of I current values between Irange
%   (options)
%   'showfig'       (true/false) default:true.  can also  pass through 
%                   string to name the figure
%   'figfolder'     name of folder to save the figure
%   'bistableramp'  (true/false) an option to calculate FI curve with
%                   increasing and decreasing input ramps, to test for
%                   bistability/histeresis
%   'timeparms'     a structure giving timing params for the simulations
%                 .simtime          Duration to simulate 
%                 .onsettransient   Onset transient to ignore

%% Default Parameters
defaulttimeparms.dt         = 0.05; %ms, time step
defaulttimeparms.SimTime    = 2000; %ms, time to simulate

defaultinputparms.starting_I_e = 250;  %pA, mean input current
defaultinputparms.sigma     = 0;   %pA, noise of input current
defaultinputparms.theta     = 0; %time filtration of noise

defaultlearningparms.LearningRate   = 0; %learning rate
defaultlearningparms.TargetRateE    = nan;    %Hz, excitatory target rate
defaultlearningparms.TargetRateI    = nan;  %Hz, inhibitory target rate
defaultlearningparms.tauSTDP        = 20;   %ms, STDP curve

p = inputParser;
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
addParameter(p,'inputparms',defaultinputparms,@isstruct)
addParameter(p,'learningparms',defaultlearningparms,@isstruct)
addParameter(p,'bistableramp',true,@islogical)
addParameter(p,'defaultNeuronParams',true,@islogical)
parse(p,varargin{:})

timeparms               = p.Results.timeparms;
inputparms              = p.Results.inputparms;
learningparms           = p.Results.learningparms;
bistableramp            = p.Results.bistableramp;
defaultNeuronParams     = p.Results.defaultNeuronParams;

%% Learning Parameters
PopParams_in.LearningRate   = learningparms.LearningRate;
PopParams_in.TargetRateE    = learningparms.TargetRateE;
PopParams_in.TargetRateI    = learningparms.TargetRateI;
PopParams_in.tauSTDP        = learningparms.tauSTDP;

%% Input Parameters
PopParams_in.starting_I_e = inputparms.starting_I_e;
PopParams_in.sigma   = inputparms.sigma;
PopParams_in.theta   = inputparms.theta;

%% Set parameter spaces

Ivals = linspace(Irange(1),Irange(2),numI);

%% Bistability check
if ~bistableramp
TimeParams.SimTime = timeparms.SimTime; %High -> Low Current
else
TimeParams.SimTime = timeparms.SimTime+500; %Low -> High Current
end

clear SimValues

%% Simulation Loop
parfor ii = 1:numI
    
    ii
    
    PopParamsAnalysis = PopParams_in;
     
    if ~bistableramp
    PopParamsAnalysis.I_e = @(t) Ivals(ii).*heaviside(t - 500);
    end
    
    if bistableramp
    PopParamsAnalysis.I_e = @(t) (PopParams_in.starting_I_e - Ivals(ii)).*heaviside(500 - t)+Ivals(ii);
    end
    
    SimValuesArray(ii) = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,...
        'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',defaultNeuronParams);

end

end
