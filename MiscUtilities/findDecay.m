function [vals] = findDecay(t,f)

T = length(t);

% a1 = 5;
% a2 = 1;
% b1 = 1;
% b2 = 1;

a = 5;
b = 1;
c = 1;

iter = 3e5;

C = zeros(1,iter);

% Ea1 = 0;
% EDa1 = 0;
% 
% Ea2 = 0;
% EDa2 = 0;
% 
% Eb1 = 0;
% EDb1 = 0;
% 
% Eb2 = 0;
% EDb2 = 0;

Ea = 0;
EDa = 0;

Eb = 0;
EDb = 0;

Ec  = 0;
EDc = 0;

M = exp(-t./5)./sum(exp(-t./5)); %Weighted Mean

tic
for ii = 1:iter
    
    C(ii) = sum(M.*(f-b.*exp(-a.*t)-c).^2)./T;
    
    dCda = sum(M.*2.*(f-b.*exp(-a.*t)-c).*(b.*t.*exp(-a.*t)))./T;
    dCdb = sum(M.*2.*(f-b.*exp(-a.*t)-c).*(-exp(-a.*t)))./T;
    
    dCdc = sum(-M.*2.*(f-b.*exp(-a.*t)-c))./T;
    
    [da,Ea,EDa] = AdaDelta(Ea,EDa,dCda);
    [db,Eb,EDb] = AdaDelta(Eb,EDb,dCdb);
    
    [dc,Ec,EDc] = AdaDelta(Ec,EDc,dCdc);
    
    a = a - da;
    b = b - db;
    c = c - dc;
    
%     C(ii) = sum((f-b1.*exp(-a1.*t)-b2.*exp(-a2.*t)-c).^2)./T;
%     
%     dCda1 = sum(2.*(f-b1.*exp(-a1.*t)-b2.*exp(-a2.*t)-c).*(b1.*t.*exp(-a1.*t)))./T;
%     dCda2 = sum(2.*(f-b1.*exp(-a1.*t)-b2.*exp(-a2.*t)-c).*(b2.*t.*exp(-a2.*t)))./T;
%     
%     dCdb1 = sum(2.*(f-b1.*exp(-a1.*t)-b2.*exp(-a2.*t)-c).*(-exp(-a1.*t)))./T;
%     dCdb2 = sum(2.*(f-b1.*exp(-a1.*t)-b2.*exp(-a2.*t)-c).*(-exp(-a2.*t)))./T;
%     
%     dCdc = sum(-2.*(f-b1.*exp(-a1.*t)-b2.*exp(-a2.*t)-c))./T;
%     
%     [da1,Ea1,EDa1] = AdaDelta(Ea1,EDa1,dCda1);
%     [da2,Ea2,EDa2] = AdaDelta(Ea2,EDa2,dCda2);
%     
%     [db1,Eb1,EDb1] = AdaDelta(Eb1,EDb1,dCdb1);
%     [db2,Eb2,EDb2] = AdaDelta(Eb2,EDb2,dCdb2);
%     
%     [dc,Ec,EDc] = AdaDelta(Ec,EDc,dCdc);
%     
%     a1 = a1 - da1;
%     a2 = a2 - da2;
%     b1 = b1 - db1;
%     b2 = b2 - db2;
%     c = c - dc;
    
end
toc

% vals.a1 = a1;
% vals.a2 = a2;
% vals.b1 = b1;
% vals.b2 = b2;
vals.a = a;
vals.b = b;
vals.c = c;
vals.S = b.*exp(-a.*t)+c;
vals.C = C;
vals.ii = ii;

end