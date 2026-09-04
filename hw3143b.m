clear; close all;
d = 0.1; a = 1;

% q3 & q4: 2,2 pade
G1 = RR_pade(d, 2, 2) * RR_tf(1, [1 a]);
L1 = G1 * 1;
figure(1);
RR_rlocus(L1);

omega1 = 16.456;
K_crit1 = real(RR_evaluate(-1/L1, i*omega1))

% q5: 16,12 pade
G2 = RR_pade(d, 16, 12) * RR_tf(1, [1 a]);
L2 = G2 * 1;
figure(2);
RR_rlocus(L2);

omega2 = 16.32;
K_crit2 = real(RR_evaluate(-1/L2, i*omega2))

% q6: nyquist plots
figure(3);
RR_nyquist(G1 * (K_crit1 / 2));

figure(4);
RR_nyquist(G1 * (K_crit1 * 2));