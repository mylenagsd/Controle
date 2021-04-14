clc,
close all,
clear

T = 0.1; %Periodo de amostragem
K = 20;
Numd = K*[0.0655 0.02783];
Dend = [1 (0.0655*K-1.0672) (0.02783*K+0.0672)];
sys = tf(Numd,Dend,T);

%Entrada Degrau
u = [zeros(1,10) ones(1,50)];
L = length(u); %Tamanho do vetor
k = 0:(L-1); %numero inteiro
t = k*T; %tempo discreto kT

%Resposta ao Degrau
y = filter(Numd,Dend,u);
figure
stem(t,u,'.')
hold on
stem(t,y,'.')
xlabel('t = kT'),grid
legend('u(kT)','y(kT)')
axis([0 max(t) 0 1.2*max(y)])
hold off
figure
zplane(Numd,Dend) 