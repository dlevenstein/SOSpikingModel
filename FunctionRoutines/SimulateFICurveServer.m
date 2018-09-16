function [] = SimulateFICurveServer(PopParams_in,Irange,numI,datafolder,dataname,varargin)

%% Input options
defaulttimeparms.simtime = 3000; %ms, time to simulate each "trial"
defaulttimeparms.onsettransient = 0; %ms, onsiet transient time to ignore

p = inputParser;
addParameter(p,'ramp','UP',@ischar)
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
parse(p,varargin{:})

RAMP = p.Results.ramp;
timeparms = p.Results.timeparms;

Ivals = linspace(Irange(1),Irange(2),numI);

timeparms.onsettransient = 0; %Onset transient to ignore
timeparms.simtime = 1000 + timeparms.simtime;

onsettransient = timeparms.onsettransient; %Onset transient to ignore

TimeParams.dt      = 0.05;

if RAMP == 'UP'
TimeParams.SimTime = timeparms.simtime;
else
TimeParams.SimTime = timeparms.simtime+1e3;
end

clear SimValues

parfor ii = 1:numI
    
    ii
    
    PopParamsAnalysis = PopParams_in;
    
    if RAMP == 'UP'
    PopParamsAnalysis.I_e = Ivals(ii);
    end
    
    if RAMP == 'DOWN'
    PopParamsAnalysis.I_e = @(t) (Ivals(numI) - Ivals(ii)).*heaviside(1000 - t)+Ivals(ii);
    end
    
    SimValuesArray(ii) = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_weights',TimeParams.SimTime);
    
end

lastSpikeTimes = nan(numI,1);

for ii = 1:numI
    
    SimValues = SimValuesArray(ii);
    spikes = SimValuesArray(ii).spikes;
    
    disp([datafolder dataname '_ii_' char(num2str(ii)) '_spikes.mat']);
    disp([datafolder dataname '_ii_' char(num2str(ii)) '_SimValues.mat']);
    
    save([datafolder dataname '_spikes.mat'],'spikes','-v7.3');
    save([datafolder dataname '_SimValues.mat'],'-struct','SimValues','-v7.3');
    
    if RAMP == 'DOWN'
        lastSpikeTimes(ii) = SimValuesArray(ii).spikes(end,1) - 1e3;
    end
        
end

if RAMP == 'DOWN'
    save([datafolder dataname '_lastSpikeTimes.mat'],'lastSpikeTimes','-v7.3'); 
end

end
