% newton_interpolation Finds the coefficients for a polynomial in Newton form.
%
%   Inputs:
%     m - The degree of the polynomial (integer).
%     x - A row or column vector of x-coordinates of the data points.
%     y - A row or column vector of y-coordinates of the data points.
%         length(x) and length(y) must be equal to m + 1.
%
%   Output:
%     b - A column vector of coefficients [b_0; b_1; ...; b_m].
%
%   The resulting polynomial in Newton form is:
%   P(x) = b_0 + b_1(x-x_0) + b_2(x-x_0)(x-x_1) + ... + b_m(x-x_0)...(x-x_{m-1})
function b = interpolate_newton(m, x, y)
  % Ensure x and y are column vectors
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

  % --- Divided-Difference Table Calculation ---
  % Initialize an n x n matrix to store the divided differences.
  % The first column is simply the y-values.
  div_diff_table = zeros(n, n);
  div_diff_table(:, 1) = y;

  % Iterate through the columns to compute the higher-order differences
  for j = 2:n % Corresponds to the order of the difference
    % For each column, compute the difference based on the previous one
    for i = 1:(n - j + 1)
      numerator = div_diff_table(i+1, j-1) - div_diff_table(i, j-1);
      denominator = x(i+j-1) - x(i);

      if denominator == 0
        error('Cannot perform interpolation with duplicate x-values.');
      end

      div_diff_table(i, j) = numerator / denominator;
    end
  end

  % --- Extract Coefficients ---
  % The coefficients b_0, b_1, ..., b_m are the top diagonal of the table.
  b = div_diff_table(1, :)'; % Transpose to make it a column vector
end
