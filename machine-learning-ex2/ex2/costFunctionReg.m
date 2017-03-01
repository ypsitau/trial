function [J, grad] = costFunctionReg(theta, X, y, lambda)
  %%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
  %%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
  %%   theta as the parameter for regularized logistic regression and the
  %%   gradient of the cost w.r.t. to the parameters. 

  %% X = [1  x1(1)  x2(1)  x3(1) ... x28(1)]
  %%     |1  x1(2)  x2(2)  x3(2) ... x28(2)|
  %%     |1  x1(3)  x2(3)  x3(3) ... x28(3)|
  %%     |1  x1(4)  x2(4)  x3(4) ... x28(4)|
  %%     [1  x1(5)  x2(5)  x3(5) ... x28(5)]
  %% y = [y(1)]  y(i) = 0 or 1
  %%     |y(2)|
  %%     |y(3)|
  %%     |y(4)|
  %%     [y(5)]

  %% theta = [t0 ]
  %%         |t1 |
  %%         |t2 |
  %%         |t3 |
  %%           :
  %%         [t28]

  %% Initialize some useful values
  m = length(y); %% number of training examples

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the cost of a particular choice of theta.
  %%               You should set J to the cost.
  %%               Compute the partial derivatives and set grad to the partial
  %%               derivatives of the cost w.r.t. each parameter in theta

  h = sigmoid(X * theta);
  %% h = [h(1)]
  %%     |h(2)|
  %%     |h(3)|
  %%     |h(4)|
  %%     [h(5)]

  J = (-y' * log(h) - (1 - y)' * log(1 - h)) / m
  grad = ((h - y)' * X / m)';

  thetaPart = theta(2 : end)
  J = J + lambda * thetaPart' * thetaPart / (2 * m);
  grad(2 : end) = grad(2 : end) + lambda * theta(2 : end) / m
  %% grad = [g0 ]
  %%        |g1 |
  %%        [g2 |
  %%        |g3 |
  %%          :
  %%        [g28]

  %% =============================================================

end
