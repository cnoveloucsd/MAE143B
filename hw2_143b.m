% Figure 1: Actuator Saturation Problem with K=1
G = RR_pade(d, 2, 2) * RR_tf(1, [1/a0 1]);
D_bad = 1;
T_bad = RR_feedback(G * D_bad, 1);
Su_bad = RR_tf(35, 1) + RR_tf(10, 1) * RR_feedback(D_bad, G); % or the respective control effort transfer function from your script

g.T = 200;
figure(1);
RR_step(35 + 10 * p * D_bad / (1 + G * D_bad), g);
axis([0 200 40 60]);
title('Su(s) with K=1: Actuator Saturation');

% Figure 2: T(s) Proportional (F_2_2)
figure(2);
RR_step(35 + 10 * p * G * D_P / (1 + G * D_P), g);
axis([0 200 32 55]);
title('T(s) Proportional (F_{2,2})');

% Figure 3: Su(s) Proportional
figure(3);
RR_step(35 + 10 * p * D_P / (1 + G * D_P), g);
axis([0 200 40 60]);
title('Su(s) Proportional');

%%  Saturation Problem (K = 1)
D_bad = 1; P_bad = 2; 
figure(4); % plot Su(s) to show it demands > 50 deg
RR_step(35 + 10 * P_bad * D_bad / (1 + G_2 * D_bad), g);
axis([0 200 40 60]); title('Su(s) with K=1: Actuator Saturation');

%% 2. Proportional Control
K = 0.488; 
D_P = RR_tf(K); 
P_P = (1+K)/K; % prefactor to hit 45 deg steady state

% T(s) step response (F_2_2) - settling time ~99.2s
figure(5); hold on; grid on; axis([0 g.T 34 55]);
[t_P, ~, y_TP] = RR_plot_response(35 + 10 * P_P * G_2 * D_P / (1 + G_2 * D_P), 0, g);
yline(45, '--b'); title('T(s) Proportional (F_2_2)');

% Su(s) step response - max u(t) stays under 50 deg
figure(6); hold on; grid on; axis([0 200 40 60]);
[~, ~, y_UP] = RR_plot_response(35 + 10 * P_P * D_P / (1 + G_2 * D_P), 0, g);
yline(max(y_UP), '-r'); title('Su(s) Proportional');

% Validation with F_16_13
figure(7); hold on; grid on; axis([0 g.T 34 55]);
RR_plot_response(35 + 10 * P_P * G_16 * D_P / (1 + G_16 * D_P), 0, g);
yline(45, '--b'); title('T(s) Proportional (F_{16,13} Validation)');

%% 3. Lead Comp!
K_L = 0.47; z = 0.1; p = 0.05; P_L = 2.0639;
D_lead = RR_tf(K_L * [1 z], [1 p]);

% T(s) step response (F_2_2) - settling time ~72.6s
figure(8); hold on; grid on; axis([0 g.T 34 55]);
[t_L, ~, y_TL] = RR_plot_response(35 + 10 * P_L * G_2 * D_lead / (1 + G_2 * D_lead), 0, g);
yline(45, '--b'); title('T(s) Lead Compensator (F_2_2)');

% Su(s) step response - max u(t) barely under 50 deg limit
figure(9); hold on; grid on; axis([0 200 40 60]);
[~, ~, y_UL] = RR_plot_response(35 + 10 * P_L * D_lead / (1 + G_2 * D_lead), 0, g);
yline(max(y_UL), '-r'); title('Su(s) Lead Compensator');

% Validation with F_16_13
figure(10); hold on; grid on; axis([0 g.T 34 55]);
RR_plot_response(35 + 10 * P_L * G_16 * D_lead / (1 + G_16 * D_lead), 0, g);
yline(45, '--b'); title('T(s) Lead Compensator (F_{16,13} Validation)');]]]