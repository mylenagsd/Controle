clc,
close all,
clear

T = 0.4; %Periodo de amostragem
K = 1;
Numd = K*[(2.5-2.5*exp(-2*T))];
Dend = [1 (2.5-3.5*exp(-2*T))];
sys = tf(Numd,Dend,T);

%Entrada Degrau
u = [zeros(1,10) ones(1,50)];
L = length(u); %Tamanho do vetor
k = 0:(L-1); %numero inteiro
t = k*T; %tempo discreto kT

%Entrada Impulso
w = [zeros(1,10) ones(1,1), zeros(1,49)];

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

%Resposta ao Impulso
y2 = filter(Numd,Dend,w);
figure
stem(t,w,'.')
hold on
stem(t,y2,'.')
xlabel('t = kT'),grid
legend('w(kT)','y2(kT)')
axis([0 max(t) 0 1.2*max(y2)])
hold off