% False Position Method for finding roots
% Inputs:
%   f       - function handle of the function for which the root is to be found.
%%              Example: f = @(x) 8 - 4.5 * (x - sin(x));
%   a, b    - initial interval endpoints with f(a)*f(b) < 0
%   tol     - tolerance for the interval size (default: 1e-6)
%   maxiter - maximum number of iterations (default: 1000)
% Outputs:
%   root    - approximate root of the function
%   iter    - number of iterations performed
function [root, iter] = false_pos(f, a, b, tol, maxiter)
    % Set default tolerance if not provided
    if nargin < 4 || isempty(tol)
        tol = 1e-6;
    end

    % Set default maximum iterations if not provided
    if nargin < 5 || isempty(maxiter)
        maxiter = 1000;
    end

    % Evaluate function at endpoints
    fa = f(a);
    fb = f(b);

    % Check if the function values at the endpoints have opposite signs
    if fa * fb >= 0
        error('The function values at the endpoints must have opposite signs.');
    end

    iter = 0;

    while abs((b - a) / 2) > tol
        if iter >= maxiter
          printf("Max iter (%g) reached.\n", maxiter)
          break
        endif

        % Calculate new approximated intersection
        inter = (a*fb - b*fa) / (fb - fa);
        % Evaluate function at approximated intersection
        fInter = f(inter);

        % Decide which subinterval to keep
        if fa * fInter < 0
            b = inter;
            fb = fInter;
        else
            a = inter;
            fa = fInter;
        end

        iter = iter + 1;
    end

    % Calculate the approximate root as the midpoint of the final interval
    root = (a + b) / 2;
end
