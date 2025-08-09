% IVP_RK4: Computes the approximate solution of an ODE IVP at a final
% time 'tf' using the classical fourth-order Runge-Kutta method.
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
function w_final = IVP_RK4(f, t0, y0, h, tf)
  % --- Input Validation ---
  % Check if the interval [t0, tf] is a multiple of the step size h.
  % A small tolerance (eps) is used to handle floating-point inaccuracies.
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time
  y = y0; % Start with the initial value

  % --- Iteration using the Classical RK4 Method ---
  % Loop from the start time until the final time is reached.
  while abs(t - tf) > 10 * eps % Use tolerance for float comparison
    % Apply the formulas for the classical RK4 method:
    % 1. Calculate k1: The slope at the beginning of the interval.
    k1 = f(t, y);

    % 2. Calculate k2: The first midpoint slope.
    k2 = f(t + h / 2, y + (h / 2) * k1);

    % 3. Calculate k3: The second midpoint slope.
    k3 = f(t + h / 2, y + (h / 2) * k2);

    % 4. Calculate k4: The slope at the end of the interval.
    k4 = f(t + h, y + h * k3);

    % 5. Update y: Combine the slopes using a weighted average.
    %    w_i+1 = w_i + (h/6) * (k1 + 2*k2 + 2*k3 + k4)
    y = y + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed value of y
  w_final = y;
end
