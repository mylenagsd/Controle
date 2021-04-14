clc
close all
clear
%Mylena - 28/09/20

A = [1  -0.49  -0.495];
B = [0 0.008856 0.004428];
sys0 = idpoly(A,B);

u = iddata([],idinput(300,'rbs'));
e = iddata([],randn(300,1));
y = sim(sys0,[u e]);

z = [y,u];
sys1 = arx(z,[2 2 1]);
t = 1:100;
figure
subplot(2,1,1)
step(sys1,10)
grid
subplot(2,1,2)
impulse(sys1,10)
grid

