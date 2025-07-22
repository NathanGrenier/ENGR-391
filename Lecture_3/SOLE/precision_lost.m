% Inputs:
%   A        - Input matrix.
% Outputs:
%   digits   - The number of significant digits lost in calculation.
function digits = precision_lost(A)
  digits = log10(cond(A, inf))
end
