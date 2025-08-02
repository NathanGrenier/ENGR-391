% gauss_quadrature
%
% In the context of a university course on numerical methods, this script
% estimates the value of a definite integral using the Gauss-Legendre quadrature rule.
%
% The function works by first applying a change of variables to transform the
% original integration interval [a, b] to the canonical interval [-1, 1], as
% specified by the provided formula. It then uses pre-computed weights and
% points (abscissas) to calculate the integral as a weighted sum.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%   n: The number of points (and weights) to use for the quadrature.
%      (Typically an integer from 1 to 6 for standard tables).
%
% Returns:
%   integral_approximation: The estimated value of the definite integral.
function approx = gauss(f, a, b, n)

    % --- Step 1: Get the pre-computed Gauss-Legendre weights and points ---
    [points_t, weights_w] = get_gauss_legendre_params(n);

    % --- Step 2: Apply the change of variables ---
    % The formula provided transforms the integral from [a, b] to [-1, 1]:
    % Integral from a to b of f(x)dx =
    %   Integral from -1 to 1 of f(((b-a)t + b+a)/2) * ((b-a)/2) dt

    % The scaling factor for the integral result:
    scaling_factor = (b - a) / 2;

    % The transformation for the variable t to the original space x:
    % x = ((b-a)t + b+a) / 2
    % We will apply this transformation to each of the Gauss points.

    % --- Step 3: Calculate the weighted sum ---
    % The integral is approximated by the sum:
    %   scaling_factor * sum(w_i * f(x_i))
    % where x_i are the transformed points.

    sum_total = 0;
    for i = 1:n
        % Transform the Gauss point t_i from [-1, 1] to the corresponding point x_i in [a, b]
        point_x = scaling_factor * points_t(i) + (b + a) / 2;

        % Add the weighted function evaluation to the total sum
        sum_total = sum_total + weights_w(i) * f(point_x);
    end

    % The final approximation is the scaled sum.
    approx = scaling_factor * sum_total;

end

% --- Helper function to provide Gauss-Legendre parameters ---
function [points, weights] = get_gauss_legendre_params(n)
    % This function returns the pre-computed points (abscissas) and weights
    % for Gauss-Legendre quadrature for a given number of points n.

    switch n
        case 1
            points  = [0];
            weights = [2];
        case 2
            points  = [-0.5773502692, 0.5773502692];
            weights = [1.0, 1.0];
        case 3
            points  = [-0.7745966692, 0, 0.7745966692];
            weights = [0.5555555556, 0.8888888889, 0.5555555556];
        case 4
            points  = [-0.8611363116, -0.3399810436, 0.3399810436, 0.8611363116];
            weights = [0.3478548451, 0.6521451549, 0.6521451549, 0.3478548451];
        case 5
            points  = [-0.9061798459, -0.5384693101, 0, 0.5384693101, 0.9061798459];
            weights = [0.2369268850, 0.4786286705, 0.5688888889, 0.4786286705, 0.2369268850];
        case 6
            points  = [-0.9324695142, -0.6612093865, -0.2386191861, 0.2386191861, 0.6612093865, 0.9324695142];
            weights = [0.1713244924, 0.3607615730, 0.4679139346, 0.4679139346, 0.3607615730, 0.1713244924];
        otherwise
            error('Number of points n must be between 1 and 6. For n > 6, coefficients must be added to the script.');
    end
end
