## BROKEN, GIVES VALUES VERY CLOSE TO ACTUAL ANSWER

% IVP_euler_system: Computes the approximate solution of a system of ODE IVPs
% at a final time 'tf' using Euler's method.
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
function w_final = IVP_euler_system(f, t0, y0_vec, h, tf)
  % --- Input Validation ---
  % Check if the interval [t0, tf] is a multiple of the step size h.
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time
  % Ensure y is a column vector for consistent vector operations
  y = y0_vec(:);

  % --- Iteration using Euler's Method ---
  % Loop from the start time until the final time is reached.
  while abs(t - tf) > 10 * eps % Use tolerance for float comparison
    % Euler's method formula for a system:
    % y_next = y_current + h * f(t_current, y_current)
    % Here, y and f(t, y) are vectors.
    y = y + (h * f(t, y));

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed vector y
  w_final = y;
end
