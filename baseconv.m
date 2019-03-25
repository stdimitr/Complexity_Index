% BASECONV: Converts row vectors of integers, representing digits of 
%           non-base-10 numbers, to single decimal equivalents.  
%           Used to encode vectors as single values, for example to efficiently 
%           check for repeated sequences.
%
%     Usage: decvals = baseconv(vect,{base})
%
%           vect =    [n x p] matrix of integers.
%           base =    optional base, greater than the maximum integer in the 
%                       matrix.  If not provided, base = max(max(vect))+1.
%           --------------------------------------------------------------
%           decvals = [n x 1] vector of decimal equivalents.
%

% v1.0 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index

function decvals = baseconv(vect,base)
  if (nargin < 2)
    base = [];
  end;

  if (isempty(base))
    base = max(max(vect))+1;
  end;

  [n,p] = size(vect);

  decvals = vect * [base.^(p-1:-1:0)]';

  return;
