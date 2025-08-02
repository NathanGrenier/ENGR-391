% Define the function composite_simpson_integration which approximates the
% definite integral of a function f from a to b using the composite Simpson's method.
% This implementation directly follows the provided formula.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%   m: The number of applications of Simpson's rule. The total interval [a,b]
%      is divided into n = 2*m smaller intervals of equal width.
%
% Returns:
%   The approximate value of the definite integral of f from a to b.
function approx = composite_simpson(f, a, b, m)
    % The formula provided is:
    % I ≈ (h/3) * (f(a) + f(b) + 4 * Σ[i=1 to m] f(x_{2i-1}) + 2 * Σ[i=1 to m-1] f(x_{2i}))

    % The total number of small intervals is n = 2*m.
    % The width 'h' of each small interval is calculated as:
    h = (b - a) / (2 * m);

    % First summation term (multiplied by 4)
    % This corresponds to Σ f(x_{2i-1}) for i from 1 to m.
    % These are the function evaluations at the odd-indexed points: x_1, x_3, ..., x_{2m-1}.
    sum_odd = 0;
    for i = 1:m
        x_odd = a + (2 * i - 1) * h;
        sum_odd = sum_odd + f(x_odd);
    end

    % Second summation term (multiplied by 2)
    % This corresponds to Σ f(x_{2i}) for i from 1 to m-1.
    % These are the function evaluations at the interior even-indexed points: x_2, x_4, ..., x_{2m-2}.
    sum_even = 0;
    for i = 1:(m - 1)
        x_even = a + (2 * i) * h;
        sum_even = sum_even + f(x_even);
    end

    % Combine all the parts according to the formula
    approx = (h / 3) * (f(a) + f(b) + 4 * sum_odd + 2 * sum_even);
end
