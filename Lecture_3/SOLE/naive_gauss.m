% forwardElimination: Transforms a matrix into upper triangular form.
%
% input:
%   A = augmented coefficient matrix [A|b].
%
% output:
%   U = The upper triangular matrix resulting from forward elimination.
function U = naive_gauss(A)
    % Get the size of the matrix (number of equations)
    [n, m] = size(A);

    % Check if the matrix is augmented correctly
    if m ~= n + 1
        error('Matrix must be an augmented matrix of size n x (n+1).');
    end

    % --- Forward Elimination ---
    % This part of the algorithm transforms the matrix into an upper triangular form.
    for k = 1:n-1
        % Pivot element is A(k,k)
        if A(k,k) == 0
            error('Zero pivot element encountered. Naive Gaussian elimination cannot proceed.');
        end

        % For each row below the pivot row
        for i = k+1:n
            % Calculate the factor for elimination
            factor = A(i,k) / A(k,k);

            % Update the row i by subtracting the scaled pivot row k
            A(i, k:n+1) = A(i, k:n+1) - factor * A(k, k:n+1);
        end
    end

    % Return the upper triangular matrix
    U = A;
end

