%clc
close all
%clear
%Mylena - 23/09/20

fo1 = 10;   %freq1 do sinal
fo2 = 50;   %freq2 do sinal
fs = 1000;  %freq de amostragem
Ts = 1/fs;  %periodo de amostragem
N = fs/fo2;
%L = 200;
n = 0:(N-1);
t = Ts*n;

x = cos(2*pi*fo2*t)+0.5*sin(2*pi*fo2*t+pi/4);
x1 = 0.1*randn(1,N);
x2 = cos(2*pi*fo2*t)+0.5*sin(2*pi*fo2*t+pi/4)+x1;

%analise em freq (DFT)
k = 0:(N-1);
omega = 2*pi*k/N;
Xdft = fft(x);
Xdft2 = fft(x2);
fhz = omega*fs/(2*pi);

tol = 1e-6;
Xdft(abs(Xdft) < tol) = 0;
p = unwrap(angle(Xdft));                     
%figure
%stem(fhz(1:N/2),abs(p(1:N/2))*180/pi,'.')
xlabel 'Hz'
ylabel '|Fase|'
grid
title('Fase da FFT')

%Determinandoa fase x frequência
fasex = zeros(1,N);
[valor, indice] = max(abs(Xdft2(1:N/2)));
NumeroComplexo = Xdft2(indice);
figure
fasex(indice) = angle(NumeroComplexo)*180/pi;
stem(fhz(1:N/2),fasex(1:N/2),'.r')
grid
xlabel('Hz')
ylabel('fase')
%axis([0 450 -pi/2 pi/2])

%j = sqrt(-1);
%a+b*1i = Xdft(10);
%a = real(Xdft);
%b = imag(Xdft);
%fase = atan(b/a);
%figure
%plot(fhz,fase,'.');
%grid

Psinal = bandpower(x2,fs,[0 fs/2]);
Pruido = bandpower(x1,fs,[0 fs/2]);
SNR = 10*log(Psinal/Pruido);

in = sin(2*pi*100*t);
erroZ = rms(eZoH)^2;
erroF = rms(eFoH)^2;

eZoHv = eZoH.';
errZ = immse(eZoHv,in);
eFoHv = eFoH.';
errF = immse(eFoHv,in);
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
%tempo no simulink pra te 200x1 = 0.0701 (1000 amostras)
%tempo no simulink pra te 200x1 = 0.0152 (5000 amostras)

