%Plant
g = 9.81; %Gravitational constant
P1 = tf(8,[1 0 -2*g]);
%Plant = tf(1,[1 1 0.75]);
%Plant inherently has a root on the left side of the plane, use zero to
%stabilize controller

%Cancel OHLP 
C1 = tf([1,sqrt(2*g)],1);
%Augmented plant
P2 = C1*P1;
%PID Controller
K_d = 0;
K_p = 12;
K_i = 10;  
C2 = pid(K_p, K_i, K_d);

P3 = C2*P2;
[Gm, Pm, Wcg, Wcp] = margin(P3);
figure(1)
rlocus(P3)
figure(2)
bode(P3);
figure(3)
margin(P3);