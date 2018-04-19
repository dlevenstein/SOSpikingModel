%STDP Function
%by Jonathan Gornet and DLevenstein
%Last update: 4/8/2018
%INPUTS
%   W         Weight Matrix
%   times Time when cell last spiked
%   tau       "Targetted" spike rate
%   n         Learning rate

function [W,L] = STDP(W,x,n)

L = [];
for ii = 1:length(W(:,1))

    Windex = find(W(ii,:) ~= 0);
    W(Windex,:) = W(Windex,:) + n.*x(Windex);
    L = [L mean(n.*x(Windex))];
    
end

L = mean(L);    
    
end