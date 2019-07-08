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

%% Input options
defaulttimeparms.simtime = 2000; %ms, time to simulate each "trial"
defaulttimeparms.onsettransient = 0; %ms, onsiet transient time to ignore

p = inputParser;
addParameter(p,'bistability',true,@islogical)
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
parse(p,varargin{:})

bistability = p.Results.bistability;
timeparms = p.Results.timeparms;

%% Set parameter spaces

Ivals = linspace(Irange(1),Irange(2),numI);

timeparms.onsettransient = 0; %Onset transient to ignore
timeparms.simtime = timeparms.simtime;

TimeParams.dt      = 0.05;

%% Bistability check
if ~bistableramp
TimeParams.SimTime = timeparms.simtime; %High -> Low Current
else
TimeParams.SimTime = timeparms.simtime+500; %Low -> High Current
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
    PopParamsAnalysis.I_e = @(t) (250 - Ivals(ii)).*heaviside(500 - t)+Ivals(ii);
    end
    
    SimValuesArray(ii) = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,...
        'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false);

end

end
