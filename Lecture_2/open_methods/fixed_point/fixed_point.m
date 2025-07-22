% Function to find the root of a nonlinear function using the fixed-point method
% and plot the approximated root's value at each iteration, stopping early if
% approximations become non-finite.
%
% Inputs:
%   g        - function handle for g(x) such that x = g(x) at the root
%   x0       - initial guess for the root
%   tol      - tolerance for convergence
%   max_iter - maximum number of iterations allowed
%
% Outputs:
%   root     - approximate root of the equation
%   iter     - number of iterations performed
%   approximations - vector of approximations at each iteration
%
% Example usage:
%   Find the fixed point of g(x) = cos(x)
%   g = @(x) cos(x);
%   [root, iter, approximations] = fixed_point(g, 0.5, 1e-6, 100);
function [root, iter, approximations] = fixed_point(g, x0, tol, max_iter)
    % Set default maximum iterations if not provided
    if nargin < 4 || isempty(max_iter)
        max_iter = 1000;
    end

    % Initialize variables
    iter = 0;
    x = x0;
    approximations = x0;  % Start with initial guess
    converged = false;

    % Perform fixed-point iterations
    while iter < max_iter
        iter = iter + 1;
        x_new = g(x);

        % Check if the new approximation is finite
        if ~isfinite(x_new)
            disp('Approximation became non-finite. Stopping iterations.');
            break;
        end

        % Store the finite approximation
        approximations = [approximations; x_new];

        % Check for convergence
        if abs(x_new - x) < tol
            converged = true;
            break;
        end
        x = x_new;
    end

    % Set the root to the last approximation
    root = approximations(end);

    % Warn if maximum iterations reached without convergence
    if ~converged && iter == max_iter
        disp('Maximum number of iterations reached. May not have converged.');
    end

    % Plot the approximations within the plotter's capacity
    threshold = realmax('single');  % Max single-precision float value (~3.4e38)
    exceed_idx = find(abs(approximations) > threshold, 1, 'first');
    if ~isempty(exceed_idx)
        plot_range = 1:exceed_idx-1;
        disp('Some approximations are too large to plot and have been excluded.');
    else
        plot_range = 1:length(approximations);
    end

    plot(0:length(plot_range)-1, approximations(plot_range), '-o');
    xlabel('Iteration');
    ylabel('Approximation (x_r)');
    title('Convergence of Fixed-Point Method');
    grid on;
end
