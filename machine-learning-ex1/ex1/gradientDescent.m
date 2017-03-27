function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
  %%GRADIENTDESCENT Performs gradient descent to learn theta
  %%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
  %%   taking num_iters gradient steps with learning rate alpha
  
  %% Initialize some useful values
  m = length(y); %% number of training examples
  J_history = zeros(num_iters, 1);
  %% J_history = [j1]
  %%             |j2|
  %%             |j3|
  %%             |j4| |
  %%             |j5| | iterations
  %%             [j6] V
  for iter = 1 : num_iters

	%% ====================== YOUR CODE HERE ======================
	%% Instructions: Perform a single gradient step on the parameter vector
	%%               theta. 
	%%
	%% Hint: While debugging, it can be useful to print out the values
	%%       of the cost function (computeCost) and gradient here.
	%%
	%% X = [1  x(1)]  theta = [t0]  y = [y(1)]
	%%     |1  x(2)|          [t1]      |y(2)|
	%%     |1  x(3)|                    |y(3)|
	%%     [1  x(4)]                    [y(4)]
	%%
    %% X' = [  1     1     1     1 ] 
	%%      [x(1)  x(2)  x(3)  x(4)]

	h = X * theta;
	theta = theta - alpha * X' * (h - y) / m;

	%% ============================================================
	
	%% Save the cost J in every iteration    
	J_history(iter) = computeCost(X, y, theta);
  end

end
