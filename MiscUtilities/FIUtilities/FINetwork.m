function FINetwork(folderWeights,networkpath,name)

Ivals = linspace(0,400,21);

%%
clear Network

for ww = 1:length(folderWeights)

%cd '/Users/jonathangornet/Google Drive/Computational_Neuroscience/FI_Analysis/ExperimentRate/'

cd(networkpath)

cd(char(folderWeights(ww)))

lastTimes = nan(21,100);

for ii = 1:21

% path = ['/Users/jonathangornet/Google Drive/Computational_Neuroscience/FI_Analysis/ExperimentRate/figures/' char(folderWeights(ww)) '/'];
% name = 'ExperimentRate';

path = [networkpath '/figures/' char(folderWeights(ww)) '/'];

folder = ['I_' num2str(ii)];

cd(folder)

[r,w,h,l,S] = FIfigures(ii,name,path);

lastTimes(ii,:) = l;

cd ..

%close all

rate.E(ii) = r.E;
rate.I(ii) = r.I; 

width.E(ii) = w.E;
width.I(ii) = w.I;

height.E(ii) = h.E;
height.I(ii) = h.I;

end

map = zeros(21,25);
bins = linspace(0,3.5,25);

for ii = 1:21
    map(ii,:) = hist(log10(lastTimes(ii,:)),bins);
end
        
Network(ww).rate = rate;
Network(ww).width = width;
Network(ww).height = height;
Network(ww).map = map;

end

if ~exist([networkpath '/figures'],'dir')
    mkdir([networkpath '/figures'])
end

save([networkpath '/figures/NetworkProperties'],'Network','-v7.3')

end
% %%
% figure
% subplot(3,2,1)
% plot(Ivals,log10(Network(2).rate.E),'.-b','markersize',10)
% hold on
% plot(Ivals,log10(Network(2).rate.I),'.-r','markersize',10)
% xlabel('Current (pA)');ylabel('Rate (Hz)')
% LogScale('y',10);xlim([0 400])
% 
% subplot(3,2,2)
% A = repmat(1,size(map'));
% A(map'==0) = 0;
% imagesc(Ivals,bins,map')
% set(gca,'ydir','normal')
% alpha(A)
% xlabel('Current (pA)');ylabel('Time (ms)')
% LogScale('y',10)
% 
% NiceSave([name 'FIrate'],path,[]);
% 
% figure
% subplot(3,2,1)
% plot(Ivals,log10(height.E),'.-b','markersize',10)
% hold on
% plot(Ivals,log10(height.I),'.-r','markersize',10)
% xlabel('Current (pA)');ylabel('Rate (Hz)')
% LogScale('y',10);xlim([0 400])
% subplot(3,2,2)
% plot(Ivals,width.E,'.-b','markersize',10)
% hold on
% plot(Ivals,width.I,'.-r','markersize',10)
% xlim([0 400]);ylim([0 inf])
% xlabel('Current (pA)');ylabel('Time (ms)')
% 
% NiceSave([name 'FI_CCG'],path,[]);
