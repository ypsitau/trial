function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
  %%NNCOSTFUNCTION Implements the neural network cost function for a two layer
  %%neural network which performs classification
  %%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
  %%   X, y, lambda) computes the cost and gradient of the neural network. The
  %%   parameters for the neural network are "unrolled" into the vector
  %%   nn_params and need to be converted back into the weight matrices. 
  %% 
  %%   The returned parameter grad should be a "unrolled" vector of the
  %%   partial derivatives of the neural network.
  %%

  %% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
  %% for our 2 layer neural network
  Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                   hidden_layer_size, (input_layer_size + 1));

  Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                   num_labels, (hidden_layer_size + 1));

  %% Setup some useful variables
  m = size(X, 1);
  
  %% You need to return the following variables correctly 
  J = 0;
  Theta1_grad = zeros(size(Theta1));
  Theta2_grad = zeros(size(Theta2));

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: You should complete the code by working through the
  %%               following parts.
  %%
  %% Part 1: Feedforward the neural network and return the cost in the
  %%         variable J. After implementing Part 1, you can verify that your
  %%         cost function computation is correct by verifying the cost
  %%         computed in ex4.m
  %%
  %% Part 2: Implement the backpropagation algorithm to compute the gradients
  %%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
  %%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
  %%         Theta2_grad, respectively. After implementing Part 2, you can check
  %%         that your implementation is correct by running checkNNGradients
  %%
  %%         Note: The vector y passed into the function is a vector of labels
  %%               containing values from 1..K. You need to map this vector into a 
  %%               binary vector of 1's and 0's to be used with the neural network
  %%               cost function.
  %%
  %%         Hint: We recommend implementing backpropagation using a for-loop
  %%               over the training examples if you are implementing it for the 
  %%               first time.
  %%
  %% Part 3: Implement regularization with the cost function and gradients.
  %%
  %%         Hint: You can implement this around the code for
  %%               backpropagation. That is, you can compute the gradients for
  %%               the regularization separately and then add them to Theta1_grad
  %%               and Theta2_grad from Part 2.
  %%

  %% X = [x1(1)     x2(1)     x3(1)     ..  x400(1)   ]
  %%     |x1(2)     x2(2)     x3(2)     ..  x400(2)   |
  %%     |x1(3)     x2(3)     x3(3)     ..  x400(3)   |
  %%                           :
  %%     [x1(5000)  x2(5000)  x3(5000)  ..  x400(5000)]
  
  %% y = [y(1)   ]   y(n) = 1..10
  %%     |y(2)   |
  %%     |y(3)   |
  %%         :
  %%     [y(5000)]

  %% Theta1 = [t1,0(1)   t1,1(1)   t1,2(1)   ..   t1,400(1) ]
  %%          |t2,0(1)   t2,1(1)   t2,2(1)   ..   t2,400(1) |
  %%          |t3,0(1)   t3,1(1)   t3,2(1)   ..   t3,400(1) |
  %%                              :
  %%          [t25,1(1)  t25,2(1)  t25,3(1)  ..   t25,400(1)]
  
  %% Theta2 = [t1,0(2)   t1,1(2)   t1,2(2)   ..   t1,25(2) ]
  %%          |t2,0(2)   t2,1(2)   t2,2(2)   ..   t2,25(2) |
  %%          |t3,0(2)   t3,1(2)   t3,3(2)   ..   t3,25(2) |
  %%                              :
  %%          [t10,1(2)  t10,2(2)  t10,3(2)  ..   t10,25(2)]
  
  J = 0;
  Y = eye(num_labels);
  for i = 1 : m
	x_i = X(i, :)';
	y_i = Y(:, y(i));
	h = sigmoid(Theta1 * [1; x_i]);
	h = sigmoid(Theta2 * [1; h]);
	J = J + sum(- y_i .* log(h) - (1 - y_i) .* log(1 - h));
  end
  J = J / m;

  J = J + lambda * (sum(Theta1(size(Theta1, 1) + 1 : end) .^ 2) +
  					sum(Theta2(size(Theta2, 1) + 1 : end) .^ 2)) / (2 * m);

  %% -------------------------------------------------------------

  %% =========================================================================

  %% Unroll gradients
  grad = [Theta1_grad(:) ; Theta2_grad(:)];


end