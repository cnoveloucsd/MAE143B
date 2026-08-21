clear; clc; close all;

% Setup
wg = 10;
s = tf('s');
G = 100 / (s^2 - 100);

% 5a: Simple Compensator
D_simple = (s + 10) / (s + 20.34);

% 4a: Unscaled Loop Shaping Compensator
D_lead = (s + 2.6795) / (s + 37.3205);
D_double_lag = ((s + 0.4852) / (s + 0.04852))^2;
num_lpf = 0.001*s^4 + 7668*s^2 + 7.35e09;
den_lpf = s^4 + 758.2*s^3 + 2.874e05*s^2 + 6.413e07*s + 7.35e09;
D_lpf = num_lpf / den_lpf;

D_unscaled = D_lead * D_double_lag * D_lpf;

% Tune K
L_unscaled = G * D_unscaled;
[mag, ~] = bode(L_unscaled, wg);
K = 1 / mag;

fprintf('Tuned Gain K = %.4f\n\n', K);

% Final Open Loops
D_loop_shaping = K * D_unscaled;
L_simple = G * D_simple;
L_loop_shaping = G * D_loop_shaping;

% 1. Bode Plots
figure;
bode(L_simple, 'b--', L_loop_shaping, 'r-');
grid on;
legend('G * D_{simple}', 'G * D_{loop-shaping}');
title('Open-Loop Bode Plots');

% 2. Root Locus 
figure;
subplot(1,2,1); rlocus(L_simple); title('Root Locus: Simple');
subplot(1,2,2); rlocus(L_loop_shaping); title('Root Locus: Loop Shaping');

% 3. Closed-Loop Step Responses
T_simple = feedback(L_simple, 1);
T_loop_shaping = feedback(L_loop_shaping, 1);

figure;
step(T_simple, 'b--', T_loop_shaping, 'r-', 2); % simulated for 2 seconds
grid on;
legend('Simple', 'Loop Shaping');
title('Closed-Loop Step Response');