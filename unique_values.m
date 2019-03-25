% UniqueValues: Given a matrix containing group labels, returns a vector containing 
%         a list of unique group labels, in the sequence found, and a 
%         vector of corresponding frequencies of each group.  
%         Optionally sorts the indices into ascending sequence.
%
%         Note: it might be necessary to truncate ('de-fuzz') real numbers to 
%         some arbitrary number of decimal positions (see Truncate) before 
%         finding unique values.
%
%     Syntax: [uValues,freqs,indices] = UniqueValues(values,sortFlag)
%
%         values -      matrix of a set of labels.
%         sortFlag -    optional boolean flag indicating that list of labels, and 
%                         corresponding freqsuencies, are to be so sorted 
%                         [default = false].
%         -----------------------------------------------------------------------
%         uValues -     column vector of unique labels.
%         freqs -       corresponding absolute freqsuencies.
%         indices -     indices of the first observation having each value.
%

% v1.0 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index

function [uValues,freqs,indices] = unique_values(values,sortFlag)
  if (nargin < 2), sortFlag = []; end;

  getIndices = false;
  if (nargout > 2), getIndices = true; end;
  if (isempty(sortFlag)), sortFlag = false; end;
  
  if (isempty(values))
    uValues = [];
    freqs = [];
    indices = [];
    return;
  end;

  tol = eps*10.^6;
  values = values(:);                           % Convert input matrix to vector

  if (getIndices)                               % Create vector of indices
    ind = (1:length(values))';
  end;

  if (any(~isfinite(values)))                   % Remove NaN's and infinite values
    i = find(~isfinite(values));                %   from input vector and index vector
    values(i) = [];
    if (getIndices)                     
      ind(i) = [];
    end;
  end;

  uValues = [];
  freqs = [];

  for i = 1:length(values)                      % For each element of values,
    b = (abs(uValues-values(i)) < tol);         %   check if already in value list
    if (sum(b) > 0)                             % If so,
      freqs(b) = freqs(b) + 1;                  %   increment freqsuency counter
    else                                        % If not,
      uValues = [uValues; values(i)];           %   add to value list
      freqs =  [freqs; 1];                      %   and initialize freqsuency counter
    end;
  end;

  if (sortFlag)
    [uValues,i] = sort(uValues);
    freqs = freqs(i);
  end;

  if (getIndices)
    nval = length(uValues);                     % Number of unique values
    indices = zeros(nval,1);                    % Allocate vector of indices
    for v = 1:nval                              % For each unique value,
      i = find(values == uValues(v));           %   Find observations having value
      indices(v) = ind(i(1));                   %   Save first
    end;
  end;

  return;

