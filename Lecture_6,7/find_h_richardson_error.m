% find_h_for_tolerance
%
% In the context of a university course on numerical methods, this script
% finds the minimum step size 'h' required to achieve a desired error
% tolerance for a definite integral using two different quadrature methods.
%
% The error is estimated using Richardson's extrapolation formula.
%
% Parameters:
%   f: A function handle to the function to be integrated.
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%   tolerance: The desired maximum error for the approximation.
%
% Returns:
%   h_trapezoid: The maximum step size 'h' that meets the tolerance for the
%                Composite Trapezoid Rule.
%   h_simpson: The maximum step size 'h' that meets the tolerance for the
%              Composite Simpson's 1/3 Rule.
function [h_trapezoid, h_simpson] = find_h_richardson_error(f, a, b, tolerance)

    % Input validation
    if tolerance <= 0
        error('Tolerance must be a positive number.');
    end

    fprintf('Finding required step size h for tolerance = %e\n', tolerance);

    % --- Find h for Composite Trapezoid Rule (q=2) ---
    fprintf('... Calculating for Trapezoid Rule (q=2)\n');
    m = 2; % Start with 2 intervals
    error_est = inf; % Initialize error to infinity

    while error_est > tolerance
        m1 = m;
        m2 = 2 * m;

        I1 = composite_trapezoid(f, a, b, m1);
        I2 = composite_trapezoid(f, a, b, m2);

        % Richardson Error Estimate for q=2
        error_est = abs(I2 - I1) / (2^2 - 1);

        % If error is still too high, double the intervals for the next iteration
        if error_est > tolerance
            m = m2;
        end

        % Safety break for extremely small tolerances
        if m > 1e8
            warning('Exceeded maximum iterations for Trapezoid Rule. Tolerance may be too small.');
            break;
        end
    end
    h_trapezoid = (b - a) / m2;
    fprintf('    Trapezoid h=%e (m=%d intervals)\n', h_trapezoid, m2);

    % --- Find h for Composite Simpson's 1/3 Rule (q=4) ---
    fprintf('... Calculating for Simpson''s Rule (q=4)\n');
    m = 2; % Start with 2 intervals (must be even)
    error_est = inf;

    while error_est > tolerance
        m1 = m;
        m2 = 2 * m;

        I1 = composite_simpson(f, a, b, m1);
        I2 = composite_simpson(f, a, b, m2);

        % Richardson Error Estimate for q=4
        error_est = abs(I2 - I1) / (2^4 - 1);

        if error_est > tolerance
            m = m2;
        end

        if m > 1e8
             warning('Exceeded maximum iterations for Simpson''s Rule. Tolerance may be too small.');
            break;
        end
    end
    h_simpson = (b - a) / m2;
    fprintf('    Simpson h=%e (m=%d intervals)\n', h_simpson, m2);

end

% --- MEMORY-EFFICIENT Helper Functions for Quadrature Rules ---

function approx = composite_trapezoid(f, a, b, m)
    h = (b - a) / m;
    sum_f = 0;
    for i = 1:(m-1)
        sum_f = sum_f + f(a + i * h);
    end
    approx = h * ((f(a) + f(b)) / 2 + sum_f);
end

function approx = composite_simpson(f, a, b, m)
    if mod(m, 2) ~= 0
        error('Number of subintervals m must be even for Simpson''s rule.');
    end
    h = (b - a) / m;
    sum_odd = 0;
    for i = 1:2:(m-1)
        sum_odd = sum_odd + f(a + i * h);
    end
    sum_even = 0;
    for i = 2:2:(m-2)
        sum_even = sum_even + f(a + i * h);
    end
    approx = (h / 3) * (f(a) + 4*sum_odd + 2*sum_even + f(b));
end
