% Estimates the forward error given a function, its multiplicity, and an estimate of the root.
%
% Parameters:
%   f: A function handle for the original function, e.g., @(x) x.^2.
%   x_r: An approximation of the root.
%   m: The multiplicity of the function f. Defaults to 1.
function error = forward_error(f, x_r, m)
  if (nargin < 3)
    m = 1;
  end

  pkg load symbolic
  syms x

  ff = f(x);
  df_dx = diff(ff, x, m);
  df_dx_num = double(subs(df_dx, x, num2str(x_r)));

  error = abs(((factorial(m) * f(x_r)) / df_dx_num)^(1/m));
end
