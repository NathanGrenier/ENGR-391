% IVP_RK2_trapezoid: Computes the approximate solution of an ODE IVP at a
% final time 'tf' using the second-order Runge-Kutta (Trapezoid) method.
%
% Parameters:
%   f    (function_handle): The ODE function f(t, y).
%   t0   (scalar): The initial time of the IVP.
%   y0   (scalar): The initial value y(t0) of the IVP.
%   h    (scalar): The step size.
%   tf   (scalar): The final time at which to approximate the solution y(tf).
%
% Returns:
%   w_final (scalar): The approximate value of the solution at time tf.
%
function w_final = IVP_RK2_trapezoid(f, t0, y0, h, tf)
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time
  y = y0; % Start with the initial value

  % --- Iteration using the RK2 Trapezoid Method ---
  % Loop from the start time until the final time is reached.
  while t < tf
    % Apply the formulas provided for the Trapezoid method:
    % 1. Calculate k1: The slope at the beginning of the interval.
    k1 = f(t, y);

    % 2. Calculate k2: The slope at the end of the interval, estimated
    %    using a preliminary Euler step.
    k2 = f(t + h, y + k1 * h);

    % 3. Update y: Combine the slopes to take a step. This is equivalent to
    %    averaging the slopes k1 and k2.
    %    w_i+1 = w_i + h * (1/2 * k1 + 1/2 * k2)
    y = y + (h / 2) * (k1 + k2);

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed value of y
  w_final = y;
end
