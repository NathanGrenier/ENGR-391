% IVP_RK2_trapezoid_system: Computes the approximate solution of a system of
% ODE IVPs at a final time 'tf' using the second-order Runge-Kutta
% (Trapezoid) method.
%
% Parameters:
%   f       (function_handle): The system of ODEs, f(t, y), where y is a vector.
%   t0      (scalar): The initial time of the IVP.
%   y0_vec  (vector): The vector of initial values y(t0) of the IVP.
%   h       (scalar): The step size.
%   tf      (scalar): The final time at which to approximate the solution y(tf).
%
% Returns:
%   w_final (vector): The approximate value of the solution vector at time tf.
function w_final = IVP_RK2_trapezoid_system(f, t0, y0_vec, h, tf)
  % Ensure the interval is divisible by the step size.
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time
  % Ensure y is a column vector for consistent vector operations
  y = y0_vec(:);

  % --- Iteration using the RK2 Trapezoid Method ---
  % Loop from the start time until the final time is reached.
  while abs(t - tf) > 10 * eps
    % Apply the formulas for the Trapezoid method to the system.
    % All operations on y, k1, and k2 are now vector operations.

    % 1. Calculate k1: The vector of slopes at the beginning of the interval.
    k1 = f(t, y);

    % 2. Calculate k2: The vector of slopes at the end of the interval,
    %    estimated using a preliminary Euler step for the entire system.
    k2 = f(t + h, y + k1 * h);

    % 3. Update y: Combine the slope vectors to take a step.
    %    This is equivalent to averaging the slope vectors k1 and k2.
    %    w_i+1 = w_i + h * (1/2 * k1 + 1/2 * k2)
    y = y + (h / 2) * (k1 + k2);

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed vector y
  w_final = y;
end

## % 1. Define the system of ODEs as a function handle.
## % The function must accept a scalar 't' and a vector 'y'.
## % y(1) corresponds to y1, and y(2) corresponds to y2.
## ode_system = @(t, y) [y(2); -y(1)];
##
## % 2. Set the initial conditions and parameters.
## t0 = 0;                  % Initial time
## y0_vec = [1; 0];         % Initial values [y1(0); y2(0)]
## h = 0.1;                 % Step size
## tf = pi;                 % Final time to approximate the solution
##
## % 3. Call the solver.
## w_final = IVP_RK2_trapezoid_system(ode_system, t0, y0_vec, h, tf);
