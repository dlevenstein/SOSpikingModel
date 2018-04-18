function [W,L] = GradSTDP(W,cellTimes,n)

Wchanges = [];

for preID=1:length(cellTimes(:,1))
    
    if cellTimes(preID,2) ~= 0
    preRate = 1/cellTimes(preID,2);
    
    for postID=1:length(W(cellTimes(preID,1),:))
        
        if W(cellTimes(preID,1),postID) > 0 && cellTimes(preID,1) ~= postID
             
        if cellTimes(postID,2) ~= 0
        postRate = 1/cellTimes(postID,2);
        
        
        dW = n*(preRate*postRate - 0.01*preRate);
        Wchanges = [Wchanges abs(dW)];
            
        %if W(cellTimes(preID,1),postID) + dW > 0
        W(cellTimes(preID,1),postID) = W(cellTimes(preID,1),postID) + dW;
        %end
        
        end
        end
    end
    end
          
end

L = mean(Wchanges);