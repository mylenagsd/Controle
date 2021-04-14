clc
close all
clear

fo = 1;   %freq1 do sinal
fs = 10;  %freq de amostragem
Ts = 1/fs;  %periodo de amostragem
L = 20;
n = 0:(L-1);
t = Ts*n;

x = sin(2*pi*fo*t+pi/2)

%Gráfico para o sinal discretizado
figure
stem(t,x)
xlabel('t')
ylabel('x(t)')
grid
title('Sinal discretizado');

%y = 0.9048

%syms z
%Y = (z+2)*z/((z-0.5)*(z+0.5)*(z-1));
%y = iztrans(Y);
%pretty(y)

%análise em HZ
n = 0:(L-1);
omega = 2*pi*n/L;
fhz = omega*fs/(2*pi);
Xdft = fft(x);
figure
stem(fhz(1:L/2),abs(Xdft(1:L/2)),'.')
xlabel('Hz')
ylabel('|X(f)|')
grid
title('FFT do sinal de entrada');

y = zeros(1,20); 
yk1 = 0;
k = 1;
while k < 20
    y(k) = 0.9048*yk1 + 0.09516*x(k);
    yk1 = y(k);
    k = k+1;
end
figure
stem(t,y)
xlabel('t')
ylabel('y(t)')
grid
title('Sinal de saída')

%análise em HZ
n = 0:(L-1);
omega = 2*pi*n/L;
fhz = omega*fs/(2*pi);
Ydft = fft(y);
figure
stem(fhz(1:L/2),abs(Ydft(1:L/2)),'.')
xlabel('Hz')
ylabel('|Y(f)|')
grid
title('FFT do sinal de saída');

%Determinandoa fase x frequência
tol = 1e-6;
Xdft(abs(Xdft) < tol) = 0;
p = unwrap(angle(Xdft));                     
figure
stem(fhz(1:L/2),abs(p(1:L/2))*180/pi,'.')
xlabel 'Hz'
ylabel '|Fase|'
grid
title('Fase da FFT da entrada')

%Determinandoa fase x frequência
tol = 1e-6;
Ydft(abs(Ydft) < tol) = 0;
p2 = unwrap(angle(Ydft));                     
figure
stem(fhz(1:L/2),abs(p2(1:L/2))*180/pi,'.')
xlabel 'Hz'
ylabel '|Fase|'
grid
title('Fase da FFT da saída')