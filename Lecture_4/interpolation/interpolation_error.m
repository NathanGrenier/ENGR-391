% Calculates an upper bound for the interpolation error using symbolic differentiation.
%
% Args:
%   f: A handle to the symbolic function being interpolated (e.g., @(x) sin(x)).
%   x_nodes: A vector containing the x-coordinates of the interpolation points.
%   c: The point at which to evaluate the interpolation error.
%
% Returns:
%   An upper bound for the interpolation error E(c).
function err = interpolation_error(f, x_nodes, c)
  m = length(x_nodes);

  % Ensure the symbolic package is loaded
  pkg load symbolic
  syms x

  % Create the symbolic function expression
  current_func = f(x);

  % Calculate the symbolic m-th derivative of the function
  df_dx = diff(current_func, x, m);

  % Initialize a vector to hold the derivative values
  derivative_values_at_nodes = zeros(1, m);

  % Loop through each node, convert to string, substitute, and convert to double.
  % This is a more robust method than vectorized substitution.
  for i = 1:m
      node_str = num2str(x_nodes(i));
      derivative_values_at_nodes(i) = double(subs(df_dx, x, node_str));
  end

  % Find the maximum absolute value of the derivative among the nodes.
  % This value will be used as the f^(m)(c) term to get an error bound.
  max_derivative_val = max(abs(derivative_values_at_nodes));

  % Calculate the product term: (c - x_1)(c - x_2)...(c - x_m)
  product_term = prod(c - x_nodes);

  % Calculate m factorial
  m_factorial = factorial(m);

  % Calculate the interpolation error bound using the theorem's formula
  err = (product_term / m_factorial) * max_derivative_val;
end
