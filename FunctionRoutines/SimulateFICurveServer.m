function [] = SimulateFICurveServer(PopParams_in,Irange,numI,datafolder,dataname,varargin)

%% Input options
defaulttimeparms.simtime = 2000; %ms, time to simulate each "trial"
defaulttimeparms.onsettransient = 0; %ms, onsiet transient time to ignore

p = inputParser;
addParameter(p,'bistability',true,@islogical)
addParameter(p,'SaveALL',false,@islogical)
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
parse(p,varargin{:})

bistable = p.Results.bistability;
SaveALL = p.Results.SaveALL;
timeparms = p.Results.timeparms;

Ivals = linspace(Irange(1),Irange(2),numI);

timeparms.onsettransient = 0; %Onset transient to ignore
timeparms.simtime = timeparms.simtime;

TimeParams.dt      = 0.05;

if ~bistable
TimeParams.SimTime = timeparms.simtime;
else
TimeParams.SimTime = timeparms.simtime+500;
end

clear SimValues

parfor ii = 1:numI
    
    ii
    
    PopParamsAnalysis = PopParams_in;
     
    if ~bistable
    PopParamsAnalysis.I_e = @(t) Ivals(ii).*heaviside(t - 500);
    end
    
    if bistable
    PopParamsAnalysis.I_e = @(t) (250 - Ivals(ii)).*heaviside(500 - t)+Ivals(ii);
    end
    
    SimValuesArray(ii) = AdLIFfunction_iSTDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,...
        'save_weights',TimeParams.SimTime,'save_dt',TimeParams.SimTime,'useGPU',false,'defaultNeuronParams',false);

end

for ii = 1:numI
    
    spikes = SimValuesArray(ii).spikes;
    disp([datafolder dataname '_ii_' char(num2str(ii)) '_spikes.mat']);    
    save([datafolder dataname '_ii_' char(num2str(ii)) '_spikes.mat'],'spikes','-v7.3');
    
end

if SaveALL
    save([datafolder dataname '_SimValues.mat'],'SimValuesArray','-v7.3');
end

end
