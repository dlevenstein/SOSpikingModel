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
    
    PopParamsAnalysis = PopParams_in;
     
    if UP
    PopParamsAnalysis.I_e = Ivals(ii);
    end
    
    if UP == false
    PopParamsAnalysis.I_e = @(t) (250 - Ivals(ii)).*heaviside(1000 - t)+Ivals(ii);
    end
    
    SimValuesArray(ii) = AdLIFfunction_STDP(PopParamsAnalysis,TimeParams,'cellout',true,'showprogress',false,'showfig',false,'save_dt',1,'save_weights',TimeParams.SimTime);
    
end

lastSpikeTimes = nan(numI,1);

for ii = 1:numI
    
    %V = SimValuesArray(ii).V;
    spikes = SimValuesArray(ii).spikes;
    
    disp([datafolder dataname '_ii_' char(num2str(ii)) '_spikes.mat']);
    %disp([datafolder dataname '_ii_' char(num2str(ii)) '_voltages.mat']);
    
    save([datafolder dataname '_ii_' char(num2str(ii)) '_spikes.mat'],'spikes','-v7.3');
    %save([datafolder dataname '_ii_' char(num2str(ii)) '_voltages.mat'],'V','-v7.3');
         
end

end
