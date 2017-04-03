function [C, sigma] = dataset3Params(X, y, Xval, yval)
  %%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
  %%where you select the optimal (C, sigma) learning parameters to use for SVM
  %%with RBF kernel
  %%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
  %%   sigma. You should complete this function to return the optimal C and 
  %%   sigma based on a cross-validation set.
  %%

  %% You need to return the following variables correctly.
  C = 1;
  sigma = 0.3;

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Fill in this function to return the optimal C and sigma
  %%               learning parameters found using the cross validation set.
  %%               You can use svmPredict to predict the labels on the cross
  %%               validation set. For example, 
  %%                   predictions = svmPredict(model, Xval);
  %%               will return the predictions on the cross validation set.
  %%
  %%  Note: You can compute the prediction error using 
  %%        mean(double(predictions ~= yval))
  %%

%%  candVals = [0.01, 0.03, 0.1, 0.3, 1, 3. 10, 30];
%%  errorRates = zeros(1, length(candVals) ^ 2);
%%  i = 1;
%%  for C = candVals
%%	for sigma = candVals
%%	  fprintf('# %d\n', i)
%%	  model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
%%	  predictions = svmPredict(model, Xval);
%%	  Cs(i) = C;
%%	  sigmas(i) = sigma;
%%	  errorRates(i) = mean(double(predictions ~= yval));
%%	  i = i + 1;
%%	end
%%  end
%%  for i = 1 : length(candVals) ^ 2
%%	fprintf('C=%f, sigma=%f -> %f\n', Cs(i), sigmas(i), errorRates(i));
%%  end
%%  [errorRateMin, iMin] = min(errorRates);
%%  fprintf('minimum: C=%f, sigma=%f -> %f\n', Cs(iMin), sigmas(iMin), errorRates(iMin));
  
  C = 1;
  sigma = 0.1;

  %% =========================================================================

end
