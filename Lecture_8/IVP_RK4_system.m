% IVP_RK4_system: Computes the approximate solution of a system of ODE IVPs
% at a final time 'tf' using the classical fourth-order Runge-Kutta method.
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
function w_final = IVP_RK4_system(f, t0, y0_vec, h, tf)
  % --- Input Validation ---
  % Check if the interval [t0, tf] is a multiple of the step size h.
  if mod(tf - t0, h) > 10 * eps
    error('The interval from t0 to tf must be divisible by the step size h.');
  end

  % --- Initialization ---
  t = t0; % Start at the initial time
  % Ensure y is a column vector for consistent vector operations
  y = y0_vec(:);

  % --- Iteration using the Classical RK4 Method ---
  % Loop from the start time until the final time is reached.
  while abs(t - tf) > 10 * eps % Use tolerance for float comparison
    % Apply the RK4 formulas to the system. All operations on y and the
    % k-values are now vector operations.

    % 1. Calculate k1: The vector of slopes at the beginning of the interval.
    k1 = f(t, y);

    % 2. Calculate k2: The first midpoint slope vector.
    k2 = f(t + h / 2, y + (h / 2) * k1);

    % 3. Calculate k3: The second midpoint slope vector.
    k3 = f(t + h / 2, y + (h / 2) * k2);

    % 4. Calculate k4: The slope vector at the end of the interval.
    k4 = f(t + h, y + h * k3);

    % 5. Update y: Combine the slope vectors using a weighted average.
    %    w_i+1 = w_i + (h/6) * (k1 + 2*k2 + 2*k3 + k4)
    y = y + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

    % Increment the time by the step size
    t = t + h;
  end

  % Return the final computed vector y
  w_final = y;
end
