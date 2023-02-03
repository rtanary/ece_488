%Project 2, using the found values from the last
g = 9.81; %Gravitational constant
P1 = tf(8,[1 0 -2*g]);
C1 = tf([1,sqrt(2*g)],1);
P2 = C1*P1;
C2 = pid(K_p, K_i, K_d);
L = C2*P2;

sys = L/(1+L);
%Closed loop plant
bode(L/(1+L));
bw = bandwidth(sys);

%Modified plant
P_mod = tf(200, [1, 25-sqrt(2*g) -25*sqrt(2*g)]);

P_mod = C2*P_mod;
[Gm, Pm, Wcg, Wcp] = margin(P_mod);
figure(1)
margin(P_mod/(1+P_mod));

%ii
Delta = -tf([1,200],[10 250]);
figure(2);
bode(Delta)

%iii
%M=CW/(1+PC)
W = tf([10 0], [1 200]);
M=C2*W/(1+P2*C2);
figure(3)
bode(M);