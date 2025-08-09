% IVP_RK2_midpoint: Computes the approximate solution of an ODE IVP at a
% final time 'tf' using the second-order Runge-Kutta (Midpoint) method.
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
function w_final = IVP_RK2_midpoint(f, t0, y0, h, tf)
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time
  y = y0; % Start with the initial value

  % --- Iteration using the RK2 Midpoint Method ---
  % Loop from the start time until the final time is reached.
  while t < tf
    % Apply the formulas provided for the Midpoint method:
    % 1. Calculate k1: The slope at the beginning of the interval.
    k1 = f(t, y);

    % 2. Calculate k2: The slope at the midpoint of the interval, estimated
    %    using the slope k1.
    k2 = f(t + h / 2, y + (h / 2) * k1);

    % 3. Update y: Use the midpoint slope k2 to take a full step.
    %    w_i+1 = w_i + h * k2
    y = y + h * k2;

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed value of y
  w_final = y;
end
