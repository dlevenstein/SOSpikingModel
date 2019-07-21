function states = StateDetector(spikes,endtime,num_neurons,bval)

%states = StateDetector(spikes,endtime,num_neurons,bval)
%takes spike data and calculates the UP and DOWN states from ISIs
%
%INPUTS
%   spikes          vector of spike times and ID
%   endtime         total time of simulation
%   num_neurons     number of neurons in simulation
%   bval            adaptation parameter b value
%
%OUTPUTS
%   states          
%       .t_rate             time of rate
%       .mean_rate          mean rate over all simulation
%       .rate               time series of rate
% 
%       .UP_mean_duration   mean time of UP states
%       .UP_std_duration    std time of UP states
%       .UP_CV_duration     CV time of UP states
%       .UP_prob            probability of being in an UP state over time
%       .UP_mean_rate       mean rate of UP state
% 
%       .DOWNstates         locations of detected DOWN states
%       .DOWN_mean_duration mean time of DOWN states
%       .DOWN_std_duration  std time of DOWN states
%       .DOWN_CV_duration   CV time of DOWN states
%       .DOWN_prob          probability of being in an DOWN state over time
% 
%       .adaptation         time series of adaptation
%       .meanAdaptation     mean adaptation over simulation time
% 
%       .thresh             threshold of time series

%JGornet Summer 2019

%%

mean_rate = length(spikes(:,1)).*(1e3/endtime).*(1/num_neurons);

dt_rate = 10;
overlap = 5;
t_rate = dt_rate:dt_rate:endtime;
rate = hist(spikes(:,1),t_rate);
rate = rate.*(1e3/dt_rate).*(1/num_neurons);
rate = movmean(rate,overlap);

ISI = [diff(spikes(:,1));0];

thresh = 10.^1.3617;

DOWNstates = ISI > thresh;

for dd = 1:length(DOWNstates)
    
    if DOWNstates(dd)
        if dd+1 < length(DOWNstates) && dd-1 > 0
            if DOWNstates(dd-1) == 0
                DOWNstates(dd+1) = 1;
            end
        end
    elseif dd+1 < length(DOWNstates) && dd-1 > 0
        if DOWNstates(dd+1) && DOWNstates(dd-1)
            DOWNstates(dd)=1;
        end
    end
    
end

DOWN_mean_duration = mean(ISI(DOWNstates));
DOWN_std_duration = std(ISI(DOWNstates));
DOWN_CV_duration = DOWN_std_duration./DOWN_mean_duration;

UPnum = 0;
UPlengths = [];
num_spikes = 0;
UPrate = [];

for uu = 1:length(DOWNstates)
    
    if ~DOWNstates(uu)
        UPnum = UPnum + ISI(uu);
        num_spikes = num_spikes + 1;
    elseif UPnum ~= 0
        UPlengths = [UPlengths UPnum];
        UPrate = [UPrate num_spikes/UPnum];
        num_spikes = 0;
        UPnum = 0;
    end
    
end

UP_mean_duration = mean(UPlengths);
UP_std_duration = std(UPlengths);
UP_CV_duration = UP_std_duration./UP_mean_duration;

UP_mean_rate = mean(UPrate);

adaptation = conv(rate,bval.*exp(-t_rate./300));
adaptation = adaptation(1:length(t_rate));
meanAdaptation = mean(adaptation);

bins = linspace(1,4,25);
DOWNmap = hist(log10(ISI(DOWNstates)),bins);
DOWNmap = DOWNmap./sum(DOWNmap);
UPmap = hist(log10(UPlengths),bins);
UPmap = UPmap./sum(UPmap);

%%

states.t_rate = t_rate;
states.mean_rate = mean_rate;
states.rate = rate;
states.bins = bins;

states.UP_mean_duration = UP_mean_duration;
states.UP_std_duration = UP_std_duration;
states.UP_CV_duration = UP_CV_duration;
states.UP_prob = sum(UPlengths)./endtime;
states.UP_mean_rate = UP_mean_rate;
states.UPmap = UPmap;
states.UPlengths = UPlengths;
states.UPrate = UPrate;

states.DOWNstates = DOWNstates;
states.DOWN_mean_duration = DOWN_mean_duration;
states.DOWN_std_duration = DOWN_std_duration;
states.DOWN_CV_duration = DOWN_CV_duration;
states.DOWN_prob = sum(ISI(DOWNstates))./endtime;
states.DOWNmap = DOWNmap;

states.adaptation = adaptation;
states.meanAdaptation = meanAdaptation;

states.thresh = thresh;

end