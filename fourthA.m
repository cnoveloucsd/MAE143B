clear; clc;
syms s K

% q.1
D_lead = (s + 2.6795) / (s + 37.3205);

% q.2b Double Lag 
D_double_lag = ((s + 0.4852) / (s + 0.04852))^2;

% q.3b Inverse Chebyshev
num_cheb = 0.001*s^4 + 7668*s^2 + 7.35e09;
den_cheb = s^4 + 758.2*s^3 + 2.874e05*s^2 + 6.413e07*s + 7.35e09;
D_lpf = num_cheb / den_cheb;

% 4a. Total 
D_loop_shaping = K * D_lead * D_double_lag * D_lpf;


disp('D_loop_shaping(s) = ')
pretty(D_loop_shaping)