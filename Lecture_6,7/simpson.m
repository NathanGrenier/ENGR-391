% Closed 1/3 Newton-Cotes Formula

% Define the function simpson_integration which approximates the definite integral of a function f
% from a to b using Simpson's 1/3 rule.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%
% Returns:
%   The approximate value of the definite integral of f from a to b.
function approx = simpson(f, a, b)
    % Calculate the midpoint of the interval
    midpoint = (a + b) / 2;

    % Apply Simpson's 1/3 rule
    approx = (b - a) / 6 * (f(a) + 4 * f(midpoint) + f(b));
end

