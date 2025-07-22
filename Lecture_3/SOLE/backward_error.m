% backward_error: Calculate the backward error for a system of linear equations
% given an approximation of the solution
%
% input:
%   A = Coefficient matrix
%   b = Right hand side matrix
%   x_r = Approximation of the solution (Matrix)
%   mode = Type of forward error. ['Relative', 'Absolute']. Default: Relative
%
% output:
%   err
function err = backward_error(A, b, x_r, mode='relative')
    Ax_r = A*x_r;
    absolute_error = norm(Ax_r - b, inf);

    switch lower(mode)
        case 'relative'
          err = absolute_error / norm(b, inf);
        case 'absolute'
          err = absolute_error;
        otherwise
            error('Unknown mode: %s. Use ''relative'' or ''absolute''',
            mode);
    end
end

