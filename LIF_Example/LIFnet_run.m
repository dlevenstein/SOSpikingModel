function [S,vMatrix] = LIFnet_run(J0,W,T)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS
%   W       weight matrix
%   J0      input bias to each cell
%   T       total time to run (ms)
%
%OUTPUTS
%   vMatris voltages of all cells
%   S       spike times (ms)
%
%
%DLevenstein 2017 (in progress)
%%
includeV=false;
if nargout==2
    includeV = true;
end
SHOWFIG = true;
spikedelay = 0.2; %ms
%%
Ntot = length(J0);

%Neuron biophysic parameters
Vt=1;  %threshold
Vr=0;   %reset

% membrane timescale
tau=15;

%simulation details
dt=0.01; %ms
maxspk=100000;

%Voltage Output
if includeV
    vrec = 1; %record V every vrec timestampe
    vMatrix=zeros(Ntot,round(T/vrec));
end

%Initialize the voltages
V = rand(Ntot,1);%+0.1;
V(find(V>=1))=1;

% spiketime arrays
spktime=zeros(maxspk,1);
spkindex=zeros(maxspk,1);

% kick array
if spikedelay>0
    kickarray = zeros(Ntot,spikedelay./dt);
end
%spike count counts the number of total spikes in the network
count = 1;


%%
% time loop
for t=[dt:dt:T]
%     if mod(t,1000)==0
%         toc
%         display(t)
%         tic
%     end
    %zero kicks from last step
    sendkick=zeros(Ntot,1);
    
    %find spikers - indexspike are the cell indices of cells that
    %are over threshold
    index_spke=find(V>=Vt); %Indices of the cells that spike
    if (~isempty(index_spke))
    spktime(count:count+length(index_spke)-1)=t; %update spiketime
    spkindex(count:count+length(index_spke)-1)=index_spke; %update cellID
    V(index_spke)=Vr;  %reset membrane potentials
    count=count+length(index_spke);
    end
      
    %update kick arrays (synapses)
    for j=1:length(index_spke) %loop through cells that spike
        %add the total (syn.weighted) kicks to each postsynaptic cell
       sendkick = sendkick + W(:,index_spke(j)); 
    end  
    
    %delay is implemented here with a cicularly shifted kickarray
    if spikedelay>0
        kickarray = circshift(kickarray,-1,2);
        kickarray(:,end) = sendkick;
        recievekick = kickarray(:,1);
    else
        recievekick = sendkick;
    end
    %Deliver the total kicks to postsynaptic cells
    V=V+recievekick;
    V=V+dt/tau*(-V+J0);
    
    %record Vm
    if includeV && mod(t,vrec)==0
        vMatrix(:,round(t/vrec))=V;
    end
end 
spktime(count:end) = [];
spkindex(count:end)=[];

%toc
%%
if SHOWFIG
figure(1);clf;
plot(spktime,spkindex,'k.')
end

S = [spktime spkindex];


%%
% subplot(2,1,1), plot(spktime_e,spkindex_e,'.k', 'MarkerSize',8); xlabel('Time (ms)', 'fontsize', 16, 'fontweight', 'b'); ylabel('E cell index', 'fontsize', 16, 'fontweight', 'b')
% if (~isempty(spktime_e(find(spkindex_e==round(N/2)))))
%     hold on;subplot(2,1,1), plot(spktime_e(find(spkindex_e==round(N/2))),round(N/2),'.r', 'MarkerSize',10);
% end
% pMean=1000*numel(find(spktime_e>0))/(T*N);
% ['population mean:  ',num2str(pMean)]
% subplot(2,1,2), plot(spktime_i,spkindex_i,'.k', 'MarkerSize',8); xlabel('Time (ms)', 'fontsize', 16, 'fontweight', 'b'); ylabel('I cell index', 'fontsize', 16, 'fontweight', 'b')
% 


end

