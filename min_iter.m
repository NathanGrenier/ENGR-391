% Function to compute minimum iterations needed for root-finding methods to reach error threshold
%
% Inputs:
%   algorithm     - 'bisection', 'fixed_point', or 'newton'
%   current_error - initial error estimate (positive scalar)
%   lambda        - error constant (ignored for bisection)
%   tol           - desired error threshold (positive scalar)
%
% Output:
%   n             - minimum integer number of iterations so that error_n <= tol
function n = min_iter(algorithm, current_error, lambda, tol)
    % Input validation
    if nargin < 3
        error('At least three inputs required: algorithm, current_error, tol or lambda');
    end

    switch lower(algorithm)
        case 'bisection'
          lambda = 0.5;
          alpha = 1;
        case 'fixed_point'
          alpha = 1;
          if nargin < 4
            error('Lambda must be provided for "fixed_point" method');
          end
        case 'newton'
          alpha = 2;
          if nargin < 4
            error('Lambda must be provided for "newton" method');
          end
        otherwise
            error('Unknown algorithm: %s. Use ''bisection'', ''fixed_point'', or ''newton''', algorithm);
    end

    if nargin < 4
        error('Error threshold tol must be provided');
    end

    err = current_error;
    n = 0;

    % Iterate until error meets threshold
    while err > tol
        err = lambda * err^alpha;
        n = n + 1;
    end
end

