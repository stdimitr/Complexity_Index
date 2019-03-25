% SequenceComplexity: Finds the l (el)-subword complexity (l-subword spectrum) of a single  
%         sequence of integers or character values, which is the number of distinct subwords of 
%         length l.  Total subword complexity is the sum over subword lengths  
%         (Janson, Lonardi & Szpankowski 2004).  Normalizes the complexity measure by
%         dividing by the mean complexity obtained with a set of random equiprobable sequences
%         of the same length, in which the probability of each letter is equal (Rapp 2007).
%         Unnormalized complexity measures can be used to compared sequences of identical length.
%
%     Usage: [complexity,spectrum] = SequenceComplexity(sequence,{noNormalize},{maxSubwordLen},{nIters})
%
%         sequence =       character or numeric vector (length lenSeq) of letters.
%         maxSubwordLen =  optional maximum subword length [default = length(sequence)-1].
%         noNormalize =    optional boolean flag indicating that the complexity measure is
%                            not to be normalized [default = false].
%         nIters =         optional number of randomization iterations for normalization
%                            [default = 200].
%         --------------------------------------------------------------------------------
%         complexity =     total complexity, normalized unless requested not to be.
%         spectrum =       vector (lenSeq x 1) of numbers of distinct subwords of lengths
%                            1 through lenSeq (unnormalized).
%

% v1.0 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis

function [complexity,spectrum,cumWords,spectrumr,cr,cumWordsr] = sequence_to_complexity(sequence,maxSubwordLen,noNormalize,nIters)
  if (~nargin), help SequenceComplexity; return; end;
  
  if (nargin < 2), maxSubwordLen = []; end;
  if (nargin < 3), noNormalize = []; end;
  if (nargin < 4), nIters = []; end;
  
  if (isempty(noNormalize)), noNormalize = false; end;
  if (isempty(nIters)),      nIters = 200; end;
  
  sequence = sequence(:);
  sequence = sequence_to_num(sequence);
  sequence = sequence-min(sequence);
  lenSeq = length(sequence);
  
  [complexity,spectrum,cumWords] = CalcComplexity(sequence,maxSubwordLen); % Observed complexity
  
  cr=zeros(1,nIters);
  spectrumr=cell(1,nIters);
  cumWordsr=cell(1,nIters);
  if (~noNormalize)                                               % Normalized complexity
    nLetters = spectrum(1);
    meanComplexity = 0;
    for iter = 1:nIters
      seq = floor(nLetters*rand(1,lenSeq));
      [c spectr cumWord] = CalcComplexity(seq,maxSubwordLen);
      spectrumr{iter}=spectr;
      cumWordsr{iter}=cumWord;
      meanComplexity = meanComplexity + c/nIters;
      cr(iter)=c;
    end;
    complexity = complexity / meanComplexity;
  end;
  
  return;

% -------------------------------------------------------------------------------------------

function [complexity,spectrum,cumWords] = CalcComplexity(sequence,maxLenWord)
  lenSeq = length(sequence);
  if (nargin<2), maxLenWord = lenSeq-1; end;

  maxLenWord = min([maxLenWord,lenSeq-1]);
  spectrum = ones(maxLenWord,1);
  letters = unique_values(sequence);
  spectrum(1) = length(letters);

  for wordLen = 2:maxLenWord                          % Cycle thru word lengths
    cumWords = [];
    for shift = 0:(wordLen-1)                           % Find all subwords of current length
     nWords = floor((lenSeq-shift)/wordLen);
     if (nWords>0)
      words = reshape(sequence((1+shift):wordLen*nWords+shift),wordLen,nWords)';
      cumWords = [cumWords; words];
     end;
    end;
    cumWords = baseconv(cumWords);                      % Convert each subword to a unique integer
    u = unique_values(cumWords);                         % Find number of unique subwords
    spectrum(wordLen) = length(u);
  end;
  
  complexity = sum(spectrum);
  
  return;
  
