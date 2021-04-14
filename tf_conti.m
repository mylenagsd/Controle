clc
close all
clear
%mylena 09/09/20

A = 1;
tao = 1;
num = [A];
den = [tao 1];
sys = tf(num, den);

figure
step(sys)
grid

figure
bode(sys)
grid