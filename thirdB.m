clear; clc;

% Specs
wg = 10;           
target_phase = -5; 
Rs = -20 * log10(0.001); % 60 dB attenuation
n = 4;                   

% Solve for stopband edge frequency (ws)
fun = @(ws) get_phase(ws, n, Rs, wg) - target_phase;
ws = fsolve(fun, 300, optimset('Display', 'off'));

fprintf('Calculated ws = %.4f rad/s\n\n', ws);

% Generate Inverse Chebyshev TF
[num_cheb, den_cheb] = cheby2(n, Rs, ws, 's');
D_LPF4_Inv_Cheb = tf(num_cheb, den_cheb)

% Recreate Butterworth (3a) for overlay
[num_butt, den_butt] = butter(n, 299.53, 's');
D_LPF4_Butterworth = tf(num_butt, den_butt);

% Bode Plot
figure;
bode(D_LPF4_Butterworth, 'b--', D_LPF4_Inv_Cheb, 'r-');
grid on;
legend('Butterworth (3a)', 'Inv Chebyshev (3b)');

% Helper function to calculate phase in degrees
function p = get_phase(ws, n, Rs, wg)
    [b, a] = cheby2(n, Rs, ws, 's');
    p = angle(polyval(b, 1i*wg) / polyval(a, 1i*wg)) * (180/pi);
end