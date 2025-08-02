% Define the function to calculate the upper bound of the truncation error for a
% specified quadrature rule by automatically calculating the necessary derivative.
%
% Degree of Precision:
%   Trapezoid: 1
%   Simpson's 1/3: 3
% Order of Truncation Error:
%   Composite Trapezoid: Order 2 in h
%   Composite Simpson:  Order 4 in h
%
% Parameters:
%   f: A function handle to the function to be integrated (e.g., @(x) exp(x)).
%   a: The starting point of the integration interval.
%   b: The ending point of the integration interval.
%   method: A case-insensitive string specifying the rule, either 'trapezoid' or 'simpson'.
%
% Returns:
%   error_bound: The maximum possible truncation error for the specified method.
function error_bound = truncation_error(f, a, b, method)

    % --- Step 0: Input validation and symbolic setup ---
    % The strcmpi function performs a case-insensitive comparison.
    if ~ischar(method) || (~strcmpi(method, 'trapezoid') && ~strcmpi(method, 'simpson'))
        error("Method must be either 'trapezoid' or 'simpson' (case-insensitive).");
    end

    try
        pkg load symbolic;
    catch
        error('The Symbolic package is not loaded. Please run "pkg load symbolic" first.');
    end

    syms x_sym; % Create a symbolic variable 'x'
    f_sym = f(x_sym); % Convert the function handle to a symbolic expression

    % --- Step 1: Calculate the required derivative based on the method ---

    % Use a large number of points for a good approximation of the maximum
    num_points = 1000;
    x_vals = linspace(a, b, num_points);

    % strcmpi ensures the method name is handled case-insensitively
    if strcmpi(method, 'trapezoid')
        % For the trapezoid rule, we need the 2nd derivative.
        f_dd_sym = diff(f_sym, x_sym, 2);
        f_dd = function_handle(f_dd_sym);

        % Find the maximum absolute value of the second derivative
        max_f_deriv = max(abs(f_dd(x_vals)));

        % Calculate the error bound for the Trapezoid Rule
        % Bound: |E_T| <= ((b-a)^3 / 12) * max|f''(x)|
        error_bound = ((b - a)^3 / 12) * max_f_deriv;

    elseif strcmpi(method, 'simpson')
        % For Simpson's rule, we need the 4th derivative.
        f_dddd_sym = diff(f_sym, x_sym, 4);
        f_dddd = function_handle(f_dddd_sym);

        % Find the maximum absolute value of the fourth derivative
        max_f_deriv = max(abs(f_dddd(x_vals)));

        % Calculate the error bound for Simpson's 1/3 Rule
        % Bound: |E_S| <= ((b-a)^5 / 2880) * max|f^(IV)(x)|
        error_bound = ((b - a)^5 / 2880) * max_f_deriv;
    end
end
