clc 
close all
clear

Ts = 0.1;
Numd = [0.09516];
Dend = [1 -0.9048];
sys = tf(Numd,Dend,Ts)

fs = 1/Ts;  %freq de amostragem
L = 100;
n = 0:(L-1);
t = Ts*n;

k = 0:(L-1);
omega = 2*pi*k/L;
fhz = omega*fs/(2*pi);

figure
zplane(Numd,Dend),grid
figure
[Y,T,X]=step(sys,10)
plot(T,Y,'.r'),grid
xlabel('k');
ylabel('y(k)')
figure
step(sys,10)
grid

NUM = (0.09516);
DEN = (cos(omega) - 0.9048) + j*(sin(omega));
H = NUM./DEN;
modulo = 20*log10(abs(H));
figure
stem(fhz(1:L),modulo(1:L))
xlabel('Hz');
ylabel('Módulo(dB)');
grid

figure
freqz(Numd,Dend,L,Ts)

stepinfo(sys)