%mean, CV, UP/DOWN times,
%option: try multiple rate bins, thresholds

spikes = S{20,13};
figure
    subplot(3,1,1)
    plot(spikes(:,1),spikes(:,2),'.')

    %%
    DOWNdetection(  ...
        S{11,6},'SHOWFIG',true,'simdur',20000)
%% Input-Adaptation space
    for bbb = 1:13
        bz_Counter(bbb,20,'Column')
        %here: generate adaptation nullcline to plot
        parfor aaa = 1:20
            %%
    [ UPDOWN(aaa,bbb),ratehist(aaa,bbb),durhist(aaa,bbb) ] = DOWNdetection(  ...
        S{aaa,bbb},'SHOWFIG',['Input',num2str(aaa),'Adapt',num2str(bbb)],'simdur',20000,...
        'savefolder','/Users/dlevenstein/Project Repos/SOSpikingModel/Figures/UPDOWN');
        end
    end

%%
for bb = 1:13
    %
    for aa = 1:20
    
        meanrate(aa,bb) = ratehist(aa,bb).summstats.meanrate;
        meanUPrate(aa,bb) = ratehist(aa,bb).summstats.meanUPrate;
        meanUPdur(aa,bb) = durhist(aa,bb).mean.UP;
        CVUPdur(aa,bb) = durhist(aa,bb).CV.UP;
        meanDOWNdur(aa,bb) = durhist(aa,bb).mean.DOWN;
        CVDOWNdur(aa,bb) = durhist(aa,bb).CV.DOWN;
    end
end
%%
figure
subplot(3,3,1)
imagesc(log10(meanrate)')
title('Rate')
colorbar
LogScale('c',10)
axis xy

subplot(3,3,4)
imagesc(log10(meanUPrate)')
title('UP Rate')
colorbar
LogScale('c',10)
axis xy

subplot(3,3,2)
imagesc(log10(meanUPdur)')
axis xy
colorbar
LogScale('c',10)

title('Mean UP Dur')

subplot(3,3,3)
imagesc(CVUPdur')
caxis([0 2])
axis xy
colorbar
title('CV UP Dur')



subplot(3,3,5)
imagesc(log10(meanDOWNdur)')
axis xy
colorbar
LogScale('c',10)
title('Mean DOWN Dur')

subplot(3,3,6)
imagesc(CVDOWNdur')
caxis([0 2])
colorbar
title('CV DOWN Dur')
axis xy

NiceSave('UPDOWN','/Users/dlevenstein/Project Repos/SOSpikingModel/Figures/UPDOWN',[])
%%
[test1,test2,test3] =DOWNdetection(  ...
    S{aa,bb},'SHOWFIG',false,'simdur',20000);
%%
clear ratehist
clear spikemat
ratehist.numbins = 150;
ratehist.bins = linspace(-2.5,1.5,ratehist.numbins);



numbinsizes = 30;
binsizes = linspace(0.5,3,numbinsizes);
tempratehist = zeros(ratehist.numbins,numbinsizes);
parfor bb = 1:numbinsizes
    bz_Counter(bb,numbinsizes,'Bin Size')
    spikemat = bz_SpktToSpkmat(spikes,'dt',1,'binsize',10.^(binsizes(bb)),'bintype','gaussian','units','rate');
    allrate(:,bb) = mean(spikemat.data,2)*1000;
    timestamps(:,bb) = spikemat.timestamps;
    %% Rate histogram
    tempratehist(:,bb) = hist(log10(allrate(:,bb)),ratehist.bins);

    %IDX.statenames = {'UP','DOWN'}
    %% DOWN detection

end
ratehist.hist = tempratehist;

%% UP/DOWN detection

threshold = 0.3;
durhist.bins = linspace(0.5,4,25);
durhist.UP = [];
durhist.DOWN = [];
clear UPDOWN
for bb = 1:numbinsizes
    IDX.timestamps = timestamps(:,bb);
    IDX.statenames = {'UP','DOWN'};
    IDX.states = single(allrate(:,bb)>threshold);
    IDX.states(allrate(:,bb)<=threshold)=2;
    temp = bz_IDXtoINT(IDX);
    temp.dur.UP = diff(temp.UPstate,[],2);
    temp.dur.DOWN = diff(temp.DOWNstate,[],2);
    
    [~,inUP] = InIntervals(spikes(:,1),temp.UPstate);
    for uu = unique(inUP)'
        if uu == 0
            continue
        end
        temp.UPrate(uu) = sum(inUP==uu)./temp.dur.UP(uu);
    end

    UPDOWN(bb)=temp;
    durhist.UP(:,bb) = hist(log10(temp.dur.UP),durhist.bins);
    durhist.UP(:,bb) = durhist.UP(:,bb)./sum(durhist.UP(:,bb));
    durhist.DOWN(:,bb) = hist(log10(temp.dur.DOWN),durhist.bins);
    durhist.DOWN(:,bb) = durhist.DOWN(:,bb)./sum(durhist.DOWN(:,bb));
    clear temp
end


%%
DOWNcolor = [0 0 0.8];

bb = 13;
figure
    subplot(3,1,1)
    plot(spikes(:,1),spikes(:,2),'.')
    ylim([0 2500])
    hold on
    plot(timestamps(:,bb),bz_NormToRange((allrate(:,bb))),'k')
    y = get(gca,'Ylim');
    patch([UPDOWN(bb).DOWNstate(:,1) UPDOWN(bb).DOWNstate(:,2),...
        UPDOWN(bb).DOWNstate(:,2) UPDOWN(bb).DOWNstate(:,1)]',...
        repmat([y(1) y(1) y(2) y(2)],length(UPDOWN(bb).DOWNstate(:,1)),1)',...
        DOWNcolor,'FaceAlpha',0.2,'EdgeColor','none');

subplot(3,3,4)
imagesc(ratehist.bins,binsizes,log10(ratehist.hist)')
hold on
plot(log10(threshold).*[1 1],get(gca,'ylim'),'r')
plot(get(gca,'xlim'),(binsizes(bb)).*[1 1],'r')
axis xy
xlabel('Rate (Hz)');ylabel('Bin Size (ms)')
LogScale('xy',10)
%plot(ratehist.bins,ratehist.hist)

subplot(3,3,5)
imagesc(durhist.bins,binsizes,durhist.UP')
hold on
plot(get(gca,'xlim'),(binsizes(bb)).*[1 1],'r')
axis xy
LogScale('xy',10)
title('UP')

subplot(3,3,6)
imagesc(durhist.bins,binsizes,durhist.DOWN');
hold on
plot(get(gca,'xlim'),(binsizes(bb)).*[1 1],'r')
axis xy
LogScale('xy',10)
title('DOWN')

subplot(3,3,7)
plot(log10(UPDOWN(bb).dur.UP),log10(UPDOWN(bb).UPrate),'.')
box off
hold on
plot(durhist.bins,bz_NormToRange(durhist.DOWN(:,bb)))
plot(durhist.bins,bz_NormToRange(durhist.UP(:,bb)))
LogScale('xy',10)
xlabel('Dur (ms)');ylabel('UP Rate')

subplot(3,3,8)
plot(ratehist.bins,(ratehist.hist(:,bb)))
axis tight
LogScale('x',10)
box off
xlabel('Pop Rate (Hz)')

