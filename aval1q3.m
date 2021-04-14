clc
close all
%clear

fo = 10;
fs = 100;  %freq de amostragem
Ts = 1/fs;  %periodo de amostragem
L = 20;
n = 0:(L-1);
t = Ts*n;
k = 0:(L-1);
omega = 2*pi*k/L;
fhz = omega*fs/(2*pi);
x = cos(2*pi*fo*t+pi/2);

figure
stem(t,x)
xlabel('t')
ylabel('x(t)')
grid
title('Sinal discretizado');

h1 = h1.';
h2 = h2.';
x1 = x1.';

figure
subplot(2,1,1)
hold on
plot(tout,x1'.')
plot(tout,h2'.')
hold off
xlabel('t')
ylabel('h1(t)')
grid
subplot(2,1,2)
e = x1-h1;
%plot(t,e'.')
grid

erroZ = rms(e).^2; %erro = 4.7%

figure
subplot(2,1,1)
hold on
plot(t,x'.')
plot(t,h2(0:20))
hold off
xlabel('t')
ylabel('h2(t)')
grid
subplot(2,1,2)
e2 = x-h2;
plot(t,e2'.')
grid

erroZ = rms(e2).^2; %erro = 4.7%

%Determinandoa fase x frequência
Xdft = fft(x);
figure
stem(fhz(1:L/2),abs(Xdft(1:L/2)),'.')
xlabel('Hz')
ylabel('|X(f)|')
grid
title('FFT do sinal sem ruido');

tol = 1e-6;
Xdft(abs(Xdft) < tol) = 0;
p = unwrap(angle(Xdft));                     
figure
stem(fhz(1:L/2),abs(p(1:L/2))*180/pi,'.')
xlabel 'Hz'
ylabel '|Fase|'
grid
title('Fase da FFT')


%erroZ = rms(eZoH).^2;
%erroF = rms(eFoH).^2;
