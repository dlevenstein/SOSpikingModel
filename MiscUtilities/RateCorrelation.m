function M = RateCorrelation(SimValues)
%%

poprate.dt = 50;   overlap = 1;   winsize = poprate.dt.*overlap;
[spikemat,t_rate,~] = SpktToSpkmat(SimValues.spikesbycell, [], poprate.dt,overlap);

N = length(SimValues.EcellIDX)+length(SimValues.IcellIDX);
rate = zeros(length(t_rate),N);

for ii = 1:N    
rate(:,ii) = sum(spikemat(:,ii),2)./(winsize./1000);
end

%%

C = corr(rate(:,1:N),rate(:,1:N));

C(diag(diag(true(size(C))))) = nan;
    
M.totalMean = nanmean(nanmean(C));
M.EEmean = nanmean(nanmean(C(SimValues.EcellIDX,SimValues.EcellIDX)));
M.IImean = nanmean(nanmean(C(SimValues.IcellIDX,SimValues.IcellIDX)));
M.IEmean = nanmean(nanmean(C(SimValues.IcellIDX,SimValues.EcellIDX)));
M.EImean = nanmean(nanmean(C(SimValues.EcellIDX,SimValues.IcellIDX)));

end