clc
close all
clear

p1 = -3+4*j;
p2 = -3-4*j;
p3 = -20;
%(s-p1)(s-p2)
x = conv([1 -p1],[1 -p2])
%(s-p1)(s-p2)*(s-p3)
Den = conv(x,[1 -p3]);
Num = 25;
sys1 = tf(Num,Den);

figure 
rlocus(sys1);

%%
p3 = -5;
%(s-p1)(s-p2)
x = conv([1 -p1],[1 -p2])
%(s-p1)(s-p2)*(s-p3)
Den = conv(x,[1 -p3]);
Num = 25;
sys2 = tf(Num,Den);

figure
step(sys1);
hold
step(sys2);
hold off

