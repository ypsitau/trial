function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
  %%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
  %%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
  %%   taking num_iters gradient steps with learning rate alpha

  %% Initialize some useful values
  m = length(y); %% number of training examples
  J_history = zeros(num_iters, 1);

  for iter = 1:num_iters

    %% ====================== YOUR CODE HERE ======================
    %% Instructions: Perform a single gradient step on the parameter vector
    %%               theta. 
    %%
    %% Hint: While debugging, it can be useful to print out the values
    %%       of the cost function (computeCostMulti) and gradient here.
    %%
	%% X = [1  x1(1)  x2(1)]  theta = [t0]  y = [y(1)]
	%%     |1  x1(2)  x2(2)|          [t1]      |y(2)|
	%%     |1  x1(3)  x2(3)|          [t2]      |y(3)|
	%%     [1  x1(4)  x2(4)]                    [y(4)]

	theta = theta - alpha * X' * (X * theta - y) / m;

    %% ============================================================

    %% Save the cost J in every iteration    
    J_history(iter) = computeCostMulti(X, y, theta);

  end

end
