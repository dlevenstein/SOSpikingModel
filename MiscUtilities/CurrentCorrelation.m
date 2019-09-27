function Network =  CurrentCorrelation(SimValuesArray)

for ww = 1:length(SimValuesArray)
    
SimValues = SimValuesArray(ww);

Ecurrent = zeros(2500,length(SimValues.t));
Icurrent = zeros(2500,length(SimValues.t));

E_e     = 0;
E_i     = -80; 

for ii = 1:2500
    
    Ecurrent(ii,:) = - SimValues.g_e(ii,:).*(SimValues.V(ii,:)-E_e);
    Icurrent(ii,:) = - SimValues.g_i(ii,:).*(SimValues.V(ii,:)-E_i);
    
end

%%

maxlag = 50;  %ms
maxlag_dt = maxlag./SimValues.t(2);  %convert to dt units
numcells = 2500;
C = zeros(2.*maxlag_dt+1,numcells);

for nn = 1:numcells
    
    [C(:,nn),t_lags] = xcov(Ecurrent(nn,:),Icurrent(nn,:),maxlag_dt,'coeff');
    
end

Network(ww).C = C;
Network(ww).t_lags = t_lags;

tt = find(t_lags == 0);

[d,d,w] = findpeaks(-mean(C(:,1:2000),2),t_lags,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
Network(ww).peakwidthE = w(1);
Network(ww).peakheightE = mean(C(tt,1:2000),2);

[d,d,w] = findpeaks(-mean(C(:,2001:2500),2),t_lags,'Annotate','extents','WidthReference','halfprom','SortStr','descend');
Network(ww).peakwidthI = w(1);
Network(ww).peakheightI = mean(C(tt,2001:2500),2);

end

end