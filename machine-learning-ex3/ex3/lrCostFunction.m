function [J, grad] = lrCostFunction(theta, X, y, lambda)
  %%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
  %%regularization
  %%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
  %%   theta as the parameter for regularized logistic regression and the
  %%   gradient of the cost w.r.t. to the parameters. 

  %% Initialize some useful values
  m = length(y); %% number of training examples

  %% You need to return the following variables correctly 
  J = 0;
  grad = zeros(size(theta));

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the cost of a particular choice of theta.
  %%               You should set J to the cost.
  %%               Compute the partial derivatives and set grad to the partial
  %%               derivatives of the cost w.r.t. each parameter in theta
  %%
  %% Hint: The computation of the cost function and gradients can be
  %%       efficiently vectorized. For example, consider the computation
  %%
  %%           sigmoid(X * theta)
  %%
  %%       Each row of the resulting matrix will contain the value of the
  %%       prediction for that example. You can make use of this to vectorize
  %%       the cost function and gradient computations. 
  %%
  %% Hint: When computing the gradient of the regularized cost function, 
  %%       there're many possible vectorized solutions, but one solution
  %%       looks like:
  %%           grad = (unregularized gradient for logistic regression)
  %%           temp = theta; 
  %%           temp(1) = 0;   %% because we don't add anything for j = 0  
  %%           grad = grad + YOUR_CODE_HERE (using the temp variable)
  %%

  %% X = [x0(1)  x1(1)  x2(1)  x3(1)]  y = [y(1)]
  %%     |x0(2)  x1(2)  x2(2)  x3(2)|      |y(2)|
  %%     |x0(3)  x1(3)  x2(3)  x3(3)|      |y(3)|
  %%     |x0(4)  x1(4)  x2(4)  x3(4)|      |y(4)|
  %%     [x0(5)  x1(5)  x2(5)  x3(5)]      [y(5)]

  %% theta = [t0]
  %%         |t1|
  %%         |t2|
  %%         [t3]

  theta_t = theta;
  theta_t(1) = 0;
  
  h = sigmoid(X * theta);

  J = sum(-y .* log(h) - (1 - y) .* log(1 - h)) / m;
  J = J + lambda * sum(theta_t .^ 2) / (2 * m);

  %% =============================================================

  grad = ((h - y)' * X)' / m;
  grad = grad + lambda * theta_t / m;

end
