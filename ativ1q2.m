clc
close all
clear
%Mylena - 28/09/20

%Coeficientes do Modelo
oi = 3;
a1 = -0.49;
a2 = -0.495;
b1 = 0.008856;
b2 = 0.004428;
u = 1;
N = 10;
%Condi��es Iniciais
y(0) = 0;
y(1) = 0;
y(2) = 0;
%Itera��o Recursiva
for t=3:N
 %Erro com modelo Gaussiano mean=0 std=5
 %Associado ao tempo de descarga
 e = 0+5*randn; %awgn
 y(t) = -a1*y(t-1)-a2*y(t-2)+b1*step(t-1)+b2*step(t-2)+e;
end
hold on
plot(step,y,'r')
hold off
legend('Experimental','Modelo ARX')
