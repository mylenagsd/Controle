%clc 
close all
%clear
%Mylena - 20/09/2020

fo1 = 10;   %freq1 do sinal
fo2 = 50;   %freq2 do sinal
fs = 1000;  %freq de amostragem
Ts = 1/fs;  %periodo de amostragem
L = 200;
n = 0:(L-1);
w = 0:(140);
t = Ts*n;
t2 = Ts*w;

x = cos(2*pi*fo1*t)+0.5*sin(2*pi*fo2*t+pi/4); %sinal de entrada sem ruído 
x1 = 0.1*randn(1,L); %ruído
x2 = cos(2*pi*fo1*t)+0.5*sin(2*pi*fo2*t+pi/4)+x1; %sinal de entrada com ruído

%Gráfico para o sinal discretizado
figure
stem(t,x)
xlabel('t')
ylabel('x(t)')
grid
title('Sinal discretizado');

%análise em freq (DFT)
k = 0:(L-1);
omega = 2*pi*k/L;
Xdft = fft(x);
Xdft2 = fft(x2);
figure
stem(omega,abs(Xdft),'.')
xlabel('\Omega')
ylabel('|X(\Omega)|')
grid

%análise em HZ
k = 0:(L-1);
omega = 2*pi*k/L;
fhz = omega*fs/(2*pi);
Xdft = fft(x);
figure
stem(fhz(1:L/2),abs(Xdft(1:L/2)),'.')
xlabel('Hz')
ylabel('|X(f)|')
grid
title('FFT do sinal sem ruido');

%Determinandoa fase x frequência
tol = 1e-6;
Xdft(abs(Xdft) < tol) = 0;
p = unwrap(angle(Xdft));                     
figure
stem(fhz(1:L/2),abs(p(1:L/2))*180/pi,'.')
xlabel 'Hz'
ylabel '|Fase|'
grid
title('Fase da FFT')

%Determinandoa fase x frequência
tol = 1e-6;
Xdft2(abs(Xdft2) < tol) = 0;
p2 = unwrap(angle(Xdft2));                     
figure
stem(fhz(1:L/2),abs(p2(1:L/2))*180/pi,'.')
xlabel 'Hz'
ylabel '|Fase|'
grid
title('Fase da FFT com ruído')

%análise em frequência com adição de ruído
figure
stem(fhz(1:L/2),abs(Xdft2(1:L/2)),'.')
xlabel('Hz')
ylabel('|X(f)|')
grid
title('FFT do sinal com ruido');

%obtenção do SNR
Psinal = bandpower(x2,fs,[0 fs/2]); %Potência do sinal
Pruido = bandpower(x1,fs,[0 fs/2]); %Potência do ruído
SNR = 10*log(Psinal/Pruido);

in = sin(2*pi*100*t2); %Sinal de entrada para a questão 2
erroZ = rms(eZoH)^2; %cálculo do erro quadrático médio do ZoH
erroF = rms(eFoH)^2; %cálculo do erro quadrático médio do FoH

%o simulink fornece uma coluna de valores, a seguir transformada em um vetor
eZoHv = eZoH.';
eFoHv = eFoH.'; 

%Obtendo gráficos apartir dos dados gerados pelo esquema no simulink
figure
plot(t,eZoHv'.')
xlabel('t')
ylabel('x(t)')
grid
title('Erro de reconstrução pelo ZoH');
figure
plot(t,eFoHv'.')
xlabel('t')
ylabel('x(t)')
grid
title('Erro de reconstrução pelo FoH');