

mu = 50;
sigma = 50;
gamma = 2;
[sol,isi] = ISI_GreensFunction(mu,sigma,gamma);

%%
figure
imagesc(sol')
colorbar
