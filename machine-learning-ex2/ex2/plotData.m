function plotData(X, y)
  %%PLOTDATA Plots the data points X and y into a new figure 
  %%   PLOTDATA(x,y) plots the data points with + for the positive examples
  %%   and o for the negative examples. X is assumed to be a Mx2 matrix.

  %% Create New Figure
  figure; hold on;

  %% X = [x1(1)  x2(1)]  y = [y(1)]  y(i) = 0 or 1
  %%     |x1(2)  x2(2)|      |y(2)|
  %%     |x1(3)  x2(3)|      |y(3)|
  %%     |x1(4)  x2(4)|      |y(4)|
  %%     [x1(5)  x2(5)]      [y(5)]

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Plot the positive and negative examples on a
  %%               2D plot, using the option 'k+' for the positive
  %%               examples and 'ko' for the negative examples.
  %%

  pos = find(y == 1);
  neg = find(y == 0);

  plot(X(pos, 1), X(pos, 2), 'k+', 'LineWidth', 2, 'MarkerSize', 7)
  plot(X(neg, 1), X(neg, 2), 'ko', 'LineWidth', 2, 'MarkerSize', 7,
	   'MarkerFaceColor', 'y')

  %% =========================================================================

  hold off;

end
