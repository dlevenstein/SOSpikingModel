function makeISI(dynamicVals,SimValuesArray,indices,network,path)

%%
figure

ww = indices(1);

pos = [0.1,0.7,0.25,0.25];
subplot('Position',pos)

A = repmat(1,size(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:)));
A(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:) == 0) = 0; 
imagesc(dynamicVals(ww).ISIdist.bins,[0 max(SimValuesArray(ww).IcellIDX)],log10(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:)))

    hold on
    plot(dynamicVals(ww).ISIdist.bins([1 end]),min(SimValuesArray(ww).IcellIDX).*[1 1],'k')
    LogScale('x',10)

    alpha(A);
    ylabel('Neuron (sort by Rate, Type)')
    h = colorbar;
    ylabel(h,'log P(ISI)')
    %caxis([0 1])
    
xlabel('ISI (ms)','fontsize',15);ylabel('Neuron (Rate)','fontsize',15);title('ISI','fontsize',20)

pos = [0.1,0.4,0.25,0.25];
subplot('Position',pos)

ww = indices(2);

A = repmat(1,size(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:)));
A(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:) == 0) = 0; 
imagesc(dynamicVals(ww).ISIdist.bins,[0 max(SimValuesArray(ww).IcellIDX)],log10(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:)))

    hold on
    plot(dynamicVals(ww).ISIdist.bins([1 end]),min(SimValuesArray(ww).IcellIDX).*[1 1],'k')
    LogScale('x',10)

    alpha(A);
    ylabel('Neuron (sort by Rate, Type)')
    h = colorbar;
    ylabel(h,'log P(ISI)')
    %caxis([0 1])
    
ylabel('Neuron (Rate)','fontsize',15)

pos = [0.1,0.1,0.25,0.25];
subplot('Position',pos)

ww = indices(3);

A = repmat(1,size(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:)));
A(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:) == 0) = 0; 
imagesc(dynamicVals(ww).ISIdist.bins,[0 max(SimValuesArray(ww).IcellIDX)],log10(dynamicVals(ww).ISIdist.all(dynamicVals(ww).sortrate.ratetype,:)))

    hold on
    plot(dynamicVals(ww).ISIdist.bins([1 end]),min(SimValuesArray(ww).IcellIDX).*[1 1],'k')
    LogScale('x',10)

    alpha(A);
    ylabel('Neuron (sort by Rate, Type)')
    h = colorbar;
    ylabel(h,'log P(ISI)')
    %caxis([0 1])
    
ylabel('Neuron (Rate)','fontsize',15)

NiceSave([network 'ISIdist'],path,[])

% %%
% 
% figure
% 
% pos = [0.1,0.7,0.25,0.25];
% subplot('Position',pos)
% 
% ww = indices(1);
% 
%     plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapE./sum(dynamicVals(ww).ISImapE),'b')
%     hold on
%     plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapI./sum(dynamicVals(ww).ISImapI),'r')
%     LogScale('x',10)
%     xlabel('ISI (ms)','fontsize',15);ylabel('Probability','fontsize',15);title('ISI','fontsize',20)
%    
% pos = [0.1,0.4,0.25,0.25];
% subplot('Position',pos)
% 
% ww = indices(2);
% 
%     plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapE./sum(dynamicVals(ww).ISImapE),'b')
%     hold on
%     plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapI./sum(dynamicVals(ww).ISImapI),'r')
%     LogScale('x',10)
%     xlabel('ISI (ms)','fontsize',15);ylabel('Probability','fontsize',15)
% 
% pos = [0.1,0.1,0.25,0.25];
% subplot('Position',pos)
% 
% ww = indices(3);
% 
%     plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapE./sum(dynamicVals(ww).ISImapE),'b')
%     hold on
%     plot(dynamicVals(ww).bins,dynamicVals(ww).ISImapI./sum(dynamicVals(ww).ISImapI),'r')
%     LogScale('x',10)
%     xlabel('ISI (ms)','fontsize',15);ylabel('Probability','fontsize',15)

end
