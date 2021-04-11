clc,
close all,
clear

T = 1; %Periodo de amostragem
K = 2;
Numd = K*[1 -0.63212 0.26424];
Dend = [1 (0.36788*K-1.36788) (0.26424*K+0.36212)];
sys = tf(Numd,Dend,T);

%Entrada Degrau
u = [zeros(1,10) ones(1,50)];
L = length(u); %Tamanho do vetor
k = 0:(L-1); %numero inteiro
t = k*T; %tempo discreto kT

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

for i=1:1:26
    K=i/10;
    Numd = K*[1 -0.63212 0.26424];
    Dend = [1 (0.36788*K-1.36788) (0.26424*K+0.36212)];
    sys(i) = tf(Numd,Dend,T);
end

figure
hold on
pzmap(sys(1),sys(2),sys(3),sys(4),sys(5),sys(6),sys(7),sys(8),sys(9),sys(10),sys(11),sys(12),sys(13),sys(14),sys(15),sys(16),sys(17),sys(18),sys(19),sys(20),sys(21),sys(22),sys(23),sys(24),sys(25),sys(26))
axis([-1.25 1.25 -1.25 1.25])   
hold off