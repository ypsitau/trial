function p = predict(theta, X)
  %%PREDICT Predict whether the label is 0 or 1 using learned logistic 
  %%regression parameters theta
  %%   p = PREDICT(theta, X) computes the predictions for X using a 
  %%   threshold at 0.5 (i.e., if sigmoid(theta'*x) >= 0.5, predict 1)

  %% X = [1  x1(1)  x2(1)]
  %%     |1  x1(2)  x2(2)|
  %%     |1  x1(3)  x2(3)|
  %%     |1  x1(4)  x2(4)|
  %%     [1  x1(5)  x2(5)]

  %% theta = [t0]
  %%         |t1]
  %%         [t2]

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Complete the following code to make predictions using
  %%               your learned logistic regression parameters. 
  %%               You should set p to a vector of 0's and 1's
  %%

  p = (X * theta) >= 0;

  %% =========================================================================


end
