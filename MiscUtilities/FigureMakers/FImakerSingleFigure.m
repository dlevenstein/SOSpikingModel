function FImakerSingleFigure(startpath,figurepath,indices,folder,varargin)

p = inputParser;
addParameter(p,'showfig',false,@islogical)
addParameter(p,'bistable',true,@islogical)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;
bistable = p.Results.bistable;

%%
Erate = zeros(1,21);
Irate = zeros(1,21);

% Epeakwidth = zeros(1,21);
% Ipeakwidth = zeros(1,21);
% 
% Epeakheight = zeros(1,21);
% Ipeakheight = zeros(1,21);

EndSpikes = nan(21,110);

FIspikes = cell(1,21);

cd([startpath char(folder)])

for II = 1:21

    cd(['I_' char(num2str(II))])

    path = [figurepath char(folder)];

    [rate,peakwidth,peakheight,lastspikes,S] = FIfigures(II,path,'showfig',SHOWFIG,'bistable',bistable);

    FIspikes{II} = S;

    Erate(II) = rate.E;
    Irate(II) = rate.I;

%         Epeakwidth(ff,II) = peakwidth.E;
%         Ipeakwidth(ff,II) = peakwidth.I;
%         
%         Epeakheight(ff,II) = peakheight.E;
%         Ipeakheight(ff,II) = peakheight.I;

    EndSpikes(II,1:length(lastspikes)) = lastspikes;

    cd([startpath char(folder)])

end

cd(startpath)
   
Ivals = linspace(0,400,21);

%% Map

B = 50;
map = zeros(12,B);

M = nan(1,12);

for II = 1:12

    map(II,:) = hist(log10(squeeze(EndSpikes(II,:))),linspace(0,3.5,B));
    if sum(map(II,:)) > 0
    map(II,:) = map(II,:)./sum(map(II,:));
    M(II) = max(map(II,:));
    end

end
    
M(find(M == 1)) = nan;
colormaxes = zeros(length(folder),1);

if all(isnan(M))
    colormaxes = 1;
else
    colormaxes = nanmax(M);
end

%% Rates

figure

%--------------------------------------------------------------------------

subplot(2,1,1)

plot(Ivals,log10(Erate),'.-b','linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(Irate),'.-r','linewidth',2,'markersize',25)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 400])
ylabel('Rate (Hz)','FontSize',20)
xlabel('Current (pA)','FontSize',20)

%--------------------------------------------------------------------------

subplot(2,1,2)

A = repmat(1,size(map));
A(map(:,:,indices(1)) == 0) = 0; 

imagesc(Ivals(1:12),linspace(0,3.5,B),map')
set(gca,'ydir','normal')
colorbar
clim([0 colormaxes])
alpha(A')

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('y',10);xlim([0 220])
ylabel('Time (ms)','FontSize',20)
xlim([0 220]) 

NiceSave('FI_map',figurepath,[])

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
