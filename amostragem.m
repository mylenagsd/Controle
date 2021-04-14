clc
close all
clear
%mylena 11/09/2020

f = 100;
fs = 1000;
Ts = 1/fs;
N = 20; %20 amostras na janela de aquisição
n = 0:1:(N-1); %vetor de numeros inteiros
t = n*Ts; %vetor de tempo discreto
x = cos(2*pi*f*t);

figure
stem(n,x,'.r')
xlabel('amostras')
ylabel('amplitude')
grid
hold on
plot(n,x,'b')
hold off
legend('discreto','continuo')

figure
stem(t,x,'.r')
xlabel('tempo')
ylabel('amplitude')
grid
hold on
plot(t,x,'b')
hold off
legend('discreto','continuo')
