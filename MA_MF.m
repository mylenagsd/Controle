clc,
close all,
clear

%digits(4);
syms s z k a;

k=8; 
a=0.772;
G(s) = ((0.1)/(s^2*(s+0.1)));
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

%MA sem PD discretizado
Num5 = [0.1873 -0.1752];
Den5 = [1 -1.8187 0.8187];
sysMAd = tf(Num5,Den5,2);
figure
rlocus(sysMAd);
%zplane(Num5,Den5);
title('LGR MA com PD discr')

%MF sem PD discretizado
Num6 = [0.1873 -0.1752];
Den6 = [1 -1.6314 0.6435];
sysMFd = tf(Num6,Den6,2);
figure
step(sysMFd);
title('Resposta ao Degrau MF com PD')
stepinfo(sysMFd)

%[num,den]=numden(G_fr(s)); % separates the num. and denom. and removes F from the numerator
%Num=sym2poly(num); % converts the symbolic num. to the standard vector for a poly
%Den=sym2poly(den); % converts the symbolic denom. to the standard vector for a poly
%H=tf(Num,Den) % generates the standard transfer function
%rlocus(H)