% Specifications
wg = 10;           %  (rad/s)
target_phase = -5; % (degrees)

% wg = 10 rad/s
fun = @(wc) -atand((0.76537*(wg/wc)) / (1 - (wg/wc)^2)) ...
            - atand((1.84776*(wg/wc)) / (1 - (wg/wc)^2)) - target_phase;

% Initial guess 
wc0 = 300; 

% cutoff frequency wc
wc = fsolve(fun, wc0);

fprintf('Calculated Cutoff Frequency (wc): %.4f rad/s\n', wc);

% Polynomial coefficients for denominator: B4(s/wc)
den = [1, 2.61313*wc, 3.41421*wc^2, 2.61313*wc^3, wc^4];
num = [wc^4];

D_LPF4_Butterworth = tf(num, den);

disp('Transfer Function D_LPF4_Butterworth(s):');
D_LPF4_Butterworth

% Bode Plot
figure;
bode(D_LPF4_Butterworth);
grid on;
title('Bode Plot of 4th-Order Butterworth LPF');