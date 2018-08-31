function SimulateFICurveServer(PopParams,Ivals,index,folder,name)

TimeParams.SimTime = 5e3;

PopParams.I_e = Ivals(index);
SimValuesUP = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);
save([folder name type '.mat'],'SimValuesUP','-v7.3');

PopParams.I_e = @(t) (500 - Ivals(index)).*heaviside(1000 - t)+Ivals(ii);
SimValuesDOWN = AdLIFfunction_STDP(PopParams,TimeParams,'cellout',true,'showprogress',true,'showfig',false,'save_weights',TimeParams.SimTime);
save([folder name type '.mat'],'SimValuesDOWN','-v7.3');

end