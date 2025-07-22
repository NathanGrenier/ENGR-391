% ESTIMATE_NEXT_ERROR Estimate the next approximate error based on the algorithm's order of convergence.
%
%   Inputs:
%       algorithm    - String specifying the algorithm: 'bisection', 'fixed_point', or 'newton'
%       current_error - Current approximate error (scalar, typically positive)
%       lambda       - Asymptotic error constant (required for 'fixed_point' and 'newton')
%
%   Output:
%       next_error   - Estimated next approximate error
%
%   Notes:
%       - For 'bisection', lambda is fixed at 1/2 internally; any provided lambda is ignored.
%       - For 'fixed_point', lambda is |g'(r)|, where g is the fixed-point function.
%       - For 'newton', lambda is |f''(r) / (2f'(r))|, where f is the function being solved.
function next_error = estimate_next_error(algorithm, current_error, lambda)
    % Check for minimum required inputs
    if nargin < 2
        error('At least two inputs are required: algorithm and current_error');
    end

    switch lower(algorithm)
        case 'bisection'
            alpha = 1;
            lambda_internal = 0.5; % Fixed asymptotic constant
            if nargin > 2
                warning('Lambda is not used for bisection method; ignoring provided value');
            end
        case 'fixed_point'
            if nargin < 3
                error('Lambda must be provided for fixed_point method');
            end
            alpha = 1;
            lambda_internal = lambda; % User-provided |g'(r)|
        case 'newton'
            if nargin < 3
                error('Lambda must be provided for newton method');
            end
            alpha = 2;
            lambda_internal = lambda; % User-provided |f''(r) / (2f'(r))|
        otherwise
            error('Unknown algorithm: %s. Use ''bisection'', ''fixed_point'', or ''newton''', algorithm);
    end

    % Calculate the next error
    next_error = lambda_internal * (current_error)^alpha;
end
