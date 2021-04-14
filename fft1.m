clc 
close all
clear

fo = 100;   %freq do sinal
fs = 1000; %freq de amostragem
Ts = 1/fs; %periodo de amostragem
L = 100;
n = 0:(L-1);
t = Ts*n;
x = sin(2*pi*fo*t)+0.2*randn(1,L);
figure
stem(t,x)
xlabel('t')
ylabel('x(t)')
grid

%analise em freq (DFT)
k = 0:(L-1);
omega = 2*pi*k/L;
Xdft = fft(x);
figure
stem(omega,abs(Xdft),'.')
xlabel('\Omega')
ylabel('|X(\Omega)|')
grid

fhz = omega*fs/(2*pi);
figure
stem(fhz(1:L/2),abs(Xdft(1:L/2)),'.')
xlabel('Hz')
ylabel('|X(f)|')
grid