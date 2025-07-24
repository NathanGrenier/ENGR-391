% spline_linear: Interpolates data using Piecewise Linear Interpolation with linear extrapolation.
%
% Inputs:
%   x: A vector of x-coordinates of the data points (must be monotonic).
%   y: A vector of y-coordinates of the data points.
%   xi: A vector or scalar of x-coordinates at which to interpolate/extrapolate.
%
% Output:
%   yi: The interpolated/extrapolated y-values corresponding to xi.
%
% Description:
%   This function performs piecewise linear interpolation. For points in xi
%   within the range of x, it finds the interval [x(k), x(k+1)] and linearly
%   interpolates the corresponding y-value.
%
%   For points in xi that are outside the range of x, it performs linear
%   extrapolation using the slope of the first or last segment.
function yi = spline_linear(x, y, xi)
  % --- Input Validation ---
  if ~isvector(x) || ~isvector(y)
    error('Inputs x and y must be vectors.');
  end
  if length(x) ~= length(y)
    error('x and y vectors must have the same length.');
  end
  if length(x) < 2
    error('At least two data points are required for interpolation.');
  end

  % Ensure x is sorted, as the logic depends on it.
  [x, sort_indices] = sort(x);
  y = y(sort_indices);

  % Ensure inputs are column vectors for easier indexing
  x = x(:);
  y = y(:);
  xi = xi(:);

  n = length(x);
  yi = zeros(size(xi));

  % --- Pre-calculate slopes for extrapolation ---
  % Slope of the first segment (for extrapolating to the left)
  slope_first = (y(2) - y(1)) / (x(2) - x(1));
  % Slope of the last segment (for extrapolating to the right)
  slope_last = (y(n) - y(n-1)) / (x(n) - x(n-1));

  % --- Interpolation & Extrapolation Loop ---
  for i = 1:length(xi)
    current_x = xi(i);

    % --- Extrapolation Cases ---
    % If current_x is less than the first x-value, extrapolate from the first segment
    if current_x < x(1)
      yi(i) = y(1) + slope_first * (current_x - x(1));
      continue;
    % If current_x is greater than the last x-value, extrapolate from the last segment
    elseif current_x > x(n)
      yi(i) = y(n) + slope_last * (current_x - x(n));
      continue;
    end

    % --- Interpolation Case (within the range of x) ---
    % Find the interval [x(k), x(k+1)] that contains the current_x
    % The 'find' function returns the index of the last point less than or equal to current_x
    k = find(x <= current_x, 1, 'last');

    % Handle the case where xi is exactly the last data point
    if k == n
      yi(i) = y(n);
      continue;
    end

    % --- Linear Interpolation Formula ---
    % y = y1 + (y2 - y1) * (x - x1) / (x2 - x1)
    x1 = x(k);
    y1 = y(k);
    x2 = x(k+1);
    y2 = y(k+1);

    yi(i) = y1 + (y2 - y1) * (current_x - x1) / (x2 - x1);
  end
end
