% IVP_RK2_midpoint_system: Computes the approximate solution of a system of
% ODE IVPs at a final time 'tf' using the second-order Runge-Kutta
% (Midpoint) method.
%
% Parameters:
%   f    (function_handle): The system of ODEs, a function f(t, y) that
%                           takes a scalar time 't' and a column vector 'y'
%                           and returns a column vector of the derivatives.
%   t0   (scalar): The initial time of the IVP.
%   y0   (vector): The vector of initial values y(t0) for the system.
%   h    (scalar): The step size.
%   tf   (scalar): The final time at which to approximate the solution y(tf).
%
% Returns:
%   w_final (vector): The vector of approximate values of the solution at time tf.
function w_final = IVP_RK2_midpoint_system(f, t0, y0, h, tf)
  % Ensure the interval is divisible by the step size
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time

  % Ensure y is a column vector for consistency
  y = y0(:);

  % --- Iteration using the RK2 Midpoint Method for a system ---
  % Loop from the start time until the final time is reached.
  while t < tf
    % Apply the RK2 Midpoint method formulas to the vector y.
    % MATLAB's vector operations handle the element-wise calculations.

    % 1. Calculate k1: A vector of slopes at the beginning of the interval.
    k1 = f(t, y);

    % 2. Calculate k2: A vector of slopes at the midpoint of the interval,
    %    estimated using the slopes in k1.
    k2 = f(t + h / 2, y + (h / 2) * k1);

    % 3. Update y: Use the midpoint slopes in k2 to take a full step.
    %    This performs the update w_i+1 = w_i + h * k2 for each element.
    y = y + h * k2;

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed vector of approximations
  w_final = y;
end
