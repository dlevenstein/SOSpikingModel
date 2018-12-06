function makeFigures(SimValuesArray,indices,network,path,networknames,legendnames)

makeRaster(SimValuesArray,indices,[network '_Raster'],path,true);

%%

weightVals = WeightVals(SimValuesArray);

[dynamicVals,kvals] = AnalyzeDynamics(SimValuesArray);

currentVals = CurrentCorrelation(SimValuesArray);

for ww = 1:length(SimValuesArray)
rateVals(ww) = RateCorrelation(SimValuesArray(ww));
end

%%

makeDynamicFigures(dynamicVals,indices,networknames,legendnames,network,path)

makeCurrentFigures(currentVals,indices,networknames,legendnames,network,path)

makeWeightFigures(weightVals,indices,network,path)

makeISI(dynamicVals,SimValuesArray,indices,network,path)

figure
figval = 1;

for ii = indices

    subplot(3,3,3.*(figval-1)+2)
        plot(kvals(ii).Kweight(1:2000),kvals(ii).Krate(1:2000),'.b','markersize',1)
        xlabel('K_{EI}','fontsize',15);ylabel('Rate (Hz)','fontsize',15)

        subplot(3,3,3.*(figval-1)+3)
        plot(kvals(ii).Kweight(2001:2500),kvals(ii).Krate(2001:2500),'.r','markersize',1)
        xlabel('K_{EI}','fontsize',15);ylabel('Rate (Hz)','fontsize',15)

    figval = figval + 1;
    
end

NiceSave([network 'Kvals'],path,[])

end
