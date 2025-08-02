% Closed 2 Point Newton-Cotes Formula

% Definte the function trapezoid_integration which approximates the definite integral of a function f
% from a to b using the trapezoid method.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%
% Returns:
%   The approximate value of the definite integral of f from a to b.
function approx = trapezoid(f, a, b)
    approx = (b - a) * (f(a) + f(b)) / 2;
end

