function [X_norm, mu, sigma] = featureNormalize(X)
  %%FEATURENORMALIZE Normalizes the features in X 
  %%   FEATURENORMALIZE(X) returns a normalized version of X where
  %%   the mean value of each feature is 0 and the standard deviation
  %%   is 1. This is often a good preprocessing step to do when
  %%   working with learning algorithms.

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: First, for each feature dimension, compute the mean
  %%               of the feature and subtract it from the dataset,
  %%               storing the mean value in mu. Next, compute the 
  %%               standard deviation of each feature and divide
  %%               each feature by it's standard deviation, storing
  %%               the standard deviation in sigma. 
  %%
  %%               Note that X is a matrix where each column is a 
  %%               feature and each row is an example. You need 
  %%               to perform the normalization separately for 
  %%               each feature. 
  %%
  %% Hint: You might find the 'mean' and 'std' functions useful.
  %%       
  mu = mean(X)
  sigma = std(X)
  X_norm = (X - mu) ./ sigma

  %% X = [x1(1)  x2(1)]  mu = [mean(x1)  mean(x2)]  sigma = [std(x1)  std(x2)]
  %%     |x1(2)  x2(2)|
  %%     |x1(3)  x2(3)|
  %%     [x1(4)  x2(4)]

  %% ============================================================

end
