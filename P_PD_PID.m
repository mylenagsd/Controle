clc
close all
clear

%MA original
Num = [0.0274];
Den = [8.8781*10^-12 1.2914*10^-5 7.6479*10^-4 0];
sysMA = tf(Num,Den);
%figure
%step(sysMA);
%title('Degrau MA original');
%figure
%impulse(sysMA);
%title('Impulso MA original');
%figure
%bode(sysMA);
%title('Bode MA original');
%figure
%rlocus(sysMA);
%title('LGR MA original');

%MA reduzida
Num = [2122];
Den = [1 59.226 0];
sysMA = tf(Num,Den);
%figure
%step(sysMA);
%title('Degrau MA reduzida');
%figure
%rlocus(sysMA);
%title('LGR MA reduzida');

Kp = 5;
Kd = 0.05;
Ki = 100;
%MA reduzida
Num = Kp*[2122];
Den = [1 59.226 0];
sysMA = tf(Num,Den);
figure
rlocus(sysMA);
title('LGR MA com P');

%MA reduzida
Num = conv([Kd Kp],[2122]);
Den = [1 59.226 0];
sysMA = tf(Num,Den);
figure
rlocus(sysMA);
title('LGR MA com PD');

%MA reduzida
Num = conv([Kd Kp Ki],[2122]);
Den = [1 59.226 0];
sysMA = tf(Num,Den);
figure
rlocus(sysMA);
title('LGR MA com PID');