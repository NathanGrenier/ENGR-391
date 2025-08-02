% Define the function romberg_integration which estimates the definite integral
% of a function f from a to b using the Romberg method.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%   n: The number of Romberg iterations, which determines the size of the
%      n x n table of approximations.
%
% Returns:
%   integral_approximation: The most accurate estimate from the Romberg table,
%                           typically the last element on the diagonal.
%   R: The full n x n Romberg table for inspection.
function [approx, R] = romberg(f, a, b, n)

    % Initialize an n x n matrix to store the Romberg table.
    R = zeros(n, n);

    % --- Step 1: Calculate the first column of the table (R_i,1) ---
    % These are the initial estimates using the composite trapezoid rule.
    % The number of subintervals doubles with each row (1, 2, 4, 8, ...).

    h = b - a; % Initial step size (for 1 interval)
    R(1, 1) = (h / 2) * (f(a) + f(b)); % Trapezoid rule with 1 interval

    for i = 2:n
        % For each new row, we improve the trapezoid estimate by doubling the
        % number of points and adding the new function evaluations.

        sum_f = 0;
        num_points = 2^(i - 2); % Number of new points to add
        for k = 1:num_points
            sum_f = sum_f + f(a + (k - 0.5) * h);
        end

        % This is a more efficient way to calculate the next trapezoid estimate
        % by reusing the previous one: R(i,1) = 0.5 * R(i-1,1) + h/2 * sum_f
        R(i, 1) = 0.5 * R(i-1, 1) + (h / 2) * sum_f;

        % Halve the step size for the next iteration.
        h = h / 2;
    end

    % --- Step 2: Apply Richardson extrapolation to fill the rest of the table ---
    % This part implements the formula from your screenshot in its general form.
    % The formula R(h) = (4*I(h) - I(2h)) / 3 is the first extrapolation (j=2).

    for j = 2:n
        % The power of 4 in the formula increases with each column.
        power_of_4 = 4^(j - 1);
        for i = j:n
            % R(i, j-1) is the more accurate estimate (smaller step size, I(h))
            % R(i-1, j-1) is the less accurate estimate (larger step size, I(2h))
            R(i, j) = (power_of_4 * R(i, j-1) - R(i-1, j-1)) / (power_of_4 - 1);
        end
    end

    % The most accurate estimate is the last one computed, R(n,n).
    approx = R(n, n);
end
