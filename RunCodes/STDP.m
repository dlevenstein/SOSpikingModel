%STDP Function
%by Jonathan Gornet and DLevenstein
%Last update: 4/8/2018
%INPUTS
%   W         Weight Matrix
%   times Time when cell last spiked
%   tau       "Targetted" spike rate
%   n         Learning rate

function [Wlearned,L] = STDP(W,times,tau,n)

Wlearned = zeros(length(W(1,:)),length(W(:,1)));
dWvec = nan(length(W(1,:)),length(W(:,1)));

parfor ii = 1:length(times(:,1))
    
    preTime = times(ii,2); 
    w = zeros(1,length(W(times(ii,1),:)));
    temp = nan(length(W(times(ii,1),:)),1);
    
    for jj = 1:length(W(times(ii,1),:))
        
        if W(times(ii,1),jj) > 0 && times(ii,1) ~= jj
            
            postTime = times(jj,2);
            dt = postTime - preTime;
            
            dW = n.*exp(-abs(dt)/tau);
                    
            temp(jj) = dW;
            w(jj) = W(times(ii,1),jj) + dW;
        
        end
    end
    
    Wlearned(ii,:) = w;
    dWvec(ii,:) = temp;
    
end

L = nanmean(nanmean(dWvec));

end