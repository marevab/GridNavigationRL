function [epsilon] = explo_proba_3(k)

%
% This method enables to compute the exploration probability (or learning
% rate) at a given state k.
%   k : step
% Returns : 
%   epsilon : exploration probability
%

epsilon = (1 + log(k)) / k;

end