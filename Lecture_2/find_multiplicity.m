% Determines the multiplicity of a root x_r for a function f.
%
% Parameters:
%   f: A function handle for the original function, e.g., @(x) x.^2.
%   x_r: An approximation of the root.
%   sign (Even, Odd): A string to add extra context to the function.
function m = find_multiplicity(f, x_r, sign, tol)
  if (nargin < 3)
    sign = "None";
  end

  if (nargin < 4)
    tol = 0.1; % Tolerance for what is considered "zero"
  end

  % Check if the provided x_r is actually a root
  if abs(f(x_r)) >= tol
    fprintf("Error: The value x = %f is not a root of this function (f(x) = %e).\n", x_r, f(x_r));
    return;
  end

  % --- 2. Find the Multiplicity ---
  pkg load symbolic
  syms x
  current_func = f(x);

  m = 1;
  max_iter = 20;

  for i = 1:max_iter
    % Define the symbolic derivative of the current function
    df_dx = diff(current_func, x);

    % Evaluate the derivative at the root
    derivative_val = double(subs(df_dx, x, num2str(x_r)));

    printf("Iteration [%d]: %f\n", m+1, derivative_val);

    if abs(derivative_val) >= tol
      % This is the first derivative that is not zero, so we're done.
      break;
    else
      % This derivative is also zero. Increment multiplicity and continue.
      m = m + 1;
      current_func = df_dx;
    end
  end

  switch lower(sign)
      case 'even'
        if (mod(m, 2) != 0)
          disp("[Warning] The multiplicity is 'odd' when it should be 'even'. Last function:");
          pretty(current_func);
        endif
      case 'odd'
        if (mod(m, 2) == 0)
          disp("[Warning] The multiplicity is 'even' when it should be 'odd'. Last function:");
          pretty(current_func);
        endif
      otherwise
          error('Unknown sign: %s. Use ''Even'' or ''Odd''',
          sign);
  end

  fprintf("### The function has a multiplicity of m = %d ###\n", m);
end
