digits(4);
syms s z k;

% k=1; 
G(s) = (k/(s^2*(s+1)));
G_fr(s) = partfrac(G(s));
disp('G(s)=');
pretty(vpa(G_fr(s)));

Gt = ilaplace(G(s));
Gz(z) = (1-z^-1)*ztrans(Gt);
disp('G(z)=');
pretty(vpa(collect(Gz(z))));

T(k) = Gz(z)/(1+Gz(z));
disp('T(z)=');
pretty(vpa(collect(T(k))));
