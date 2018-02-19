

R = 5;
g=0;
dt= 0.01;
b=1;
gsave=[];
for tt = 0:dt:20-dt
    if mod(tt,1/R)==0
        g = g+1;
    end
    dgdt=-b*g;
    dg = dgdt*dt;
    g = g+dg;
    gsave =[gsave g];
end
    

figure
plot(gsave)

%%
calcmean = R.*(1/b);
simmean = mean(gsave(end/2:end))



%%
re = linspace(0,50,500);
ri = linspace(0,50,500);
[Re, Ri]=meshgrid(re,ri);


gamma_e = we.*K.*Re.*tau_e;
gamma_i = wi.*K.*Ri.*tau_i;

%H = 


%%
ge = linspace(0,20,100);
gi = linspace(0,20,100);
[Ge, Gi]=meshgrid(ge,gi);

Ee = 0;
Ei = -70;
h = -50;

H = Ge.*Ee + Gi.*Ei + h;
Gamma = Ge+Gi+1;

Vinf = H./Gamma;

figure
imagesc(ge,gi,Vinf)
colorbar
axis xy
xlabel('g_e');ylabel('g_i')


%%

tau = 10;

h=linspace(-0.1,1.5,5000);
t_r = 1;

R = 1000./(-tau.*log((h-1)./h)+t_r);

figure
plot(h,R,'k')
hold on
plot(h,imag(R),'k')