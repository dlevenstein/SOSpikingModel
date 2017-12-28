function [ Ivals,rate,voltagemean ] = SimulateFICurve(simfunction,PopParams,Irange,numI,varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS
%   simfunction     simulation function. function should be passed through 
%                   as @SimFunctionName. And should have input/output:
%                   SimValues = simfunction(PopParams,TimeParams)                   
%   PopParams       population parameters structure to pass through to the
%                   simulation function
%   Irange          [min max] input current values
%   (options)
%   'showfig'       (true/false) default:true.  can also  pass through 
%                   string to name the figure
%   'figfolder'     name of folder to save the figure
%   'bistableramp'  (true/false) an option to calculate FI curve with
%                   increasing and decreasing input ramps, to test for
%                   bistability/histeresis (NOT YET FUNCTIONAL)
%   'timeparms'     a structure giving timing params for the simulations
%                 .simtime          Duration to simulate 
%                 .onsettransient   Onset transient to ignore
%
%

%% DEV
% simfunction = @EMAdLIFfunction;
% Irange = [150 500];
% numI = 26;

% POP PARMS 4 DEV
% PopParams.EPopNum = 1;
% PopParams.IPopNum = 1;
% PopParams.E_L     = -65;
% PopParams.g_L     = 30;
% PopParams.C       = 281;
% PopParams.V_th    = -55;
% PopParams.V_reset = -85;
% PopParams.E_e     = 0;
% PopParams.E_i     = -80;
% PopParams.E_w     = -70;
% PopParams.b_w     = 0.1;
% PopParams.b_s     = 1;
% PopParams.dw      = 0.2;
% PopParams.ds      = 0.5;
% PopParams.a       = 0.5;
% PopParams.b       = 0.1;
% PopParams.t_ref   = 0.2;
% PopParams.delta_T = 10;
% PopParams.Wee   = 0;
% PopParams.Wii   = 0;
% PopParams.Wie   = 0;
% PopParams.Wei   = 0; 
% PopParams.Kee   = 0;
% PopParams.Kii   = 0;
% PopParams.Kie   = 0;
% PopParams.Kei   = 0;
% PopParams.theta = 1/10;
% PopParams.gwnorm = 0;
% PopParams.w_r = 0.1;
%PopParams.sigma = 0;

%varargin = {};

%% Input options
defaulttimeparms.simtime = 4000; %ms, time to simulate each "trial"
defaulttimeparms.onsettransient = 100; %ms, onsiet transient time to ignore
figvalidation = @(x) islogical(x) || ischar(x);


p = inputParser;
addParameter(p,'showfig',true,figvalidation)
addParameter(p,'figfolder',[],@ischar)
addParameter(p,'bistableramp',false,@islogical)
addParameter(p,'timeparms',defaulttimeparms,@isstruct)
parse(p,varargin{:})
SHOWFIG = p.Results.showfig;
figfolder = p.Results.figfolder;
RAMP = p.Results.bistableramp;
timeparms = p.Results.timeparms;

if ischar(SHOWFIG)
    figname=SHOWFIG;
    SHOWFIG=true;
end

if RAMP
    error('''bistableramp'' option is not yet functional... sorry :''(')
end
%% Set the parameters
onsettransient = timeparms.onsettransient; %Onset transient to ignore
TimeParams.dt      = 0.05;
TimeParams.SimTime = timeparms.simtime;
%% Run the simulations
Ivals = linspace(Irange(1),Irange(2),numI);
clear SimValues
for ii = 1:numI
    ii
    PopParams.I_e     = Ivals(ii);
    [SimValues(ii)] = simfunction(PopParams,TimeParams,...
        'showfig',false,'save_dt',1,'onsettime',onsettransient,...
        'cellout',true);
end

%Add: display parameters from PopParams in figure.
%% Calculate Rate, Variable distributions
%rate = zeros(1,numI);
voltagebins = linspace(min([PopParams.V_reset,PopParams.E_L]),max(PopParams.V_th),100);
conductancebins = linspace(0,1,100);
isibins = linspace(0,3.5,60);
totaltime = timeparms.simtime;
clear voltagedist voltagemean adaptdist ISIdist rate
for ii = 1:numI
    %afteronsetspikes = SimValues(ii).spikes(:,1)>onsettransient;
    Espikes = ismember(SimValues(ii).spikes(:,2),SimValues(ii).EcellIDX);
    Ispikes = ismember(SimValues(ii).spikes(:,2),SimValues(ii).IcellIDX);

    rate.E(ii) = sum(Espikes)./PopParams.EPopNum./(totaltime./1000); %units: spikes/cell/s
    rate.I(ii) = sum(Ispikes)./PopParams.IPopNum./(totaltime./1000); %units: spikes/cell/s
    
    %Calculating ISI/rate distributions
    cellrates = cellfun(@length,SimValues(ii).spikesbycell)./(totaltime./1000);
    ISIs = cellfun(@diff,SimValues(ii).spikesbycell,'uniformoutput',false);
    ISIdist.E(:,ii) = hist(log10(cat(1,ISIs{SimValues(ii).EcellIDX})),isibins);
    ISIdist.E(:,ii) = ISIdist.E(:,ii)./max(ISIdist.E(:,ii));
    ISIdist.I(:,ii) = hist(log10(cat(1,ISIs{SimValues(ii).IcellIDX})),isibins);
    ISIdist.I(:,ii) = ISIdist.I(:,ii)./max(ISIdist.I(:,ii));
    
    %Calculating Voltage stats
    allcellsvoltage.E = reshape(SimValues(ii).V(SimValues(ii).EcellIDX,:),1,[]);
    allcellsvoltage.I = reshape(SimValues(ii).V(SimValues(ii).IcellIDX,:),1,[]);
    voltagedist.E(:,ii) = hist(allcellsvoltage.E,voltagebins);
    voltagedist.E(:,ii) = voltagedist.E(:,ii)./max(voltagedist.E(:,ii));
    voltagedist.I(:,ii) = hist(allcellsvoltage.I,voltagebins);
    voltagedist.I(:,ii) = voltagedist.I(:,ii)./max(voltagedist.I(:,ii));
    voltagemean.E(ii) = mean(allcellsvoltage.E);
    voltagemean.I(ii) = mean(allcellsvoltage.I);
    
    %Calculating Adaptation stats
    allcellsadaptation.E = reshape(SimValues(ii).g_w(SimValues(ii).EcellIDX,:),1,[]);
    allcellsadaptation.I = reshape(SimValues(ii).g_w(SimValues(ii).IcellIDX,:),1,[]);
    adaptdist.E(:,ii) = hist(allcellsadaptation.E,conductancebins);
    adaptdist.I(:,ii) = hist(allcellsadaptation.I,conductancebins);
    adaptmean.E(ii) = mean(allcellsadaptation.E);
    adaptmean.I(ii) = mean(allcellsadaptation.I);
end

%% Example Voltage Tracess
numextraces = 5;
extraces = round(linspace((0.5./numextraces).*numI,...
    ((numextraces-0.5)./numextraces).*numI,numextraces));
excells = [randsample(SimValues(1).EcellIDX,1) randsample(SimValues(1).IcellIDX,1)];
if length(SimValues(1).EcellIDX)==1; excells(1)=SimValues(1).EcellIDX; end
if length(SimValues(1).IcellIDX)==1; excells(1)=SimValues(1).IcellIDX; end
exrange = [0 300]; 
extimeIDX = SimValues(1).t>=exrange(1) & SimValues(1).t<=exrange(2);
extime = SimValues(1).t(extimeIDX);
clear exampletrace
for ii = 1:numextraces
    exampletrace.E(:,ii) = SimValues(extraces(ii)).V(excells(1),extimeIDX)';
    exampletrace.I(:,ii) = SimValues(extraces(ii)).V(excells(2),extimeIDX)';
end
%% Figure
if SHOWFIG

    Ecolor = makeColorMap([1 1 1],[0 0.5 0],[0 0 0]);
    Icolor = makeColorMap([1 1 1],[0.8 0 0],[0 0 0]);
    adaptcolor = makeColorMap([1 1 1],[0 0 0.8],[0 0 0]);

    figure
        subplot(3,2,1)
            plot(Ivals,rate.I,'o--','color',Icolor(end/2,:),'markersize',4)
            hold on
            plot(Ivals,rate.E,'o--','color',Ecolor(end/2,:),'markersize',4)
            legend('I','E','location','northwest')
            xlabel('I (pA)');ylabel('Rate (spks/cell/s)')
            xlim(Ivals([1 end]))

        subplot(6,2,7)
            imagesc(Ivals,isibins,ISIdist.I)
            colormap(gca,Icolor)
            axis xy
            LogScale('y',10)
            set(gca,'xticklabel',[])
            ylabel('I: ISI (ms)');
        subplot(6,2,5)
            imagesc(Ivals,isibins,ISIdist.E)
            colormap(gca,Ecolor)
            axis xy
            LogScale('y',10)
            set(gca,'xticklabel',[])
            ylabel('E: ISI (ms)');
        subplot(6,2,11)
            imagesc(Ivals,voltagebins,voltagedist.I)
            hold on
            plot(Ivals,voltagemean.I,'o--','color',Icolor(end/2,:),'markersize',4)
            colormap(gca,Icolor)
            plot(Ivals(extraces),min(voltagebins),'k^','markersize',2)
            axis xy
            %xlabel('I (pA)');
            ylabel('I: V_m');
        subplot(6,2,9)
            imagesc(Ivals,voltagebins,voltagedist.E)
            hold on
            plot(Ivals,voltagemean.E,'o--','color',Ecolor(end/2,:),'markersize',4)

            colormap(gca,Ecolor)
            axis xy
            %xlabel('I (pA)');
            ylabel('E: V_m');
            set(gca,'xticklabel',[])
    %     subplot(6,2,11)
    %         imagesc(Ivals,conductancebins,adaptdist.E)
    %         hold on
    %         plot(Ivals,adaptmean.E,'o--','color',adaptcolor(end/2,:),'markersize',4)
    %         axis xy
    %         colormap(gca,adaptcolor)
    %         xlabel('I (units?)');ylabel('g_w (E cells)');
    %     subplot(6,2,11)
    %         imagesc(Ivals,conductancebins,adaptdist.I)
    %         axis xy
    %         xlabel('I (units?)');ylabel('g_w (I cells)');

        %add synaptic conductances...
        %add noise etc parm text in figure

        vmin = min([PopParams.V_reset,PopParams.E_L]);
        vmax = max(PopParams.V_th);
        for ee = 1:numextraces
        subplot(numextraces,2,(ee.*2))
            plot(extime,exampletrace.E(:,ee),'color',Ecolor(end/2,:))
            hold on
            plot(extime,exampletrace.I(:,ee),'color',Icolor(end/2,:))
            ylim([vmin vmax])
            xlabel('t (ms)');
            ylabel({['I = ',num2str(round(Ivals(extraces(ee))))],'V_m'})

            if ee==1
                title('V: Example Traces')
            end
        end

    if ~isempty(figfolder)
        NiceSave('FICurve',figfolder,figname)
    end

end


end
