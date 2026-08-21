% Explicit multiplication operator added: 2 * atand(...)
fun = @(p) 2 * atand(1/p) - 2 * atand(10/p) + 5;

p0 = 0.01;      % Initial guess
p = fsolve(fun, p0)
z = 10 * p

% Method 1: Square the single transfer function directly
D_single = tf([1, z], [1, p]);
D_double_lag = D_single^2

% Method 2: Expand polynomial coefficients using conv()
num_double = conv([1, z], [1, z]); % [1, 2*z, z^2]
den_double = conv([1, p], [1, p]); % [1, 2*p, p^2]
D_double_lag_alt = tf(num_double, den_double)