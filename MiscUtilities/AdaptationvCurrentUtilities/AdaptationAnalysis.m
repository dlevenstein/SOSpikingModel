function analyzedVals = AdaptationAnalysis(path,Irange,numI,barray)

%analyzedVals = AdaptationAnalysis(path,Irange,numI,barray)
%combs through all folders with adaptation v current simulations and 
%calculates UP and DOWN states
%
%INPUTS
%   path            location of files
%   Irange          range of current values
%   numI            number of I values
%   barray          log10 array of b values
%
%OUTPUTS
%   analyzedVals
%       .t_rate             time of rate
%       .mean_rate          mean rate over all simulation
%       .rate               time series of rate
% 
%       .UP_duration   mean time of UP states
%       .UP_std_duration    std time of UP states
%       .UP_CV_duration     CV time of UP states
%       .UP_prob            probability of being in an UP state over time
%       .UP_mean_rate       mean rate of UP state
% 
%       .DOWN_duration mean time of DOWN states
%       .DOWN_std_duration  std time of DOWN states
%       .DOWN_CV_duration   CV time of DOWN states
%       .DOWN_prob          probability of being in an DOWN state over time
% 
%       .adaptation         time series of adaptation
%       .meanAdaptation     mean adaptation over simulation time

%JGornet Summer 2019

%%

mapIvals = linspace(Irange(1),Irange(end),numI);
mapbvals = 10.^(barray);

S = cell(length(mapIvals),length(mapbvals));

%%
for ii = 1:length(mapIvals)
for bb = 1:length(mapbvals)
    
    filename = [path 'AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat'];
    
    try
        load(filename)
        spikes=spikes(spikes(:,1)>1e4,:);
        spikes(:,1) = spikes(:,1)-1e4;
        S{ii,bb} = spikes;
    catch
        disp(filename)    
    end
    
end
end

%%
DOWN_CV = zeros(length(mapIvals),length(mapbvals));
DOWN_duration = zeros(length(mapIvals),length(mapbvals));
DOWN_prob = zeros(length(mapIvals),length(mapbvals));

UP_CV = zeros(length(mapIvals),length(mapbvals));
UP_duration = zeros(length(mapIvals),length(mapbvals));
UP_prob = zeros(length(mapIvals),length(mapbvals));
UP_rate = zeros(length(mapIvals),length(mapbvals));

meanRateMap = zeros(length(mapIvals),length(mapbvals));

meanAdaptation = zeros(length(mapIvals),length(mapbvals));

for ii = 1:length(mapIvals)
parfor bb = 1:length(mapbvals)
    
    spikes = S{ii,bb};
    if ~isnan(spikes)
        
    states = StateDetector(spikes,1e4,2500,mapbvals(bb));
    
    DOWN_CV(ii,bb) = states.DOWN_CV_duration;
    DOWN_duration(ii,bb) = states.DOWN_mean_duration;
    DOWN_prob(ii,bb) = states.DOWN_prob;
    
    UP_CV(ii,bb) = states.UP_CV_duration;
    UP_duration(ii,bb) = states.UP_mean_duration;
    UP_prob(ii,bb) = states.UP_prob;
    UP_rate(ii,bb) = states.UP_mean_rate;
   
    meanRateMap(ii,bb) = states.mean_rate;
             
    meanAdaptation(ii,bb) = states.meanAdaptation;
    
    end
    
end
end

analyzedVals.DOWN_CV = DOWN_CV;
analyzedVals.DOWN_duration = DOWN_duration;
analyzedVals.DOWN_prob = DOWN_prob;

analyzedVals.UP_CV = UP_CV;
analyzedVals.UP_duration = UP_duration;
analyzedVals.UP_prob = UP_prob;
analyzedVals.UP_rate = UP_rate;

analyzedVals.meanRateMap = meanRateMap;
analyzedVals.meanAdaptation = meanAdaptation;

end
