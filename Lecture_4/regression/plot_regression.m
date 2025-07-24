% plot_regression - Plots data points and the regression line
%
% Inputs:
%    reg_func - function handle for the regression line (e.g., @(x) a*x + b)
%    x - vector of x values
%    y - vector of y values
function plot_regression(reg_func, x, y)
  % Ensure column vectors for plotting
  x = x(:);
  y = y(:);

  % Generate smooth x values for the regression line
  x_reg = linspace(min(x), max(x), 200)';
  y_reg = reg_func(x_reg);

  % Create the plot
  figure;
  hold on;
  grid on;
  box on;

  % Plot data points
  scatter(x, y, 60, 'b', 'filled', 'MarkerEdgeColor', 'k', ...
          'DisplayName', 'Data Points', 'MarkerFaceAlpha', 0.8);

  % Plot regression line
  plot(x_reg, y_reg, 'r-', 'LineWidth', 2, 'DisplayName', 'Regression Line');

  % Improve aesthetics
  xlabel('x', 'FontWeight', 'bold', 'FontSize', 12);
  ylabel('y', 'FontWeight', 'bold', 'FontSize', 12);
  title('Linear Regression Fit', 'FontWeight', 'bold', 'FontSize', 14);
  legend('Location', 'northwest', 'FontSize', 11, 'Box', 'off');
  set(gca, 'FontSize', 12, 'LineWidth', 1.2);
  set(gcf, 'Color', [1 1 1]);

  hold off;
end
