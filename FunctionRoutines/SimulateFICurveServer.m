function [] = SimulateFICurveServer(PopParams_in,Irange,numI,datafolder,dataname,varargin)

%% Input options
defaulttimeparms.simtime = 2000; %ms, time to simulate each "trial"
defaulttimeparms.onsettransient = 0; %ms, onsiet transient time to ignore

p = inputParser;
addParameter(p,'up',true,@islogical)
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
parse(p,varargin{:})

UP = p.Results.up;
timeparms = p.Results.timeparms;

Ivals = linspace(Irange(1),Irange(2),numI);

timeparms.onsettransient = 0; %Onset transient to ignore
timeparms.simtime = timeparms.simtime;

TimeParams.dt      = 0.05;

if UP
TimeParams.SimTime = timeparms.simtime;
else
TimeParams.SimTime = timeparms.simtime+1e3;
end

clear SimValues

parfor ii = 1:numI
    
    ii
    
    rng(ii,'twister');

    PopParamsAnalysis = PopParams_in;
    PopParamsAnalysis.V0 = min(PopParamsAnalysis.E_L) + (max(PopParamsAnalysis.E_L)-min(PopParamsAnalysis.E_L)).*rand(PopParams.EPopNum + PopParams.IPopNum,1);
    
    if UP
    PopParamsAnalysis.I_e = Ivals(ii);
    end
    
    if UP == false
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
    
    save([datafolder dataname '_ii_' char(num2str(ii)) '_spikes.mat'],'spikes','-v7.3');
    save([datafolder dataname '_ii_' char(num2str(ii)) '_SimValues.mat'],'-struct','SimValues','-v7.3');
    
    if UP == false
        lastSpikeTimes(ii) = SimValuesArray(ii).spikes(end,1) - 1e3;
    end
        
end

if UP == false
    save([datafolder dataname '_lastSpikeTimes.mat'],'lastSpikeTimes','-v7.3'); 
end

end
