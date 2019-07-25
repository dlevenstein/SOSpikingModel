function [W,PopParams] = CreateNetwork(PopParams,varargin)

%[W,PopParams] = CreateNetwork(PopParams,varargin)
%creates networks for simulations
%
%INPUTS
%   PopParams       parameters for simulation with weight values index
%
%   (optional)      for optional inputs, use: ('inputoption', inputvalue)
%       'EE_type'       type of network configuration of E->E synapses
%                       (default:uniform)
%       'IE_type'       type of network configuration of E->I synapses
%                       (default:uniform)
%       'CreateClusters'(true/false) create network clusters (default:
%       true)
%
%OUTPUTS
%   W            	Weight Matrix
%   PopParams       Update Parameter List
%JGornet Summer 2019

%%

p = inputParser;

addParameter(p,'EE_type','uniform',@ischar)
addParameter(p,'IE_type','uniform',@ischar)
addParameter(p,'CreateClusters',false,@islogical)

parse(p,varargin{:})

EE_type = p.Results.EE_type;
IE_type = p.Results.IE_type;
CreateClusters = p.Results.CreateClusters;

%% Indexing

EPopNum = PopParams.EPopNum;
IPopNum = PopParams.IPopNum;
PopNum = EPopNum + IPopNum;

EcellidX = 1:EPopNum;
IcellidX = EPopNum+1:PopNum;

PopParams.EcellidX = EcellidX;
PopParams.IcellidX = IcellidX;

%% Allocate Space
EE_mat = zeros(PopNum);
II_mat = zeros(PopNum);
IE_mat = zeros(PopNum);
EI_mat = zeros(PopNum);

%% Create Connections

if CreateClusters

ClustersIDx = cell(PopParams.numClusters,1);
clusterBins = floor(EPopNum/PopParams.numClusters);

hangingConnections = mod(EPopNum,PopParams.numClusters);

startConnection = 1;
endConnection = clusterBins;

for cc = 1:PopParams.numClusters
    
ClustersIDx{cc} = startConnection:endConnection;
startConnection = endConnection + 1;
if hangingConnections>0
    endConnection = endConnection + clusterBins + 1;
    hangingConnections = hangingConnections - 1;
else
    endConnection = endConnection + clusterBins;
end

disp(length(ClustersIDx{cc}))

end

for cc = 1:PopParams.numClusters-1
    disp([num2str(ClustersIDx{cc+1}(1)) ', ' num2str(ClustersIDx{cc}(end))])
end

for cc = 1:PopParams.numClusters
    Kcluster = PopParams.ClusterK;
    Pcluster = Kcluster./(length(ClustersIDx{cc})-1); %-1 to account for self-connections (which are then removed)

    EE_mat(ClustersIDx{cc},ClustersIDx{cc}) = rand(length(ClustersIDx{cc}),length(ClustersIDx{cc}))<=Pcluster;
end

for cSender = 1:PopParams.numClusters
for cReceiver = 1:PopParams.numClusters

    if cSender ~= cReceiver
    KCrossCluster = PopParams.CrossClusterK;
    Pcluster = KCrossCluster./(EPopNum-length(ClustersIDx{cSender})); %-1 to account for self-connections (which are then removed)

    EE_mat(ClustersIDx{cReceiver},ClustersIDx{cSender}) = rand(length(ClustersIDx{cReceiver}),length(ClustersIDx{cSender}))<=Pcluster;
    end

end
end

else

%E->E Synapses
Kee = PopParams.Kee;
Pee = Kee./(EPopNum-1);

EE_mat(EcellidX,EcellidX) = rand(EPopNum)<=Pee;
EE_mat(diag(diag(true(size(EE_mat)))))=0; %Remove selfconnections

end

%I->I Synapses
Kii = PopParams.Kii;
Pii = Kii./(IPopNum-1);

II_mat(IcellidX,IcellidX) = rand(IPopNum)<=Pii;
II_mat(diag(diag(true(size(II_mat)))))=0; %Remove selfconnections

%E->I Synapses
Kie = PopParams.Kie;
Pie = Kie./EPopNum;

IE_mat(IcellidX,EcellidX) = rand(IPopNum,EPopNum)<=Pie;

%I->E Synapses
Kei = PopParams.Kei;
Pei = Kei./IPopNum;

EI_mat(EcellidX,IcellidX) = rand(EPopNum,IPopNum)<=Pei;

%% Add Weights

if strcmp(EE_type,'lognormal')
    m = PopParams.m;
    s = PopParams.s;
    
    M = log((m^2)/sqrt(s+m^2));
    S = sqrt(log((s/m^2)+1));

    EE_mat(EcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*EE_mat(EcellidX,EcellidX);
else
    EE_mat = PopParams.Wee.*EE_mat;
end

if strcmp(IE_type,'lognormal')
    m = PopParams.m;
    s = PopParams.s;
    
    M = log((m^2)/sqrt(s+m^2));
    S = sqrt(log((s/m^2)+1));

    IE_mat(IcellidX,EcellidX) = lognrnd(M,S,[EPopNum,EPopNum]).*IE_mat(IcellidX,EcellidX);
else
    IE_mat = PopParams.Wie.*IE_mat;
end

II_mat = PopParams.Wii.*II_mat;
EI_mat = PopParams.Wei.*EI_mat;

%% Remove Self-Connections
EE_mat(diag(diag(true(size(EE_mat)))))=0;
II_mat(diag(diag(true(size(II_mat)))))=0;

%% Return full matrix
W = EE_mat+II_mat+IE_mat+EI_mat;
W(diag(diag(true(size(W)))))=0;
PopParams.W = W;

end

