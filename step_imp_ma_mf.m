clc
close all
clear 

Ts = 0.1;
%sistema continuo
A = [-1 1;
     0 -1];
B = [0; 1];
C = [2 1];
D = [0]
sys1 = ss(A,B,C ,D)
figure
subplot(2,1,1)
step(sys1,10)
grid
subplot(2,1,2)
impulse(sys1,10)
grid

%sistema discreto aproximação
Ad = [0.9 0.1;
     0 0.9];
Bd = [0; 0.1];
Cd = [2 1];
Dd = [0]
sys2 = ss(Ad,Bd,Cd,Dd,Ts)
figure
subplot(2,1,1)
step(sys2,10)
grid
subplot(2,1,2)
impulse(sys2,10)
grid

%passando variaveis para o simulink
kp = 10;
ki = 0;
kd = 0;
tsimu = 20;
sim('modelo',tsimu);

%passando os resultados para o scrit
kp = 10;
ki = 0;
kd = 0;
tsimu = 20;
sim('modelo',tsimu);

figure 
plot(tout,indegrau)
hold on
plot(tout,ymalhaaberta)
plot(tout,ymalhafechada)
hold off
grid
legend('entrada', 'MA', 'MF')
xlabel('tempo(s)')