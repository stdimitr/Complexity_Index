function Y=embeddelay(data,embed_dimen,delta)
%get_delay_vector Creates delay vector from a data letting user to pick embedding
% dimension and delay.
% This could be used with Takens theorem to reconstruct dynamical system
% state space [1] [2] [3].
% 
%  We have a data set {x_1,x_2,x_3,...,x_N} and want to construct the delay
%  vectors X(n)=(x_n,x_n-delta,x_n-2*delta,...,x_n-(embed_dimen-1)*delta).
% 
% INPUTS: 
%        data = this is a vector with data from a dynamical system
%        embed_dimen = this is the dimension we are using to embed data
%        delta = this is the delay between data.    
%
%
% OUTPUTS: 
%        Y = this is a matrix where row n is the vector X(n)
%       
%
% Example (1):
%
%   % First we create a data vector.
%   data=sin(linspace(0,10));
%   % Then we compute delay vector with embedding dimension 2 and delay 10
%   Y=get_delay_vector(data,2,10);
%  % Now we can plot the vectors on a 2D space to see the reconstruction of
%  % phase space (With only 2 dimensions is not very good, but es can take some information from the system).
%   plot(Y(:,1),Y(:,2))
%  % If the delay is 15 we can see a circle.
%   Y=get_delay_vector(data,2,15);
%   plot(Y(:,1),Y(:,2))

%% v1.0 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
data_size=size(data);
%First we turn data into a row vector.
if data_size(1)<data_size(2)
    data=data';
end
 
%Then we create a matrix  with circular shift that has our delayed vectors
%and some extra vectors that we don't need
data_size=size(data);
Z=zeros(data_size(1),embed_dimen);
 
 
for i=1:embed_dimen      
    Z(:,i)=circshift(data,[(i-1)*delta,0]);     
end
 
%The extra vectors are erased and the final result is the delays vectors
%with delay delta and embedding dimension emb_dimen
Y=Z(delta*embed_dimen-1:end,:);

