function J = computeCostMulti(X, y, theta)
  %%COMPUTECOSTMULTI Compute cost for linear regression with multiple variables
  %%   J = COMPUTECOSTMULTI(X, y, theta) computes the cost of using theta as the
  %%   parameter for linear regression to fit the data points in X and y
  
  %% Initialize some useful values
  m = length(y); %% number of training examples
  
  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the cost of a particular choice of theta
  %%               You should set J to the cost.
  
  %% X = [1  x1(1)  x2(1)]  theta = [t0]  y = [y(1)]
  %%     |1  x1(2)  x2(2)|          [t1]      |y(2)|
  %%     |1  x1(3)  x2(3)|          [t2]      |y(3)|
  %%     [1  x1(4)  x2(4)]                    [y(4)]
  tmp = X * theta - y;
  J = (tmp' * tmp) / (2 * m);
  
  
  
  
  %% =========================================================================

end
