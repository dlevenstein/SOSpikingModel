path = '/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/01-3-2019/01';
cd(path)

dinfo = dir;

GammaEneuron01 = zeros(10,21,2);
GammaIneuron01 = zeros(10,21,2);

gnum = 1;

for dd = 1:length(dinfo)
    
    name = dinfo(dd).name;
    
    if name(1) == 'G'
        
        load(name)
        
        for ii = 1:21
        
        GammaEneuron01(gnum,ii,1) = mean(mean(GammaValues(ii).g_e(1:2000,1011:end)));
        GammaEneuron01(gnum,ii,2) = mean(mean(GammaValues(ii).g_i(1:2000,1011:end)));
        
        GammaIneuron01(gnum,ii,2) = mean(mean(GammaValues(ii).g_e(2001:2500,1011:end)));
        GammaIneuron01(gnum,ii,2) = mean(mean(GammaValues(ii).g_i(2001:2500,1011:end)));
        
        end
        
        gnum = gnum + 1;
        
    end

end

%%
path = '/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/01-3-2019/1';
cd(path)

dinfo = dir;

GammaEneuron1 = zeros(10,21,2);
GammaIneuron1 = zeros(10,21,2);

gnum = 1;

for dd = 1:length(dinfo)
    
    name = dinfo(dd).name;
    
    if name(1) == 'G'
        
        load(name)
        
        for ii = 1:21
        
        GammaEneuron1(gnum,ii,1) = mean(mean(GammaValues(ii).g_e(1:2000,1011:end)));
        GammaEneuron1(gnum,ii,2) = mean(mean(GammaValues(ii).g_i(1:2000,1011:end)));
        
        GammaIneuron1(gnum,ii,2) = mean(mean(GammaValues(ii).g_e(2001:2500,1011:end)));
        GammaIneuron1(gnum,ii,2) = mean(mean(GammaValues(ii).g_i(2001:2500,1011:end)));
        
        end
        
        gnum = gnum + 1;
        
    end

end

%%
path = '/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/01-3-2019/10';
cd(path)

dinfo = dir;

GammaEneuron10 = zeros(10,21,2);
GammaIneuron10 = zeros(10,21,2);

gnum = 1;

for dd = 1:length(dinfo)
    
    name = dinfo(dd).name;
    
    if name(1) == 'G'
        
        load(name)
        
        for ii = 1:21
        
        GammaEneuron10(gnum,ii,1) = mean(mean(GammaValues(ii).g_e(1:2000,1011:end)));
        GammaEneuron10(gnum,ii,2) = mean(mean(GammaValues(ii).g_i(1:2000,1011:end)));
        
        GammaIneuron10(gnum,ii,2) = mean(mean(GammaValues(ii).g_e(2001:2500,1011:end)));
        GammaIneuron10(gnum,ii,2) = mean(mean(GammaValues(ii).g_i(2001:2500,1011:end)));
        
        end
        
        gnum = gnum + 1;
        
    end

end

%%
GE01 = 1+mean(GammaEneuron01(:,:,1))./PopParams.g_L(1)+mean(GammaEneuron01(:,:,2))./PopParams.g_L(1);
GI01 = 1+mean(GammaIneuron01(:,:,1))./PopParams.g_L(2)+mean(GammaIneuron01(:,:,2))./PopParams.g_L(2);

GE1 = 1+mean(GammaEneuron1(:,:,1))./PopParams.g_L(1)+mean(GammaEneuron1(:,:,2))./PopParams.g_L(1);
GI1 = 1+mean(GammaIneuron1(:,:,1))./PopParams.g_L(2)+mean(GammaIneuron1(:,:,2))./PopParams.g_L(2);

GE10 = 1+mean(GammaEneuron10(:,:,1))./PopParams.g_L(1)+mean(GammaEneuron10(:,:,2))./PopParams.g_L(1);
GI10 = 1+mean(GammaIneuron10(:,:,1))./PopParams.g_L(2)+mean(GammaIneuron10(:,:,2))./PopParams.g_L(2);

Ivals = linspace(0,400,21);

figure

pos = [0.1,0.52,0.8,0.4];
subplot('Position',pos)

plot(Ivals,log10(GE01),'.-','Color',[0.7 0.7 1],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(GE1),'.-','Color',[0.3 0.3 1],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(GE10),'.-','Color',[0 0 0.5],'linewidth',2,'markersize',25)
LogScale('y',10)

ylabel('Gamma','fontsize',20)

set(gca,'xticklabel',[])

pos = [0.1,0.1,0.8,0.4];
subplot('Position',pos)

plot(Ivals,log10(GI01),'.-','Color',[1 0.7 0.7],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(GI1),'.-','Color',[1 0.3 0.3],'linewidth',2,'markersize',25)
hold on
plot(Ivals,log10(GI10),'.-','Color',[0.5 0 0],'linewidth',2,'markersize',25)
LogScale('y',10)

xlabel('Current (pA)','fontsize',20);ylabel('Gamma','fontsize',20)

NiceSave('GammaPlot','/Users/jonathangornet/Google Drive/Computational_Neuroscience/STDPData/01-3-2019',[])
