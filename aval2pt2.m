clc,
close all,
clear

T = 1; %Periodo de amostragem
K = 0.5;
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
stairs(t,u)
hold on
stairs(t,y)
xlabel('t = kT'),grid
legend('u(kT)','y(kT)')
axis([0 max(t) 0 1.2*max(y)])
hold off
figure
zplane(Numd,Dend)

figure
for i=1:1:50
    K=i/10;
    Numd = K*[1 -0.63212 0.26424];
    Dend = [1 (0.36788*K-1.36788) (0.26424*K+0.36212)];
    sys(i) = tf(Numd,Dend,T);
    hold on
pzmap(sys(i));
axis([-1.25 1.25 -1.25 1.25]) 
end
hold off

figure
hold on
pzmap(sys(5),sys(15),sys(24))
axis([-1.25 1.25 -1.25 1.25])   
hold off


K = 0:0.01:5;
x = [];
y = [];

Numd = [0.5 -0.316 0.132]; %[0.368 0.264]
Dend = [1 -1.184 0.498]; %[1 -1.368 0.368]
%for i=1:length(K)
%Dend2 = [1 (0.36788*K(i)-1.36788) (0.26424*K(i)+0.36212)];
sysx = tf(Numd,Dend,T);
z = roots(Numd);
s =(log(z)/T);
x = [x real(s)'];
y = [y imag(s)'];
%end

figure
plot(x,y,'O')
grid
xlabel('Real')
ylabel('Imaginario')

figure
rlocus(sysx)

Num = 1;
Den = [1 1 0];
sysy = tf(Num, Den);
figure
rlocus(sysy)