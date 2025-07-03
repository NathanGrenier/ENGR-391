% truncation_error.m
% Calculates the truncation (remainder) error of a Taylor series expansion
% of a given function f around point a, of order n, evaluated at x.
%
% Usage:
%   err = truncation_error(f, var, a, n, x)
%     f   : symbolic expression or string, e.g. 'exp(x)', sin(x), etc.
%     var : symbolic variable or string, e.g. x or 'x'
%     a   : expansion point (numeric or symbolic)
%     n   : order of the Taylor polynomial (integer >= 0)
%     x   : point at which to evaluate the error (numeric or symbolic)
%
% Returns:
%   err : absolute truncation error |f(x) - P_n(x)|

function err = trunc_err(f, var, a, n, x)
  if ~exist('taylor', 'file')
    pkg load symbolic;
  endif

  if ischar(var) || isstring(var)
    var = sym(var);
  end

  if ischar(f) || isstring(f)
    f_sym = sym(f);
  else
    f_sym = f;
  end

  % Compute the Taylor polynomial of order n
  Pn = taylor(f_sym, var, a, 'order', n+1);

  % Evaluate function and polynomial at x
  f_val  = double(subs(f_sym, var, x));
  Pn_val = double(subs(Pn, var, x));

  % Compute absolute error
  err = abs(f_val - Pn_val);
end

