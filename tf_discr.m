clc
close all
clear
%Mylena - 16/09/2020

Num = [1 2];
Den = conv([1 -0.5],[1 0.50]);

%Sistema
Ts = 0.01; %Tempo de amostragem
T = 0:Ts:1; %Tempo de simula��o
sys = tf(Num, Den, Ts); %Fun��o de transfer�ncia

%Resposta ao degrau
figure
step(sys, T)
grid

%Resposta ao impulso
figure
impulse(sys, T)
grid


N = 100; %numero de pontos
figure
freqz(Num, Den, N)
