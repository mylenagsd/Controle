clear all;
close all;
clc;

t=0:0.01:10;

x1=sin(2*pi*t);
subplot(4,1,1);
plot(x1);
xlabel('time');
ylabel('amplitude');
title('first signal');

x2=sin(t);
subplot(4,1,2);
plot(x2);
xlabel('time');
ylabel('amplitude');
title('second signal');

x3=x1+x2;
subplot(4,1,3);
plot(x3);
xlabel('time');
ylabel('amplitude');
title('added signal');

x4=x1.*x2;
subplot(4,1,4);
plot(x4);
xlabel('time');
ylabel('amplitude');
title('multiplied signal');