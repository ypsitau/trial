function J = computeCost(X, y, theta)
  %%
  %%COMPUTECOST Compute cost for linear regression
  %%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
  %%   parameter for linear regression to fit the data points in X and y
  %% Initialize some useful values
  m = length(y); %% number of training examples

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the cost of a particular choice of theta
  %%               You should set J to the cost.
  %% X = [1  x(1)]  theta = [t0]  y = [y(1)]
  %%     |1  x(2)|          [t1]      |y(2)|
  %%     |1  x(3)|                    |y(3)|
  %%     [1  x(4)]                    [y(4)]
  tmp = X * theta - y;
  J = (tmp' * tmp) / (2 * m);
  %% =========================================================================
end
