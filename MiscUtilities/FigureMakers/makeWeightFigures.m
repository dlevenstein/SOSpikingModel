function makeWeightFigures(weightVals,indices,legendnames,network,path)

figure

pos = [0.1 0.55 0.38 0.4];
subplot('Position',pos)

ww = indices(1);
plot(weightVals(ww).Ebins, weightVals(ww).EEDist./sum(weightVals(ww).EEDist),'Color',[0.7 0.7 1],'linewidth',2)
hold on

ww = indices(2);
plot(weightVals(ww).Ebins, weightVals(ww).EEDist./sum(weightVals(ww).EEDist),'Color',[0.3 0.3 1],'linewidth',2)
hold on

ww = indices(3);
plot(weightVals(ww).Ebins, weightVals(ww).EEDist./sum(weightVals(ww).EEDist),'Color',[0 0 0.5],'linewidth',2)

ylim([0 inf])

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

%--------------------------------------------------------------------------

id1 = find(weightVals(indices(1)).EEDist./sum(weightVals(indices(1)).EEDist) > 0.001);
id2 = find(weightVals(indices(2)).EEDist./sum(weightVals(indices(2)).EEDist) > 0.001);
id3 = find(weightVals(indices(3)).EEDist./sum(weightVals(indices(3)).EEDist) > 0.001);

B1min = weightVals(indices(1)).Ebins(min(id1));
B2min = weightVals(indices(2)).Ebins(min(id2));
B3min = weightVals(indices(3)).Ebins(min(id3));

B1max = weightVals(indices(1)).Ebins(max(id1));
B2max = weightVals(indices(2)).Ebins(max(id2));
B3max = weightVals(indices(3)).Ebins(max(id3));

Bmin = min([B1min, B2min, B3min]);
Bmax = max([B1max, B2max, B3max]);

xlim([Bmin Bmax]);

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

LogScale('x',10);

ylabel('Probability','fontsize',20);

lg = legend(legendnames(indices))
lg.FontSize = 14;

box OFF

%--------------------------------------------------------------------------

pos = [0.1 0.1 0.38 0.4];
subplot('Position',pos)

ww = indices(1);
plot(weightVals(ww).Ibins, weightVals(ww).EIDist./sum(weightVals(ww).EIDist),'Color',[1 0.7 0.7],'linewidth',2)
hold on

ww = indices(2);
plot(weightVals(ww).Ibins, weightVals(ww).EIDist./sum(weightVals(ww).EIDist),'Color',[1 0.3 0.3],'linewidth',2)
hold on

ww = indices(3);
plot(weightVals(ww).Ibins, weightVals(ww).EIDist./sum(weightVals(ww).EIDist),'Color',[0.5 0 0],'linewidth',2)

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

ylim([0 inf])

%--------------------------------------------------------------------------

id1 = find(weightVals(indices(1)).EIDist./sum(weightVals(indices(1)).EIDist) > 0.005);
id2 = find(weightVals(indices(2)).EIDist./sum(weightVals(indices(2)).EIDist) > 0.005);
id3 = find(weightVals(indices(3)).EIDist./sum(weightVals(indices(3)).EIDist) > 0.005);

B1min = weightVals(indices(1)).Ibins(min(id1));
B2min = weightVals(indices(2)).Ibins(min(id2));
B3min = weightVals(indices(3)).Ibins(min(id3));

B1max = weightVals(indices(1)).Ibins(max(id1));
B2max = weightVals(indices(2)).Ibins(max(id2));
B3max = weightVals(indices(3)).Ibins(max(id3));

Bmin = min([B1min, B2min, B3min]);
Bmax = max([B1max, B2max, B3max]);

xlim([Bmin Bmax]);

LogScale('x',10);

AX = get(gca,'XAxis');
set(AX,'FontSize', 16)
AX = get(gca,'YAxis');
set(AX,'FontSize', 16)

xlabel('Weight (nS)','fontsize',20);ylabel('Probability','fontsize',20);

lg = legend(legendnames(indices))
lg.FontSize = 14;

box OFF

% figval = 1;
% for ii = indices
%     
% %subplot(3,3,3.*(figval-1)+1)
% 
%     plot(weightVals(ii).bins, weightVals(ii).EEDist./sum(weightVals(ii).EEDist), 'b','linewidth',2)
%     hold on
%     plot(weightVals(ii).bins, weightVals(ii).EIDist./sum(weightVals(ii).EIDist), 'r','linewidth',2)
%     hold on
%     
%     xlabel('Weight (nS)','fontsize',10);ylabel('Probability','fontsize',10);
%     
%     legend('EE Weight','EI Weight')
%     
%     LogScale('x',10);
%     
%     xlim([weightVals(ii).bins(1) weightVals(ii).bins(end)]);ylim([0 inf])
%     
%     figval = figval + 1;
%     
% end
   
NiceSave([network 'FullWeightDist'],path,[])

%% Figures

figure
figval = 1;
for ii = indices

subplot(3,3,3.*(figval-1)+1)
    
    A = repmat(1,size(weightVals(ii).wEDist));
    A(weightVals(ii).wEDist == 0) = 0; 
    imagesc(weightVals(ii).Ebins,1:2000,weightVals(ii).wEDist)
    alpha(A)
    
    if weightVals(ii).Ebins(1) ~= weightVals(ii).Ebins(end)
        xlim([weightVals(ii).Ebins(1) weightVals(ii).Ebins(end)])
    end
    
    AX = get(gca,'XAxis');
    set(AX,'FontSize', 16)
    AX = get(gca,'YAxis');
    set(AX,'FontSize', 16)

    xticks([-2,-1,0,1]);xticklabels({'0.01','0.1','1','10'})
    xlabel('Weight (nS)');ylabel('Neuron (Rate)')
    
    LogScale('x',10)
    
subplot(3,3,3.*(figval-1)+2)
    
    A = repmat(1,size(weightVals(ii).wIDist));
    A(weightVals(ii).wIDist == 0) = 0; 
    imagesc(weightVals(ii).Ibins,1:2000,weightVals(ii).wIDist)
    alpha(A)
    xlim([weightVals(ii).Ibins(1) weightVals(ii).Ibins(end)])

    AX = get(gca,'XAxis');
    set(AX,'FontSize', 16)
    AX = get(gca,'YAxis');
    set(AX,'FontSize', 16)

    figval = figval + 1;
    xlabel('Weight (nS)');ylabel('Neuron (Rate)')
    
    LogScale('x',10)
    
end

NiceSave([network 'IndividualWeightDist'],path,[])

end