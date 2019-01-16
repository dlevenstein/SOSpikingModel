
folders = ["LogWeightSigma","ExperimentRate"];

for ff = 1:length(folders)
    
    FINetwork(["001","01","1","10"],['/Users/jonathangornet/Desktop/FIData/' char(folders(ff))],char(folders(ff)))
    
end

%%

folders = ["LogWeightMu","Uniform"];

for ff = 1:length(folders)
    
    FINetwork(["01","03","1","3","10"],['/Users/jonathangornet/Desktop/FIData/' char(folders(ff))],char(folders(ff)))
    
end