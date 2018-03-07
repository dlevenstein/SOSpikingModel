
mu = -50;
sigma = 5;
gamma = 2;
[sol,isi] = ISI_GreensFunction(mu,sigma,gamma);

%%
figure
imagesc(sol')
colorbar
