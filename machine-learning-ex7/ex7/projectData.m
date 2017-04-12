function Z = projectData(X, U, K)
  %%PROJECTDATA Computes the reduced data representation when projecting only 
  %%on to the top k eigenvectors
  %%   Z = projectData(X, U, K) computes the projection of 
  %%   the normalized inputs X into the reduced dimensional space spanned by
  %%   the first K columns of U. It returns the projected examples in Z.
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
  Z = zeros(size(X, 1), K);

  %% ====================== YOUR CODE HERE ======================
  %% Instructions: Compute the projection of the data using only the top K 
  %%               eigenvectors in U (first K columns). 
  %%               For the i-th example X(i,:), the projection on to the k-th 
  %%               eigenvector is given as follows:
  %%                    x = X(i, :)';
  %%                    projection_k = x' * U(:, k);
  %%

  Z = X * U(:, 1 : K);

  %% =============================================================

end
