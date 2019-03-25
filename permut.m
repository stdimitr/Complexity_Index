function   y=permut(x)
% function   y=permut(x)
%  random permutation of the elements of x vector


% v1.2 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index

r=randn(1,x);
[sr,isr]=sort(r);

y=isr;

