function [recordVALs] = createRecorder(recordIntervals,TimeParams)

%[recordVALs] = createRecorder(recordIntervals,TimeParams)
%creates intervals for recording simulation
%
%INPUTS
%   recordIntervals intervals for recording
%   TimeParams      Parameters for time
%
%OUTPUTS
%   recordVALs      values for recording
%JGornet Summer 2019

%%
dt = TimeParams.dt;
tEND = TimeParams.SimTime;
tSAVE = 0:dt:tEND;

T = length(tSAVE);

if length(recordIntervals) > 0
    
recordVALs = zeros(1,T);

numINT = length(recordIntervals(1,:));

for ii = 1:numINT
    
    saveINT(1,ii) = recordIntervals(1,ii);
    saveINT(2,ii) = recordIntervals(2,ii);
    
end
    
for ii = 1:numINT
for n = 1:T-1
    
    if tSAVE(n) >= saveINT(1,ii) && tSAVE(n) <= saveINT(2,ii)
        recordVALs(n) = 1;     
    end
end
end

else
recordVALs = ones(1,T);
end