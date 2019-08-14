function SimValuesArray = SimulateAdaptvCurrent(PopParams_in,II,modnum,Irange,numI,Aarray,varargin)
%SimulateFICurve Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS                
%   SimValues       Simulation values after a trained simulation
%   PopParams_in    population parameters structure to pass through to the
%                   simulation function
%   modnum          When processing this function across different nodes,
%                   using this variable to refer to which node this 
%                   function is being used
%   Irange          [min max] input current values
%   numI            (number) number of I current values between Irange
%   Aarray          [list] log10(values) for adaptation list
%   (options)
%   'defaultparams' (true/false) default:true. Sets PopParams_in with 
%                   default parameter values.
%   'noise'         (number) default:10. Sets noise in simulation 
%OUTPUTS
%   SimValuesArray  Array of Simulation values from simulation

%% Default Parameters
defaulttimeparms.dt         = 0.05; %ms, time step
defaulttimeparms.SimTime    = 0; %ms, time to simulate
defaulttimeparms.RecordTime = 3e4; %ms, time of recorded values before and after training

defaultinputparms.sigma     = 10;   %pA, noise of input current
defaultinputparms.theta     = 1/10; %time filtration of noise

defaultlearningparms.LearningRate   = 0; %learning rate
defaultlearningparms.TargetRateE    = nan;    %Hz, excitatory target rate
defaultlearningparms.TargetRateI    = nan;  %Hz, inhibitory target rate
defaultlearningparms.tauSTDP        = 20;   %ms, STDP curve

p = inputParser;
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
addParameter(p,'inputparms',defaultinputparms,@isstruct)
addParameter(p,'learningparms',defaultlearningparms,@isstruct)
addParameter(p,'defaultNeuronParams',true,@islogical)
addParameter(p,'serverArraySize',5,@islogical)
parse(p,varargin{:})

timeparms               = p.Results.timeparms;
inputparms              = p.Results.inputparms;
learningparms           = p.Results.learningparms;
defaultNeuronParams     = p.Results.defaultNeuronParams;
serverArraySize         = p.Results.serverArraySize;

%% Learning Parameters
PopParams_in.LearningRate   = learningparms.LearningRate;
PopParams_in.TargetRateE    = learningparms.TargetRateE;
PopParams_in.TargetRateI    = learningparms.TargetRateI;
PopParams_in.tauSTDP        = learningparms.tauSTDP;

%% Noise
PopParams_in.sigma  = inputparms.sigma;        %noise magnitude: variance
PopParams_in.theta  = inputparms.theta;        %noise time scale (1/ms)

%% Times
SimTime         = timeparms.SimTime;
RecordTime      = timeparms.RecordTime;

TimeParams.dt           = timeparms.dt;
TimeParams.RecordTime   = RecordTime;
TimeParams.SimTime      = SimTime+RecordTime;

%%

PopParams_in.V0 = PopParams_in.V0;
PopParams_in.w0 = PopParams_in.w0;
PopParams_in.w0 = PopParams_in.s0;

TimeParams.dt      = timeparms.dt;
TimeParams.SimTime = timeparms.SimTime;

Ivals = linspace(Irange(1),Irange(end),numI);
bvals = 10.^(Aarray);

if mod(II,serverArraySize)+1 == modnum
    
    ii = mod(II,length(Ivals))+1;
    bb = ceil(II/length(Ivals));

    ii
    bb 

    PopParamsAnalysis = PopParams_in;

    I_e = Ivals(ii);
    b = bvals(bb);

    PopParamsAnalysis.I_e = I_e;
    PopParamsAnalysis.b = b;

    SimValuesArray(II) = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',true,'showfig',false,...
        'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',defaultNeuronParams);

end

end