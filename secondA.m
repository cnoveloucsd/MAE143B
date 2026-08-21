% Objective function for phase reduction of 5 degrees at w = 10 rad/s
fun = @(p) atand(10/(100*p)) - atand(10/p) + 5;

p0 = 0.01;      % Initial guess

% Solve for pole p and zero z
p = fsolve(fun, p0);
z = 100 * p;

% Display calculated values
fprintf('z = %.6f\n', z);
fprintf('p = %.6f\n', p);

% Define transfer function
num = [1, z];
den = [1, p];
D_lag = tf(num, den);

% Plot Bode plot
figure;
bode(D_lag);
grid on;
title('Bode Plot of Lag Compensator D_{lag}(s)');