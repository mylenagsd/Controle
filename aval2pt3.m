clc
close all
clear

%MA sem compensador
Num = [25];
Den = [1 6 0];
sysMA = tf(Num,Den);
figure
rlocus(sysMA);
%figure
%step(sysMA)
%axis([-7 1 -5 5])
%title('LGR MA sem Gc')

%MF sem compensador
Num1 = [25];
Den1 = [1 6 25];
sysMF = tf(Num1,Den1);
figure
step(sysMF,5);
%title('Resposta ao Degrau MF sem Gc')

%MA com compensador genérico
a=18.75;
Num2 = [25 25*a];
Den2 = [1 6 0];
sysMA1 = tf(Num2,Den2);
figure
rlocus(sysMA1);
title('LGR MA com Gc')

%MF com compensador genérico
Num3 = [25 25*a];
Den3 = [1 31 25*a];
sysMF2 = tf(Num3,Den3);
%figure
%step(sysMF2,3);
%title('Resposta ao Degrau MF com Gc')

%figure
%bode(sysMF)
%title('Bode do sistema sem Gc')
%figure
%bode(sysMF2)
%title('Bode do sistema com Gc')

%MF com controlador Foward diff (Euler)
Tsamp = 0.06;
Numd = [25*Tsamp 25*a*(Tsamp^2)-25*Tsamp]; %[1.125 -0.176];
Dend = [1 (31*Tsamp)-2 25*a*(Tsamp^2)-(31*Tsamp)+1]; %[1 -0.605 0.554];
sysMF2dF = tf(Numd,Dend,Tsamp);
figure
%hold on
step(sysMF2dF);
stepinfo(sysMF2dF)
zplane(Numd,Dend)
title('Forward')

%MF com controlador Backwad diff
Numd1 = [25*a*(Tsamp^2)+25*Tsamp -25*Tsamp 0];
Dend1 = [1+(31*Tsamp)+25*a*(Tsamp^2) -(2+31*Tsamp) 1];
sysMF2dB = tf(Numd1,Dend1,Tsamp);
figure
step(sysMF2dB);
stepinfo(sysMF2dB)
zplane(Numd1,Dend1)
title('Backward')

%MF com controlador Tustin-Bilinear
Numd2 = [25*a*(Tsamp^2)+50*Tsamp 50*a*(Tsamp^2) 25*a*(Tsamp^2)-50*Tsamp];
Dend2 = [4+(62*Tsamp)+25*a*(Tsamp^2) (50*a*(Tsamp^2)-8) 4-62*Tsamp+25*a*(Tsamp^2)];
sysMF2dT = tf(Numd2,Dend2,Tsamp);
figure
step(sysMF2dT);
stepinfo(sysMF2dT)
zplane(Numd2,Dend2)
title('Tustin-Bilinear')
%hold off
%legend('forward','backward','tustin');

Tsamp1 = 0.17; %0.15;
%MA sem compensador discretizado
Numd3 = [0.243 0.128];
Dend3 = [1 -1.407 0.407];
sysMAd = tf(Numd3,Dend3,Tsamp1);
figure
step(sysMAd,80) %80s compara com o sistema contínuo
title('Malha aberta discretizada')
figure
zplane(Numd3,Dend3);
title('Malha aberta discretizada')

Tsamp2 = 0.06;
%MF sem compensador discretizado
Numd4 = [0.243 0.128];
Dend4 = [1 -1.164 0.535];
sysMAd2 = tf(Numd4,Dend4,Tsamp2);
figure
step(sysMAd2,5)
title('Malha fechada discretizada')
figure
zplane(Numd4,Dend4);
title('Malha fechada discretizada')


%confere
digits(4);
syms z a Tsamp;
Tsamp = 0.06; %0.045;
a=18.75;
G(z) = ((25*Tsamp*z+25*a*(Tsamp^2)-25*Tsamp)/((z^2)+((31*Tsamp)-2)*z+25*a*(Tsamp^2)-(31*Tsamp)+1));
disp('G(z)=');
pretty(vpa(G(z)));
%confere
G2(z) = (((25*a*(Tsamp^2)+25*Tsamp)*(z^2)-25*Tsamp*z)/((1+31*Tsamp+25*a*(Tsamp^2))*(z^2)-(31*Tsamp+2)*z+1));
disp('G2(z)=');
pretty(vpa(G2(z)));
%confere
G3(z) = (((25*a*(Tsamp^2)+50*Tsamp)*(z^2)-50*a*(Tsamp^2)*z+25*a*(Tsamp^2)-50*Tsamp)/((4+62*Tsamp+25*a*(Tsamp^2))*(z^2)-(50*a*(Tsamp^2)-8)*z+4-62*Tsamp+25*a*(Tsamp^2)));
disp('G3(z)=');
pretty(vpa(G3(z)));
