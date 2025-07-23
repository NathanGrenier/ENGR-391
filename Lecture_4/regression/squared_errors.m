%Compute SSE, MSE, and RMSE for a model f at points x vs. data y
%
%   Inputs:
%     f : function handle, such that y_pred = f(x) produces a vector of
%         predicted values the same size as x (and y)
%     x : vector of predictor values (n-by-1 or 1-by-n)
%     y : vector of observed responses (same size as x)
%
%   Outputs:
%     SE  : Sum of squared errors
%     MSE  : Mean squared error
%     RMSE : Root mean squared error
%
%   Example:
%     x = linspace(0,2*pi,100);
%     y = sin(x) + 0.1*randn(size(x));
%     [SE, MSE, RMSE] = squared_errors(@sin, x, y);
function [SE, MSE, RMSE] = squared_errors(f, x, y)
  % ensure x and y are column vectors
  x = x(:);
  y = y(:);
  n = numel(x);
  if numel(y) ~= n
    error('x and y must have the same number of elements');
  end

  % compute model predictions
  y_pred = f(x);
  if numel(y_pred) ~= n
    error('Function f must return a vector of the same size as x (and y)');
  end

  % compute squared errors
  residuals = (y - y_pred).^2;

  % sum of squared errors
  SE = sum(residuals);

  % mean squared error
  MSE = SE / n;

  % root mean squared error
  RMSE = sqrt(MSE);
end

