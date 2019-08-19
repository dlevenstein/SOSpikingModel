%%

mapIvals = linspace(150,300,20);
mapbvals = 10.^(-2:0.5:4);

Iindex = 1:length(mapIvals);
bindex = 1:length(mapbvals);

%%
I_indices = zeros(1,8);
b_indices = zeros(1,8);

ii = find(Iindex == 4);
bb = find(bindex == 4);

I_indices(1) = ii;
b_indices(1) = bb;

ii = find(Iindex == 8);
bb = find(bindex == 4);

I_indices(2) = ii;
b_indices(2) = bb;

ii = find(Iindex == 8);
bb = find(bindex == 8);

I_indices(3) = ii;
b_indices(3) = bb;

ii = find(Iindex == 10);
bb = find(bindex == 7);

I_indices(4) = ii;
b_indices(4) = bb;

ii = find(Iindex == 18);
bb = find(bindex == 9);

I_indices(5) = ii;
b_indices(5) = bb;

ii = find(Iindex == 6);
bb = find(bindex == 12);

I_indices(6) = ii;
b_indices(6) = bb;

ii = find(Iindex == 10);
bb = find(bindex == 13);

I_indices(7) = ii;
b_indices(7) = bb;

ii = find(Iindex == 19);
bb = find(bindex == 13);

I_indices(8) = ii;
b_indices(8) = bb;

%%

for II = 1:8
    
    ii = I_indices(II);
    bb = b_indices(II);
    
    SimValuesArray(II) = load(['AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb) '.mat']);
     
end

%%

for fig = 1:8
    
    t      = SimValuesArray(fig).t;
    spikes = SimValuesArray(fig).spikes;
    Input  = SimValuesArray(fig).Input;
    s      = SimValuesArray(fig).s;
    g_w    = SimValuesArray(fig).g_w;
    
    [Espikes,Ispikes] = RasterSorter(SimValuesArray(fig));
    
    figure
    subplot(3,2,1)
    plot(Espikes(:,1),Espikes(:,2),'.b','MarkerSize',1)
    hold on
    plot(Ispikes(:,1),Ispikes(:,2),'.r','MarkerSize',1)
    xlim([0 t(end)]);ylim([0 2500])
    xlabel('Time (ms)')
    subplot(3,2,2)
    plot(t,Input,'k','MarkerSize',1)
    ylim([0 500])
    xlabel('Time (ms)');ylabel('Current (pA)')
    subplot(3,2,3)
    plot(t,s,'k','MarkerSize',1)
    xlabel('Time (ms)');ylabel('Synapse');title('Synaptic Dynamics')
    subplot(3,2,4)
    plot(t,g_w,'k','MarkerSize',1)
    xlabel('Time (ms)');ylabel('Adaptation');title('Adaptation Dynamics')
    subplot(3,2,5)
    imagesc(t,1:2500,s)
    xlabel('Time (ms)');ylabel('Neuron ID');title('Synaptic Dynamics')
    colorbar
    set(gca,'colorscale','log')
    subplot(3,2,6)
    imagesc(t,1:2500,g_w)
    xlabel('Time (ms)');ylabel('Neuron ID');title('Adaptation Dynamics')
    colorbar
    set(gca,'colorscale','log')
    
    ii = I_indices(fig);
    bb = b_indices(fig);
    
    NiceSave(['AdaptationVCurrentSpikes_ii_' num2str(ii) '_bb_' num2str(bb)],'/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/testingFolder/AdaptationVCurrent/figures/8-18-2019',[])
    close all
    
end

