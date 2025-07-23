% LEAST_SQUARES_NORMAL_EQ Solves for the optimal parameter vector a using least squares
% with normal equations for the system A a ≈ b.
%
% Inputs:
%   A - m x n matrix (design matrix, e.g., [1, x, x^2] for each row)
%   b - m x 1 vector (observation vector)
%
% Output:
%   a - n x 1 vectora =
function a = lsr_normal(A, b)
    % Compute A^T A
    ATA = A' * A;

    % Compute A^T b
    ATb = A' * b;

    % Solve the normal equations: A^T A a = A^T b
    a = ATA \ ATb;
end

% Example usage for the given data
% Define the design matrix A
%{
A = [1, 0, 0;
     1, 1, 1;
     1, 2, 4;
     1, 3, 9;
     1, 4, 16;
     1, 5, 25];

% Define the observation vector b
b = [2.1; 7.7; 13.6; 27.2; 40.9; 61.1];

% Compute the optimal parameters
a = lsr_normal(A, b);
%}
