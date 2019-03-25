% SequenceToNum: Converts a character matrix of behavioral sequences to numeric, changing 
%         blanks to NaNs.  Returns a numeric matrix unaltered.
%
%     Usage: [sequencesOut,seqConverted] = SequenceToNum(sequencesIn)
%
%         sequencesIn = character or numeric matrix of state sequences.
%         --------------------------------------------------------------------------
%         sequencesOut = original (if numeric) or converted (if character) matrix.
%         seqConverted = boolean flag indicating, if true, that character matrix was
%                          converted to numeric.
%

% v1.0 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index

function [sequencesOut,seqConverted] = sequence_to_num(sequencesIn)

  if (ischar(sequencesIn))
    seqConverted = true;
    [r,c] = find(isin(sequencesIn,' '));    % Find any blanks
    warning off MATLAB:nonIntegerTruncatedInConversionToChar;
    sequencesOut = double(sequencesIn);
    if (~isempty(r))
      for i = 1:length(r)
        sequencesOut(r(i),c(i)) = NaN;
      end;
    end;
  else
    seqConverted = false;
    sequencesOut = sequencesIn;
  end;

  return;
  
