% vandermonde_interpolation Solves for polynomial coefficients using the Vandermonde method.
%
%   Inputs:
%     m - The degree of the polynomial (integer).
%     x - A row or column vector of x-coordinates of the data points.
%     y - A row or column vector of y-coordinates of the data points.
%         length(x) and length(y) must be equal to m + 1.
%
%   Outputs:
%     a - A column vector containing the polynomial coefficients [a_0; a_1; ...; a_m].
function a = vandermonde(m, x, y)
  % Ensure x and y are column vectors for consistent matrix operations
  x = x(:);
  y = y(:);

  n = length(x);

  % --- Input Validation ---
  if n ~= length(y)
    error('Input vectors x and y must have the same number of elements.');
  end
  if n ~= m + 1
    error('The number of data points must be equal to the degree m + 1.');
  end

  % --- Vandermonde Matrix Construction ---
  % Initialize an n x n matrix (where n = m + 1)
  V = ones(n, n);

  % Populate the matrix V where V(i, j) = x_i^(j-1)
  % The first column is already ones (x_i^0)
  for j = 2:n % Corresponds to powers 1 to m
    V(:, j) = x .^ (j - 1);
  end

  % --- Solving the System ---
  % Solve the linear system V*a = y for the coefficient vector a.
  % The backslash operator '\' in Octave is optimized for this.
  a = V \ y;
end
