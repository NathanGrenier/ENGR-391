% Inputs:
%   f        - function handle for f(x) such that f(x) = 0
%   x0       - initial guess for the root
%   tol      - tolerance for convergence
%   max_iter - maximum number of iterations allowed
% Outputs:
%   root     - approximate root of the equation
%   iter     - number of iterations performed
%   approximations - vector of approximations at each iteration
function [root, iter, approximations] = newton(f, x0, tol, max_iter)
    % Set default maximum iterations if not provided
    if nargin < 4 || isempty(max_iter)
        max_iter = 1000;
    end

    % Initialize variables
    x = x0;
    eps = 2.22e-16;  % Machine epsilon in Octave
    approximations = x0;  % Start with initial guess
    converged = false;

    % Perform Newton’s method iterations
    for iter = 1:max_iter
        % Compute step size h for derivative approximation
        h = (eps)^(1/3) * max(abs(x), 1);

        % Compute approximate derivative using central difference
        f_values = [f(x - h), f(x + h)];
        df_approx = diff(f_values) / (2 * h);  % Returns [f(x + h) - f(x - h)] / (2*h)
        df_approx = df_approx(1);              % Extract scalar value

        % Check for zero derivative
        if df_approx == 0
            error('Approximate derivative is zero. Newton method fails.');
        end

        % Newton iteration
        x_new = x - f(x) / df_approx;

        % Check if the new approximation is finite
        if ~isfinite(x_new)
            disp('Approximation became non-finite. Stopping iterations.');
            break;
        end

        approximations = [approximations; x_new];

        % Check convergence
        if abs(x_new - x) < tol
            converged = true;
            break;
        end

        x = x_new;
    end

    % Set root to the last approximation
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
    title('Convergence of Newton''s Method');
    grid on;
end
