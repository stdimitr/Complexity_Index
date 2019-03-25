

% Example (1):

  % First we create a data vector.
  data=sin(linspace(0,10));
  % Then we compute delay vector with embedding dimension 2 and delay 10
  Y=embeddelay(data,2,10);
 % Now we can plot the vectors on a 2D space to see the reconstruction of
 % phase space (With only 2 dimensions is not very good, but es can take some information from the system).
  plot(Y(:,1),Y(:,2))
 % If the delay is 15 we can see a circle.
  Y=embeddelay(data,2,15);
  plot(Y(:,1),Y(:,2))
  
  %%%%%%%%%%%%%%%%%%%%%%%%%
  %%% RUN DATA WITH INPUTS:
  %% EMBEDDING DIMENSION = 3, TIME DELAY = 9, NORMALIZATION = 0 & ITERATIONS = 100
  complexity =from_sequence_to_complexity(data,3,9,0,100);