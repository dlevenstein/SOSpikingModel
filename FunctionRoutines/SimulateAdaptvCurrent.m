function SimValuesArray = SimulateAdaptvCurrent(SimValues,PopParams_in,modnum,Irange,numI,Aarray,varargin)
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

p = inputParser;
addParameter(p,'defaultparams',true,@islogical)
parse(p,varargin{:})

defaultparams = p.Results.defaultparams;

if defaultparams
    PopParams_in.EPopNum = 2000;
    PopParams_in.IPopNum = 500;

    PopParams_in.I_e  = 0;       %External input
    PopParams_in.sigma = 0;        %niose magnitude: variance
    PopParams_in.theta = 0.1;        %noise time scale (1/ms)

    %Neuron properties
    PopParams_in.E_L     = [-65 -67];    %rev potential: leak (mV)
    PopParams_in.g_L     = [182/18 119/8];     %leak conductance (nS)
    PopParams_in.C       = [182 119];    %capacitance (pF)
    PopParams_in.V_th    = [-45 -47];    %spike threshold (mV)
    PopParams_in.V_reset = [-55 -55];    %reset potential (mV)
    PopParams_in.t_ref   = 0.5;    %refractory period (ms)

    %Synaptic Properties
    PopParams_in.E_e     = 0;      %rev potential: E (mV)
    PopParams_in.E_i     = -80;    %rev potential: I (mV)
    PopParams_in.tau_s   = [5 5];      %synaptic decay timescale (1/ms)

    %Adaptation Properties (No adaptation)
    PopParams_in.E_w     = -70;    %rev potential: adaptation (mV)
    PopParams_in.a       = 0;   %adaptation decay timescale (1/ms)
    PopParams_in.b       = 0;    %adaptation activation rate (1/ms)
    PopParams_in.tau_w   = 300;     %subthreshold adaptation steepness
    PopParams_in.gwnorm  = 0;       %magnitude of adaptation

    PopParams_in.t_syn = 0;

    PopParams_in.LearningRate = 0;
    PopParams_in.TargetRateI = nan; %Target E rate 1Hz
    PopParams_in.TargetRateE = nan; %Target I rate 1Hz
    PopParams_in.tauSTDP = 20;
end
%%

PopParams_in = PopParams_in;
PopParams_in.LearningRate = 0;
PopParams_in.sigma = 10;
PopParams_in.W = SimValues.WeightMat(:,:,end);
PopParams_in.gwnorm = PopParams_in.g_L(1);
PopParams_in.t_syn = 0;

PopParams_in.V0 = min(PopParams_in.E_L) + (min(PopParams_in.V_th)-min(PopParams_in.E_L)).*rand(PopParams_in.EPopNum + PopParams_in.IPopNum,1);
PopParams_in.w0 = 100.*rand(2500,1);

TimeParams.dt      = 0.05;
TimeParams.SimTime = 3e4;

Ivals = linspace(Irange(1),Irange(end),numI);
bvals = 10.^(Aarray);

for II = 1:(length(Ivals)*length(bvals))
    
if mod(II,10)+1 == modnum
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
    'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false);

end

end