% Inputs:
%   f        - function handle for f(x) whose root is to be found
%   x0       - initial guess for the root
%   tol      - tolerance for convergence
%   max_iter - maximum number of iterations allowed
% Outputs:
%   root     - approximate root of the equation
%   iter     - number of iterations performed
function [root, iter] = newton(f, x0, tol, max_iter)
    % Set default maximum iterations if not provided
    if nargin < 4 || isempty(max_iter)
        max_iter = 1000;
    end

    x = x0;
    iter = 0;
    eps = 2.22e-16;  % Machine epsilon in Octave

    while iter < max_iter
        % Compute step size h
        h = (eps)^(1/3) * max(abs(x), 1);

        % Compute approximate derivative using diff()
        f_values = [f(x - h), f(x + h)];
        df_approx = diff(f_values) / (2 * h);  % Returns [f(x + h) - f(x - h)] / (2*h)
        df_approx = df_approx(1);              % Extract scalar value

        % Check for zero derivative
        if df_approx == 0
            error('Approximate derivative is zero. Newton method fails.');
        end

        % Newton iteration
        x_new = x - f(x) / df_approx;
        iter = iter + 1;

                disp(iter);
        disp(x_new);
        printf("\n");

        % Check convergence
        if abs(x_new - x) < tol
            root = x_new;
            return;
        end

        x = x_new;
    end

    % Warn if maximum iterations reached
    warning('Maximum number of iterations reached. May not have converged.');
    root = x;
end
