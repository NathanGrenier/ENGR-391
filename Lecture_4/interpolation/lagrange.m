% lagrange_interpolation Creates a function handle for the Lagrange interpolating polynomial.
%
%   Inputs:
%     m - The degree of the polynomial (integer).
%     x - A row or column vector of x-coordinates of the data points.
%     y - A row or column vector of y-coordinates of the data points.
%         length(x) and length(y) must be equal to m + 1.
%
%   Output:
%     P - A function handle. You can call it like Y = P(X_eval) to get the
%         polynomial's value at one or more points in X_eval.
%
%   The polynomial is of the form: P(x) = sum_{i=1 to n} [y_i * L_i(x)]
%   where n = m + 1.
function P = lagrange(m, x, y)
  % Ensure x and y are column vectors for consistency
  x = x(:);
  y = y(:);

  n = length(x);

  % --- Input Validation ---
  if n ~= length(y)
    error('Input vectors x and y must have the same number of elements.');
  end
  if n ~= m + 1
    error('The number of data points (n) must be equal to the degree m + 1.');
  end
  if length(unique(x)) ~= n
      error('All x-coordinates must be distinct for Lagrange interpolation.');
  end

  % --- Return the Polynomial Function Handle ---
  % This uses a feature called a "function closure" or "anonymous function".
  % The returned function 'P' has access to the 'x' and 'y' from this scope.
  P = @(x_eval) evaluate_poly(x_eval, n, x, y);
end

% --- Nested function to perform the evaluation ---
% It is defined within the main function's scope to have access to n, x, and y.
function total_sum = evaluate_poly(x_eval, n, x, y)
  % Ensure x_eval is a column vector for element-wise operations
  x_eval = x_eval(:);

  % Initialize the total sum. The size must match the evaluation points.
  total_sum = zeros(size(x_eval));

  % Loop through each data point to compute y_i * L_i(x)
  for i = 1:n
    % Calculate the i-th Lagrange basis polynomial, L_i(x_eval)
    % Start with L_i = 1
    L_i = ones(size(x_eval));

    % Loop through j to compute the product Π (x - x_j) / (x_i - x_j)
    for j = 1:n
      if i ~= j
        % Element-wise multiplication for vector x_eval
        L_i = L_i .* (x_eval - x(j)) / (x(i) - x(j));
      end
    end

    % Add the weighted basis polynomial to the total sum
    total_sum = total_sum + y(i) * L_i;
  end
end
