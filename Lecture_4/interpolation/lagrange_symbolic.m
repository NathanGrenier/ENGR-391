% lagrange_symbolic Constructs a string representation of the Lagrange polynomial.
%
%   poly_string = lagrange_symbolic(m, x, y) returns a string containing
%   the Lagrange interpolating polynomial in its symbolic form with computed
%   denominators for the basis polynomials.
%
%   Inputs:
%     m - The degree of the polynomial (integer).
%     x - A row or column vector of x-coordinates of the data points.
%     y - A row or column vector of y-coordinates of the data points.
%
%   Output:
%     poly_string - A string representing the polynomial in the format:
%                   "P(x) = y_1 * L_1(x) + y_2 * L_2(x) + ..."
%                   with L_i(x) defined with a calculated denominator.

function poly_string = lagrange_symbolic(m, x, y)
    n = length(x);

    % --- Input Validation ---
    if n ~= length(y) || n ~= m + 1
        error('The number of data points must be m+1.');
    end
    if length(unique(x)) ~= n
        error('All x-coordinates must be distinct.');
    end

    % --- Build the String Representation ---
    main_poly_parts = {};
    basis_poly_details_parts = {};

    % Loop through each term y_i * L_i(x)
    for i = 1:n
        % Part 1: Create the main term "y_i * L_i(x)" for the top-level equation
        main_poly_parts{end+1} = sprintf("%g * L_%d(x)", y(i), i);

        % Part 2: Create the detailed explanation for L_i(x)
        numerator_str = "";
        denominator_val = 1; % Initialize denominator for calculation

        is_first_term = true;
        for j = 1:n
            if i == j
                continue;
            end

            % Build the numerator string part: (x - x_j)
            if ~is_first_term
                numerator_str = [numerator_str, ""]; % No separator, they are adjacent brackets
            end
            numerator_str = [numerator_str, sprintf("(x - %g)", x(j))];

            % Calculate the denominator value
            denominator_val = denominator_val * (x(i) - x(j));

            is_first_term = false;
        end

        % Assemble the string for the basis polynomial L_i(x)
        basis_poly_details_parts{end+1} = sprintf("  L_%d(x) = %s / %g", ...
                                                  i, numerator_str, denominator_val);
    end

    % --- Assemble the final output strings ---
    % Join the main polynomial parts with " + "
    full_poly_str = ["P(x) = ", strjoin(main_poly_parts, " + ")];

    % Join the detailed basis parts with newlines
    basis_poly_details = strjoin(basis_poly_details_parts, "\n");

    % Combine everything into the final output string
    poly_string = [full_poly_str, "\n\nWhere:\n", basis_poly_details];
end
