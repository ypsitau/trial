function [J, grad] = costFunction(theta, X, y)
  %%COSTFUNCTION Compute cost and gradient for logistic regression
  %%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
  %%   parameter for logistic regression and the gradient of the cost
  %%   w.r.t. to the parameters.

  %% X = [1  x1(1)  x2(1)]  y = [y(1)]  y(i) = 0 or 1
  %%     |1  x1(2)  x2(2)|      |y(2)|
  %%     |1  x1(3)  x2(3)|      |y(3)|
  %%     |1  x1(4)  x2(4)|      |y(4)|
  %%     [1  x1(5)  x2(5)]      [y(5)]

  %% theta = [t0]
  %%         |t1]
  %%         [t2]

  %% Initialize some useful values
  m = length(y); %% number of training examples

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the cost of a particular choice of theta.
  %%               You should set J to the cost.
  %%               Compute the partial derivatives and set grad to the partial
  %%               derivatives of the cost w.r.t. each parameter in theta
  %%
  %% Note: grad should have the same dimensions as theta
  %%

  h = sigmoid(X * theta);
  %% h = [h(1)]
  %%     |h(2)|
  %%     |h(3)|
  %%     |h(4)|
  %%     [h(5)]

  J = (-y' * log(h) - (1 - y)' * log(1 - h)) / m;
  grad = ((h - y)' * X / m)';
  %% grad = [g0]
  %%        |g1|
  %%        [g2]

  %% =============================================================

end
