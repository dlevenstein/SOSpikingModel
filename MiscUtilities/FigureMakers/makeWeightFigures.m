function makeWeightFigures(weightVals,indices,network,path)

figure
figval = 1;
for ii = indices
    
subplot(3,3,3.*(figval-1)+1)

    plot(weightVals(ii).bins, weightVals(ii).EEDist./sum(weightVals(ii).EEDist), 'b','linewidth',2)

    hold on
    plot(weightVals(ii).bins, weightVals(ii).EIDist./sum(weightVals(ii).EIDist), 'r','linewidth',2)
    xlabel('Weight (nS)','fontsize',10);ylabel('Probability','fontsize',10);

    legend('EE Weight','EI Weight')

    xlim([weightVals(ii).bins(1) weightVals(ii).bins(end)]);ylim([0 inf])
    
    figval = figval + 1;
    
end
   
NiceSave([network 'FullWeightDist'],path,[])

%% Figures

figure
figval = 1;
for ii = indices

subplot(3,3,3.*(figval-1)+1)
    
    A = repmat(1,size(weightVals(ii).wEDist));
    A(weightVals(ii).wEDist == 0) = 0; 
    imagesc(weightVals(ii).bins,1:2000,weightVals(ii).wEDist)
    alpha(A)
    xlim([weightVals(ii).bins(1) weightVals(ii).bins(end)])
    
    xticks([-2,-1,0,1]);xticklabels({'0.01','0.1','1','10'})
    xlabel('Weight (nS)');ylabel('Neuron (Rate)')
    
    LogScale('x',10)
    
subplot(3,3,3.*(figval-1)+2)
    
    A = repmat(1,size(weightVals(ii).wIDist));
    A(weightVals(ii).wIDist == 0) = 0; 
    imagesc(weightVals(ii).bins,1:2000,weightVals(ii).wIDist)
    alpha(A)
    xlim([weightVals(ii).bins(1) weightVals(ii).bins(end)])

    figval = figval + 1;
    xlabel('Weight (nS)');ylabel('Neuron (Rate)')
    
    LogScale('x',10)
    
end

NiceSave([network 'IndividualWeightDist'],path,[])

end