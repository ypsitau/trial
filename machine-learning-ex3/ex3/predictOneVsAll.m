function p = predictOneVsAll(all_theta, X)
  %%PREDICT Predict the label for a trained one-vs-all classifier. The labels 
  %%are in the range 1..K, where K = size(all_theta, 1). 
  %%  p = PREDICTONEVSALL(all_theta, X) will return a vector of predictions
  %%  for each example in the matrix X. Note that X contains the examples in
  %%  rows. all_theta is a matrix where the i-th row is a trained logistic
  %%  regression theta vector for the i-th class. You should set p to a vector
  %%  of values from 1..K (e.g., p = [1; 3; 1; 2] predicts classes 1, 3, 1, 2
  %%  for 4 examples) 

  m = size(X, 1);
  num_labels = size(all_theta, 1);

  %% You need to return the following variables correctly 
  p = zeros(size(X, 1), 1);

  %% p = [p(1)   ]
  %%     |p(2)   |
  %%     |p(3)   |
  %%        :
  %%     [p(5000)]

  %% Add ones to the X data matrix
  X = [ones(m, 1) X];

  %% all_theta = [t1,0   t1,1   t1,2   t1,3   ... t1,400 ]  .. one
  %%             |t2,0   t2,1   t2,2   t2,3   ... t2,400 |  .. two
  %%             |t3,0   t3,1   t3,2   t3,3   ... t3,400 |  .. three
  %%                               :
  %%             [t10,0  t10,1  t10,2  t10,3  ... t10,400]  .. zero

  %% X = [1  x1(1)     x2(1)     x3(1)    ... x400(1)   ]
  %%     |1  x1(2)     x2(2)     x3(2)    ... x400(2)   |
  %%     |1  x1(3)     x2(3)     x3(3)    ... x400(3)   |
  %%                            :
  %%     [1  x1(5000)  x2(5000)  x3(5000) ... x400(5000)]

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Complete the following code to make predictions using
  %%               your learned logistic regression parameters (one-vs-all).
  %%               You should set p to a vector of predictions (from 1 to
  %%               num_labels).
  %%
  %% Hint: This code can be done all vectorized using the max function.
  %%       In particular, the max function can also return the index of the 
  %%       max element, for more information see 'help max'. If your examples 
  %%       are in rows, then, you can use max(A, [], 2) to obtain the max 
  %%       for each row.
  %%       

  [tmp, p] = max(X * all_theta', [], 2);

  %% p = [p(1)   ]
  %%     |p(2)   |
  %%     |p(3)   |
  %%         ;
  %%     |p(5000)|

  %% =========================================================================

end
