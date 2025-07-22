%% generic_taylor.m
% A generic Taylor series expansion function using Octave's symbolic package
%
% Usage:
%   S = generic_taylor(f, var, a, n)
%     - f   : symbolic expression or string representing the function (e.g. exp(x), 'sin(x)')
%     - var : symbolic variable or string (e.g. x or 'x')
%     - a   : expansion point (numeric or symbolic)
%     - n   : order of the series (integer >= 0)
%
% Returns:
%   S : symbolic Taylor polynomial of order n around x = a

function S = Taylor(f, var, a, n)
  if ~exist('taylor', 'file')
    pkg load symbolic;
  endif

  % Convert inputs to symbolic if needed
  if ischar(var) || isstring(var)
    var = sym(var);
  end

  if ischar(f) || isstring(f)
    f = sym(f);
  end

  if ~isa(f, 'sym')
    error('Function f must be a symbolic expression or string.');
  end

  S = taylor(f, var, a, 'order', n+1);
end

