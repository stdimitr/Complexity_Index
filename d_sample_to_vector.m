function  y=d_sample_to_vector(X,Y)

% distance=d_sample_to_vector(sample,vector)
% distances (squarred euclidean to a reference-vector)

% v1.2 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index

[m,n]=size(X);


y= diag([X-ones(m,1)*Y]*[X-ones(m,1)*Y]');