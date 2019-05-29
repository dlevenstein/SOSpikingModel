function [X,fval] = TimeConstantFitting(data)

%%
t = data.t;
val = data.val;

[slope] = polyfit(t,log(val),1);

%%
if slope(1) > 0 
initial = [3,-1,slope(1).^(-1),-1,slope(1).^(-1)];
else
initial = [0,1,abs(slope(1).^(-1)),1,abs(slope(1).^(-1))];
end

%%
F = @(a) a(1) - a(2).*exp(-t./a(3)) - a(4).*exp(-t./a(5));
C = @(a) sum(abs(F(a)-val),2);

options = optimset('PlotFcns',@optimplotfval);
options.MaxFunEvals = 1e6;
options.TolFun = 1e-10;
options.MaxIter = 1e6;
[X,fval] = fminsearch(C,initial,options);

%%
figure
subplot(2,1,1)
plot(t,val,'k')
hold on
plot(t,F(X),'r')
legend('Data','Prediction')
xlabel('Time (ms)','FontSize',20);ylabel('Data Value','FontSize',20)

subplot(2,2,3)
text(0.1,0.8,['\tau_1: ' num2str(min([X(1),X(2)])) ' ms'],'FontSize',16)
hold on
text(0.1,0.6,['\tau_2: ' num2str(max([X(1),X(2)])) ' ms'],'FontSize',16)
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])

end

