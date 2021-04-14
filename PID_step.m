clc
close all
clear

Kp = 1373.92;
Ki = 5000;
Kd = 150.88;

%Sistema realimentado com PID
Num = 0.25*[Kd Kp Ki];
Den = [1 (6+0.25*Kd) (5+0.25*Kp) ,0.25*Ki];
sys = tf(Num,Den);
figure
step(sys,5)
stepinfo(sys)
figure
impulse(sys)
figure
bode(sys)

Num = [0.25];
Den = conv([1 1],[1 5]);
sysMA = tf(Num,Den);
figure
step(sysMA,5)
hold on
step(sys,5)
hold off