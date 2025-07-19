% Inputs:
%   A        - Input matrix
%   x0       - Desired precision
% Outputs:
%   digits   - number of digits needed for certain percision after round-off
%              errors are considered.
function digits = digits_needed(A, precision)
  digits = ceil(log10(cond(A, inf)) + precision)
end
