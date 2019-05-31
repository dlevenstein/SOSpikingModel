function states = StateDetector(spikes)

mean_rate = length(spikes(:,1)).*(1e3/1e4).*(1/2500);

dt_rate = 5;
overlap = 5;
t_rate = dt_rate:dt_rate:1e4;
rate = hist(spikes(:,1),t_rate);
rate = rate.*(1e3/dt_rate).*(1/2500);
rate = movmean(rate,overlap);

bins = -2:0.5:3;
map = hist(log10(rate),bins);
map = map./sum(map);

search_map = map(bins <= log10(mean_rate));
search_space = bins(bins<=log10(mean_rate));

[c,id] = min(search_map);
if ~isempty(id)
cut_rate = search_space(id);
end

DOWN_lengths = [];
UP_lengths = [];

DOWN_num = 0;
UP_num = 0;

DOWNstates = rate <= 10.^cut_rate;
UPstates = rate > 10.^cut_rate;

DOWNrate = [];
UPrate = [];

meanDOWNrate = [];
meanUPrate = [];

for dd = 1:length(DOWNstates)
    
    if DOWNstates(dd)
        DOWN_num = DOWN_num + dt_rate.*overlap;
        meanDOWNrate = [meanDOWNrate rate(dd)];
    else
        DOWN_lengths = [DOWN_lengths DOWN_num];
        DOWNrate = [DOWNrate,[DOWN_num;mean(meanDOWNrate)]];
        DOWN_num = 0;
        meanDOWNrate = [];
    end
end
DOWN_id = DOWN_lengths==0;
DOWN_lengths(DOWN_id) = [];
DOWNrate(:,DOWN_id) = [];

for uu = 1:length(UPstates)
    if UPstates(uu)
        UP_num = UP_num + dt_rate.*overlap;
        meanUPrate = [meanUPrate rate(uu)];
    else
        UP_lengths = [UP_lengths UP_num];
        UPrate = [UPrate,[UP_num;mean(meanUPrate)]];
        UP_num = 0;
        meanUPrate = [];
    end
end
UP_id = UP_lengths==0;
UP_lengths(UP_id) = [];
UPrate(:,UP_id) = [];

bins = linspace(0,1e3,25);
DOWNmap = hist(DOWN_lengths,bins);
UPmap = hist(UP_lengths,bins);
DOWNmap = DOWNmap./sum(DOWNmap);
UPmap = UPmap./sum(UPmap);

DOWN_mean = mean(DOWN_lengths);
UP_mean = mean(UP_lengths);

DOWN_std = std(DOWN_lengths);
UP_std = std(UP_lengths);

DOWN_CV = std(DOWN_lengths)/mean(DOWN_lengths);
UP_CV = std(UP_lengths)/mean(UP_lengths);

% figure
% plot(bins,DOWNmap,'r')
% hold on
% plot(bins,UPmap,'k')
% hold on
% plot([DOWN_mean DOWN_mean],[0 max(DOWNmap)],'r','LineWidth',2)
% hold on
% plot([UP_mean UP_mean],[0 max(UPmap)],'k','LineWidth',2)
%        
% figure
% subplot(2,2,1)
% plot(DOWNrate(2,:),DOWNrate(1,:),'.k','MarkerSize',10)
% hold on
% plot(mean(DOWNrate(2,:)),mean(DOWNrate(1,:)),'.r','MarkerSize',25)
% xlabel('Rate (Hz)','FontSize',16);ylabel('Duration (ms)','FontSize',16)
% subplot(2,2,3)
% plot(UPrate(2,:),UPrate(1,:),'.k','MarkerSize',10)
% hold on
% plot(mean(UPrate(2,:)),mean(UPrate(1,:)),'.r','MarkerSize',25)
% xlabel('Rate (Hz)','FontSize',16);ylabel('Duration (ms)','FontSize',16)
   
%%
states.mean_rate = mean_rate;
states.rate = rate;
states.cut_rate = 10^cut_rate;

states.UP_mean = UP_mean;
states.UP_std = UP_std;
states.UP_CV = UP_CV;
states.UP_lengths = UP_lengths;

states.DOWN_mean = DOWN_mean;
states.DOWN_std = DOWN_std;
states.DOWN_CV = DOWN_CV;
states.DOWN_lengths = DOWN_lengths;
   
end