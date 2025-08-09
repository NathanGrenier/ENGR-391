% solveEuler: Computes the approximate solution of an ODE IVP at a final
% time 'tf' using Euler's method.
%
% Parameters:
%   f    (function_handle): The ODE function f(t, y).
%   t0   (scalar): The initial time of the IVP.
%   y0   (scalar): The initial value y(t0) of the IVP.
%   h    (scalar): The step size.
%   tf   (scalar): The final time at which to approximate the solution y(tf).
%
% Returns:
%   y_final (scalar): The approximate value of the solution at time tf.
%
function w_final = IVP_euler(f, t0, y0, h, tf)

  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0;
  y = y0;

  % --- Iteration using Euler's Method ---
  % Loop from the start time until the final time is reached.
  while t < tf
    % Euler's method formula: y_next = y_current + h * f(t_current, y_current)
    y = y + h * f(t, y);

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed value of y
  w_final = y;
end
