% Define the function composite_trapezoid_integration which approximates the
% definite integral of a function f from a to b using the composite trapezoid method.
% This implementation directly follows the provided formula.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%   m: The number of subdivisions (subintervals).
%
% Returns:
%   The approximate value of the definite integral of f from a to b.
function approx = composite_trapezoid(f, a, b, m)
    % The formula provided is:
    % I ≈ (h/2) * (f(a) + f(b) + 2 * Σ[i=1 to m-1] f(x_i))

    % Calculate the width 'h' of each subinterval.
    h = (b - a) / m;

    % Calculate the sum of the function values at the interior points.
    % This corresponds to the term Σ f(x_i) for i from 1 to m-1.
    interior_sum = 0;
    for i = 1:(m - 1)
        x_i = a + i * h;
        interior_sum = interior_sum + f(x_i);
    end

    % Combine all the parts according to the formula.
    approx = (h / 2) * (f(a) + f(b) + 2 * interior_sum);
end

