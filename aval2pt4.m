clc
close all
clear

%MA sem Gc
Num1 = [1];
Den1 = [10 1 0];
sysMA = tf(Num1,Den1);
figure
rlocus(sysMA);
axis([-0.2 0.1 -0.5 0.5])
title('LGR MA');

%MF sem Gc
Num2 = [1];
Den2 = [10 1 1];
sysMF = tf(Num2,Den2);
%figure
%step(sysMF);
stepinfo(sysMF)

%%
%MA com Gc
a = 0.772;
K = 18; %8.995; %-calculado
Num3 = K*[1 a];
Den3 = [10 1 0];
sysMAc = tf(Num3,Den3);
%figure
%rlocus(sysMAc);
%title('LGR MA com Gc')

%MF com Gc
Num4 = K*[1 a];
Den4 = [10 1+K K*a];
sysMFc = tf(Num4,Den4);
figure
step(sysMFc,20);
title('Resposta ao Degrau MF com Gc')
stepinfo(sysMFc)

%%
%MA com PD discretizado Tustin
Tsamp = 1;
a = 0.772;
K = 18; %8.995; -calculado
Num5 = K*[a*(Tsamp^2)+2*Tsamp 2*a*(Tsamp^2) a*(Tsamp^2)-2*Tsamp];
Den5 = [40+2*Tsamp -80 40-2*Tsamp];
sysMAd = tf(Num5,Den5,1);
%figure
%rlocus(sysMAd);
%zplane(Num5,Den5);
%title('LGR MA com PD discr')

%MF com PD discretizado Tustin
Num6 = K*[a*(Tsamp^2)+2*Tsamp 2*a*(Tsamp^2) a*(Tsamp^2)-2*Tsamp];
Den6 = [40+2*Tsamp+K*2*Tsamp+K*a*(Tsamp^2) K*a*2*(Tsamp^2)-80 40-2*Tsamp+K*a*(Tsamp^2)-K*2*Tsamp];
sysMFd = tf(Num6,Den6,1);
%figure
%step(sysMFd);
%title('Resposta ao Degrau MF com PD discr')
%stepinfo(sysMFd)

%%
%MA sem Gc discretizado ZoH
Tsamp = 1;
Num7 = [0.04838 0.04679];
Den7 = [1 -1.905 0.905];
sysMAd1 = tf(Num7,Den7,Tsamp);
figure
rlocus(sysMAd1);
%zplane(Num7,Den7);
title('LGR MA sem Gc discr por ZoH')

%MF sem Gc discretizado ZoH
Num8 = [0.04838 0.04679];     
Den8 = [1 -1.857 0.952];       
sysMFd1 = tf(Num8,Den8,Tsamp);
%figure
%step(sysMFd1);
%title('Resposta ao Degrau MF sem Gc discr por ZoH')
stepinfo(sysMFd1)

%%
%MA com Gc discretizado
Tsamp = 1;
K2 = 27; %0.655 %-calculado
a2 = 0.466;    %0.466;
b2 = 0.1;
Num9 = K2*conv([1 -a2],[0.04838 0.04679]);
Den9 = [1 -1.905 0.905];
sysMAd2 = tf(Num9,Den9,Tsamp);
figure
rlocus(sysMAd2);
%zplane(Num9,Den9);
title('LGR MA com Gc discr')

%MF com Gc discretizado
Num10 = K2*[0.04838 0.04679-0.04838*a2 -0.04679*a2];     
Den10 = [1+K2*0.04838 0.04679*K2-1.905-0.04838*K2*a2 0.905-K2*0.04679*a2];       
sysMFd2 = tf(Num10,Den10,Tsamp);
figure
step(sysMFd2);
title('Resposta ao Degrau MF com Gc discr')
stepinfo(sysMFd2)

%Entrada Degrau
T=1;
u = [ones(1,50)];
L = length(u); %Tamanho do vetor
k = 0:(L-1); %numero inteiro
t = k*T; %tempo discreto kT
%rampa
w=t.*u;

%Resposta a Rampa
y = filter(Num10,Den10,w);
figure
stairs(t,w)
hold on
stairs(t,y)
xlabel('t = kT'),grid
legend('Rampa de entrada','Resposta')
axis([0 max(t) 0 1.2*max(y)])
hold off
title('Resposta a Rampa MF com Gc discr')

%MF com PID discretizado
Num11 = K2*[0.04838 0.04679-0.04838*a2 -0.04679*a2];     
Den11 = [1 K2*0.04838-0.905-b2 0.04679*K2-1-0.04838*K2*a2+1.905*b2 0.905-K2*0.04679*a2+0.905*b2];       
sysMFd3 = tf(Num11,Den11,Tsamp);
%figure
%step(sysMFd3);
%title('Resposta ao Degrau MF com PID discr')
%stepinfo(sysMFd3)

%figure
%bode(sysMF)
%title('Bode do sistema sem PD')
%figure
%bode(sysMFc)
%title('Bode do sistema com PD')

%confere
digits(4);
syms z a2 K2 Tsamp2;
%K2 = 18;
%Tsamp2 = 1;
%a2 = 0.772;
%G1(z) = (K2*((a2*(Tsamp2^2)+2*Tsamp2)*(z^2)+2*a2*(Tsamp2^2)*z+a2*(Tsamp2^2)-2*Tsamp2)/((40+2*Tsamp2)*(z^2)-80*z+40-2*Tsamp2));
%disp('G1(z)=');
%pretty(vpa(G1(z)));
%T1(z) = (K2*((a2*(Tsamp2^2)+2*Tsamp2)*(z^2)+2*a2*(Tsamp2^2)*z+a2*(Tsamp2^2)-2*Tsamp2)/((40+2*Tsamp2+K2*2*Tsamp2+K2*a2*(Tsamp2^2))*(z^2)+(K2*a2*2*(Tsamp2^2)-80)*z+40-2*Tsamp2+K2*a2*(Tsamp2^2)-K2*2*Tsamp2));
%disp('T1(z)=');
%pretty(vpa(T1(z)));
T1(z) = (K2*(0.04838*(z^2)+(0.04679-0.04838*a2)*z-0.04679*a2))/((1+K2*0.04838)*(z^2)+(0.04679*K2-1.905-0.04838*K2*a2)*z+0.905-K2*0.04679*a2);
disp('T1(z)=');
pretty(vpa(T1(z)));

