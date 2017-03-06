function p = predict(Theta1, Theta2, X)
  %%PREDICT Predict the label of an input given a trained neural network
  %%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
  %%   trained weights of a neural network (Theta1, Theta2)

  %% Useful values
  m = size(X, 1);
  num_labels = size(Theta2, 1);

  %% You need to return the following variables correctly 
  p = zeros(size(X, 1), 1);

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Complete the following code to make predictions using
  %%               your learned neural network. You should set p to a 
  %%               vector containing labels between 1 to num_labels.
  %%
  %% Hint: The max function might come in useful. In particular, the max
  %%       function can also return the index of the max element, for more
  %%       information see 'help max'. If your examples are in rows, then, you
  %%       can use max(A, [], 2) to obtain the max for each row.
  %%

  size(X)
  
  %% X = [x1(1)     x2(1)     x3(1)    ... x400(1)   ]
  %%     |x1(2)     x2(2)     x3(2)    ... x400(2)   |
  %%     |x1(3)     x2(3)     x3(3)    ... x400(3)   |
  %%                            :
  %%     [x1(5000)  x2(5000)  x3(5000) ... x400(5000)]

  %% Theta1 = [t1,0   t1,1   t1,2   t1,3   ... t1,400 ]
  %%          |t2,0   t2,1   t2,2   t2,3   ... t2,400 |
  %%          |t3,0   t3,1   t3,2   t3,3   ... t3,400 |
  %%                               :
  %%          [t25,0  t25,1  t25,2  t25,3  ... t25,400]

  %% Theta2 = [t1,0   t1,1   t1,2   t1,3   ... t1,25 ]  .. one
  %%          |t2,0   t2,1   t2,2   t2,3   ... t2,25 |  .. two
  %%          |t3,0   t3,1   t3,2   t3,3   ... t3,25 |  .. three
  %%                             :
  %%          [t10,0  t10,1  t10,2  t10,3  ... t10,25]  .. zero

  X = [ones(m, 1) X];

  %% X = [1  x1(1)     x2(1)     x3(1)    ... x400(1)   ]
  %%     |1  x1(2)     x2(2)     x3(2)    ... x400(2)   |
  %%     |1  x1(3)     x2(3)     x3(3)    ... x400(3)   |
  %%                             :
  %%     [1  x1(5000)  x2(5000)  x3(5000) ... x400(5000)]

  X = sigmoid(X * Theta1');

  X = [ones(m, 1) X];

  X = X * Theta2';
  [tmp, p] = max(X, [], 2);

  %% p = [p(1)   ]
  %%     |p(2)   |
  %%     |p(3)   |
  %%         ;
  %%     |p(5000)|

  %% =========================================================================


end
