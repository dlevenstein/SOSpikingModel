function states = StateDetector(spikes,endtime,bval,varargin)

p = inputParser;
addParameter(p,'showfig',false,@islogical)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;

%%

mean_rate = length(spikes(:,1)).*(1e3/endtime).*(1/2500);

dt_rate = 10;
overlap = 5;
t_rate = dt_rate:dt_rate:endtime;
rate = hist(spikes(:,1),t_rate);
rate = rate.*(1e3/dt_rate).*(1/2500);
rate = movmean(rate,overlap);

ISI = [diff(spikes(:,1));0];

% bins = -2:0.5:3;
% map = hist(log10(rate),bins);
% map = map./sum(map);
% 
% search_map = map(bins <= log10(mean_rate));
% search_space = bins(bins<=log10(mean_rate));
% 
% [c,id] = min(search_map);
% if ~isempty(id)
% cut_rate = search_space(id);
% end

% DOWN_lengths = [];
% UP_lengths = [];
% 
% DOWN_num = 0;
% UP_num = 0;

% DOWNstates = rate <= 10.^cut_rate;
% UPstates = rate > 10.^cut_rate;

% DOWNrate = [];
% UPrate = [];
% 
% meanUPrate = [];
% 
% UPrateMean = [];

%[thresh,cross,bihist,diptest] = bz_BimodalThresh(rate);
[thresh,cross,bihist,ISIdiptest] = bz_BimodalThresh(ISI);

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

% for dd = 1:length(DOWNstates)
%     
%     if DOWNstates(dd)
%         DOWN_num = DOWN_num + dt_rate;
%     else
%         if DOWN_num > thresh
%             correctedDOWNstates(DOWN_index:dd) = 1;
%             DOWN_lengths = [DOWN_lengths DOWN_num];
%             DOWN_num = 0;
%             meanDOWNrate = [];
%         else
%             DOWN_num = 0;
%             meanDOWNrate = [];
%         end
%         DOWN_index = dd;
%     end
% end

% DOWN_id = DOWN_lengths==0;
% DOWN_lengths(DOWN_id) = [];
% DOWNrate(:,DOWN_id) = [];

% for uu = 1:length(DOWNstates)
%     if ~DOWNstates(uu)
%         UP_num = UP_num + dt_rate;
%         meanUPrate = [meanUPrate rate(uu)];
%     else
%         UP_lengths = [UP_lengths UP_num];
%         UPrate = [UPrate,[UP_num;mean(meanUPrate)]];
%         UPrateMean = [UPrateMean,mean(meanUPrate)];
%         UP_num = 0;
%         meanUPrate = [];
%     end
% end
% UP_id = UP_lengths==0;
% UP_lengths(UP_id) = [];
% UPrate(:,UP_id) = [];

% bins = linspace(-1,4,50);
% DOWNmap = hist(log10(DOWN_lengths),bins);
% UPmap = hist(log10(UP_lengths),bins);
% DOWNmap = DOWNmap./sum(DOWNmap);
% UPmap = UPmap./sum(UPmap);
% 
% DOWN_mean = mean(DOWN_lengths);
% UP_mean = mean(UP_lengths);
% 
% DOWN_std = std(DOWN_lengths);
% UP_std = std(UP_lengths);
% 
% DOWN_CV = std(DOWN_lengths)/mean(DOWN_lengths);
% UP_CV = std(UP_lengths)/mean(UP_lengths);

adaptation = conv(rate,bval.*exp(-t_rate./300));
adaptation = adaptation(1:length(t_rate));
meanAdaptation = mean(adaptation);

if SHOWFIG

figure
plot(bins,DOWNmap,'r')
hold on
plot(bins,UPmap,'k')
% hold on
% plot([DOWN_mean DOWN_mean],[0 max(DOWNmap)],'r','LineWidth',2)
% hold on
% plot([UP_mean UP_mean],[0 max(UPmap)],'k','LineWidth',2)
xlabel('Duration (ms)','FontSize',16);ylabel('Probability','FontSize',16);legend('DOWN Duration','UP Duration')
LogScale('x',10)

%NiceSave(['DurationDist' figindex],path,[])
%close all

if ~isempty(UPrate)
figure
subplot(2,2,1)
plot(UPrate(2,:),log10(UPrate(1,:)),'.k','MarkerSize',10)
xlabel('Rate (Hz)','FontSize',16);ylabel('Duration (ms)','FontSize',16)
LogScale('y',10)

%NiceSave(['DurationVRate' figindex],path,[])
%close all
end

end

%%
states.mean_rate = mean_rate;
states.rate = rate;
% states.cut_rate = 10^cut_rate;
% states.bins = bins;

states.UP_mean_duration = UP_mean_duration;
states.UP_std_duration = UP_std_duration;
states.UP_CV_duration = UP_CV_duration;
states.UP_prob = sum(UPlengths)./endtime;
% states.UP_rate = nanmean(UPrateMean);
% states.UPmap = UPmap;
states.UP_mean_rate = UP_mean_rate;

states.DOWNstates = DOWNstates;
states.DOWN_mean_duration = DOWN_mean_duration;
states.DOWN_std_duration = DOWN_std_duration;
states.DOWN_CV_duration = DOWN_CV_duration;
% states.DOWN_lengths = DOWN_lengths;
states.DOWN_prob = sum(ISI(DOWNstates))./endtime;
% states.DOWNmap = DOWNmap;
% states.DOWNrate = DOWNrate;

% states.dip = diptest.dip;
% states.p = diptest.p_value;

% states.ISIdip = ISIdiptest.dip;
% states.ISIp = ISIdiptest.p_value;

states.adaptation = adaptation;
states.meanAdaptation = meanAdaptation;

states.t_rate = t_rate;

end