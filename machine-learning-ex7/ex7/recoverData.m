function X_rec = recoverData(Z, U, K)
  %%RECOVERDATA Recovers an approximation of the original data when using the 
  %%projected data
  %%   X_rec = RECOVERDATA(Z, U, K) recovers an approximation the 
  %%   original data that has been reduced to K dimensions. It returns the
  %%   approximate reconstruction in X_rec.
  %%

  %% Z = [z_1(1)  z_2(1)  z_K(1)]
  %%     |z_1(2)  z_2(2)  z_K(2)|
  %%     |z_1(3)  z_2(3)  z_K(3)|
  %%     |z_1(4)  z_2(4)  z_K(4)|
  %%     [z_1(5)  z_2(5)  z_K(5)]

  %% X = [x1(1)  x2(1)  x3(1)  x4(1)]
  %%     |x1(2)  x2(2)  x3(2)  x4(2)|
  %%     |x1(3)  x2(3)  x3(3)  x4(3)|
  %%     |x1(4)  x2(4)  x3(4)  x4(4)|
  %%     [x1(5)  x2(5)  x3(5)  x4(5)]

  %% U = [u_1_1  u_1_2  u_1_3  u_1_4]
  %%     |u_2_1  u_2_2  u_2_3  u_2_4]
  %%     [u_3_1  u_3_2  u_3_3  u_3_4]
  %%     [u_4_1  u_4_2  u_4_3  u_4_4]

  %% U(:, 1 : K) = [u_1_1  u_1_2  u_1_K]
  %%               |u_2_1  u_2_2  u_2_K]
  %%               [u_3_1  u_3_2  u_3_K]
  %%               [u_4_1  u_4_2  u_4_K]

  %% You need to return the following variables correctly.
  X_rec = zeros(size(Z, 1), size(U, 1));

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the approximation of the data by projecting back
  %%               onto the original space using the top K eigenvectors in U.
  %%
  %%               For the i-th example Z(i,:), the (approximate)
  %%               recovered data for dimension j is given as follows:
  %%                    v = Z(i, :)';
  %%                    recovered_j = v' * U(j, 1:K)';
  %%
  %%               Notice that U(j, 1:K) is a row vector.
  %%               

  X_rec = Z * U(:, 1 : K)';

  %% =============================================================

end
