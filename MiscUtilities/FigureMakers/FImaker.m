function FImaker(startpath,figurepath,indices,folders,legendnames)

Erate = zeros(length(folders),21);
Irate = zeros(length(folders),21);

Epeakwidth = zeros(length(folders),21);
Ipeakwidth = zeros(length(folders),21);

Epeakheight = zeros(length(folders),21);
Ipeakheight = zeros(length(folders),21);

EndSpikes = nan(length(folders),21,110);

FIspikes = cell(length(folders),21);

for ff = 1:length(folders)
    
    cd([startpath char(folders(ff))])
    
    for II = 1:21
        
        cd(['I_' char(num2str(II))])
        
        path = [figurepath char(folders(ff))];
            
        [rate,peakwidth,peakheight,lastspikes,S] = FIfigures(II,path);
        
%         FIspikes{ff,II} = S;

        Erate(ff,II) = rate.E;
        Irate(ff,II) = rate.I;

%         Epeakwidth(ff,II) = peakwidth.E;
%         Ipeakwidth(ff,II) = peakwidth.I;
%         
%         Epeakheight(ff,II) = peakheight.E;
%         Ipeakheight(ff,II) = peakheight.I;

        EndSpikes(ff,II,1:length(lastspikes)) = lastspikes;
        
        cd([startpath char(folders(ff))])
        
    end
    
    cd(startpath)
    
end

Ivals = linspace(0,400,21);

%%
% Erate = csvread('Erates.csv');
% Irate = csvread('Irates.csv');
% 
% Epeakwidth = csvread('Epeakwidth.csv');
% Ipeakwidth = csvread('Ipeakwidth.csv');
% 
% Epeakheight = csvread('Epeakheight.csv');
% Ipeakheight = csvread('Ipeakheight.csv');

%% Rates

figure

%--------------------------------------------------------------------------

pos = [0.1 0.70 0.5 0.25];
subplot('Position',pos)

