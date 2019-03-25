function complexity =from_sequence_to_complexity(ts,m,tau,normalize,iters)


%%%%% INPUT : 
%%%%%         ts = time series 1 x n where denotes the number of samples
%%%%%          m = embedding dimension
%%%%%        tau = time delay
%%%%%  normalize = 0 for normalization 1 for unnormalized
%%%%%%%    iters = no of surrogates important for normalization
%%%%% OUTPUT:
%%%tv_complexity = the complexity index



% v1.0 Dimitriadis Stavros 15/4/2014
% Email: stidimitriadis@gmail.com / DimitriadisS@cardiff.ac.uk
% Webpage:https://www.researchgate.net/profile/Stavros_Dimitriadis
% GITHUB : https://github.com/stdimitr/Complexity_Index

samples=length(ts);


 [ex] = embeddelay(ts, m, tau);
[d1 d2]=size(ex);


error=zeros(1,20);

for k=1:20
    [prototypes,sequence,Average_Error,Convergence_Index]=Vector_Quantization(ex,k,5);
    error(k)=Average_Error;
end


[val idx]=max(diff(error));
[prototypes,sequence,Average_Error,Convergence_Index]=Vector_Quantization(ex,idx,5);


%%complexity
[ci,spectrum,cumWords] = sequence_to_complexity(sequence,7,normalize,iters);

complexity=0;
complexity=ci;
   
     




