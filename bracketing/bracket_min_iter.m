% Calculate the number of iterations needed for bracketed methods
% Inputs:
%   a0, b0 - initial interval endpoints
%   TOL    - desired tolerance
% Output:
%   n      - number of iterations required
function n = min_iter(a0, b0, TOL)
    % Compute initial interval length
    inter_length = abs(b0 - a0);

    % Check for invalid inputs
    if TOL <= 0
        error('Tolerance must be positive');
    end

    if inter_length == 0
        error('Initial interval has zero length');
    end

    % Compute the number of iterations
    x = ((log(inter_length) - log(TOL)) / log(2)) - 1;
    n = max(0, ceil(x));
end