plot(Ivals,log10(Erate(indices(1),:)),'.-b','linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Irate(indices(1),:)),'.-r','linewidth',2,'markersize',25)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 400])
ylabel('Rate (Hz)','FontSize',20)

set(gca,'xticklabel',[]);xlim([0 400])

%--------------------------------------------------------------------------

pos = [0.1 0.40 0.5 0.25];
subplot('Position',pos)

plot(Ivals,log10(Erate(indices(2),:)),'.-b','linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Irate(indices(2),:)),'.-r','linewidth',2,'markersize',25)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 400])
ylabel('Rate (Hz)','FontSize',20)

set(gca,'xticklabel',[]);xlim([0 400])

%--------------------------------------------------------------------------

pos = [0.1 0.1 0.5 0.25];
subplot('Position',pos)

plot(Ivals,log10(Erate(indices(3),:)),'.-b','linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Irate(indices(3),:)),'.-r','linewidth',2,'markersize',25)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 400])
ylabel('Rate (Hz)','FontSize',20)
xlabel('Current (pA)','FontSize',20)

NiceSave('FI_Rates',figurepath,[])

% %% Peak Widths
% 
% figure
% 
% %--------------------------------------------------------------------------
% 
% pos = [0.1 0.70 0.5 0.25];
% subplot('Position',pos)
% 
% plot(Ivals,Epeakwidth(indices(1),:),'.-b','linewidth',2,'markersize',25)
% hold on
% plot(Ivals,Ipeakwidth(indices(1),:),'.-r','linewidth',2,'markersize',25)
% 
% AX = get(gca,'XAxis');
% set(AX,'FontSize', 16)
% AX = get(gca,'YAxis');
% set(AX,'FontSize', 16)
% 
% ylabel('Time (ms)','FontSize',20);xlim([0 400]) 
% 
% set(gca,'xticklabel',[]);xlim([0 400])
% 
% %--------------------------------------------------------------------------
% 
% pos = [0.1 0.40 0.5 0.25];
% subplot('Position',pos)
% 
% plot(Ivals,Epeakwidth(indices(2),:),'.-b','linewidth',2,'markersize',25)
% hold on
% plot(Ivals,Ipeakwidth(indices(2),:),'.-r','linewidth',2,'markersize',25)
% 
% AX = get(gca,'XAxis');
% set(AX,'FontSize', 16)
% AX = get(gca,'YAxis');
% set(AX,'FontSize', 16)
% 
% ylabel('Time (ms)','FontSize',20);xlim([0 400]) 
% 
% set(gca,'xticklabel',[]);xlim([0 400])
% 
% %--------------------------------------------------------------------------
% 
% pos = [0.1 0.1 0.5 0.25];
% subplot('Position',pos)
% 
% plot(Ivals,Epeakwidth(indices(3),:),'.-b','linewidth',2,'markersize',25)
% hold on
% plot(Ivals,Ipeakwidth(indices(3),:),'.-r','linewidth',2,'markersize',25)
% 
% AX = get(gca,'XAxis');
% set(AX,'FontSize', 16)
% AX = get(gca,'YAxis');
% set(AX,'FontSize', 16)
% 
% ylabel('Time (ms)','FontSize',20);xlim([0 400])
% xlabel('Current (pA)','FontSize',20)
% 
% NiceSave('FI_Widths',figurepath,[])
% 
% %% Peak Heights
% 
% figure
% 
% %--------------------------------------------------------------------------
% 
% pos = [0.1 0.70 0.5 0.25];
% subplot('Position',pos)
% 
% plot(Ivals,log10(Epeakheight(indices(1),:)),'.-b','linewidth',2,'markersize',25)
% hold on
% plot(Ivals,log10(Ipeakheight(indices(1),:)),'.-r','linewidth',2,'markersize',25)
% 
% AX = get(gca,'XAxis');
% set(AX,'FontSize', 16)
% AX = get(gca,'YAxis');
% set(AX,'FontSize', 16)
% 
% LogScale('y',10);xlim([0 400])
% ylabel('Rate (Hz)','FontSize',20)
% 
% set(gca,'xticklabel',[]);xlim([0 400])
% 
% %--------------------------------------------------------------------------
% 
% pos = [0.1 0.4 0.5 0.25];
% subplot('Position',pos)
% 
% plot(Ivals,log10(Epeakheight(indices(2),:)),'.-b','linewidth',2,'markersize',25)
% hold on
% plot(Ivals,log10(Ipeakheight(indices(2),:)),'.-r','linewidth',2,'markersize',25)
% 
% AX = get(gca,'XAxis');
% set(AX,'FontSize', 16)
% AX = get(gca,'YAxis');
% set(AX,'FontSize', 16)
% 
% LogScale('y',10);xlim([0 400])
% ylabel('Rate (Hz)','FontSize',20)
% 
% set(gca,'xticklabel',[]);xlim([0 400])
% 
% %--------------------------------------------------------------------------
% 
% pos = [0.1 0.1 0.5 0.25];
% subplot('Position',pos)
% 
% plot(Ivals,log10(Epeakheight(indices(3),:)),'.-b','linewidth',2,'markersize',25)
% hold on
% plot(Ivals,log10(Ipeakheight(indices(3),:)),'.-r','linewidth',2,'markersize',25)
% 
% AX = get(gca,'XAxis');
% set(AX,'FontSize', 16)
% AX = get(gca,'YAxis');
% set(AX,'FontSize', 16)
% 
% LogScale('y',10);xlim([0 400])
% ylabel('Rate (Hz)','FontSize',20)
% xlabel('Current (pA)','FontSize',20)
% 
% NiceSave('FI_Height',figurepath,[])

%% Map

B = 50;
map = zeros(12,B,length(folders));

M = nan(length(folders),12);

for ff = 1:length(folders)
    
    for II = 1:12
        
        map(II,:,ff) = hist(log10(squeeze(EndSpikes(ff,II,:))),linspace(0,3.5,B));
        if sum(map(II,:,ff)) > 0
        map(II,:,ff) = map(II,:,ff)./sum(map(II,:,ff));
        M(ff,II) = max(map(II,:,ff));
        end
        
    end
    
end

M(find(M == 1)) = nan;
colormaxes = zeros(length(folders),1);

for ff = 1:length(folders)
    if all(isnan(M(ff,:)))
        colormaxes(ff) = 1;
    else
        colormaxes(ff) = nanmax(M(ff,:));
    end
end

%%

figure

%--------------------------------------------------------------------------

pos = [0.1 0.64 0.5 0.25];
subplot('Position',pos)

A = repmat(1,size(map(:,:,indices(1))));
A(map(:,:,indices(1)) == 0) = 0; 

imagesc(Ivals(1:12),linspace(0,3.5,B),map(:,:,indices(1))')
set(gca,'ydir','normal')
colorbar
clim([0 colormaxes(indices(1))])
alpha(A')

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 220])
ylabel('Time (ms)','FontSize',20);xlim([0 220]) 

set(gca,'xticklabel',[]);xlim([0 220])

%--------------------------------------------------------------------------

pos = [0.1 0.37 0.5 0.25];
subplot('Position',pos)

A = repmat(1,size(map(:,:,indices(2))));
A(map(:,:,indices(2)) == 0) = 0; 

imagesc(Ivals(1:12),linspace(0,3.5,B),map(:,:,indices(2))')
set(gca,'ydir','normal')
colorbar
clim([0 colormaxes(indices(2))])
alpha(A')

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 220])
ylabel('Time (ms)','FontSize',20);xlim([0 220]) 

set(gca,'xticklabel',[]);xlim([0 220])

%--------------------------------------------------------------------------

pos = [0.1 0.1 0.5 0.25];
subplot('Position',pos)

A = repmat(1,size(map(:,:,indices(3))));
A(map(:,:,indices(3)) == 0) = 0; 

imagesc(Ivals(1:12),linspace(0,3.5,B),map(:,:,indices(3))')
set(gca,'ydir','normal')
colorbar
clim([0 colormaxes(indices(3))])
alpha(A')

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 220])
ylabel('Time (ms)','FontSize',20);xlim([0 220]) 
xlabel('Current (pA)','FontSize',20)

NiceSave('FI_Map',figurepath,[])

%% Rate Excitatory

figure

pos = [0.1,0.55,0.8,0.4];
subplot('position',pos);

plot(Ivals,log10(Erate(indices(1),:)),'.-','Color',[0.7 0.7 1],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Erate(indices(2),:)),'.-','Color',[0.3 0.3 1],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Erate(indices(3),:)),'.-','Color',[0 0 0.5],'linewidth',2,'markersize',25)
%ylim([-1 2])
LogScale('y',10);xlim([0 400])
set(gca,'xticklabel',[])
ylabel('Rate (Hz)','FontSize',20)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

legend(legendnames,'location','southwest')

pos = [0.1,0.1,0.8,0.4];
subplot('position',pos);

plot(Ivals,log10(Irate(indices(1),:)),'.-','Color',[1 0.7 0.7],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Irate(indices(2),:)),'.-','Color',[1 0.3 0.3],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Irate(indices(3),:)),'.-','Color',[0.5 0 0],'linewidth',2,'markersize',25)
%ylim([0 2])
LogScale('y',10);xlim([0 400])
xlabel('Current (pA)','FontSize',20);ylabel('Rate (Hz)','FontSize',20)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

legend(legendnames,'location','southeast')

NiceSave('FI_EI_Rate',figurepath,[])

%%

% save('FIspikes.mat','FIspikes');

csvwrite('Erates.csv',Erate);
csvwrite('Irates.csv',Irate);

% csvwrite('Epeakwidth.csv',Epeakwidth);
% csvwrite('Ipeakwidth.csv',Ipeakwidth);
% 
% csvwrite('Epeakheight.csv',Epeakheight);
% csvwrite('Ipeakheight.csv',Ipeakheight);

save('lastspikes.mat','EndSpikes','-v7.3');

end
