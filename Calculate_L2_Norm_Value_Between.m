function [ distance ] = Calculate_L2_Norm_Value_Between(S1, S)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the (No Square Root) euclidean distance between two Matrices.
%
%**** Inputs are two Matrices **** 
%
%   - S1 is the signal (solution) to evaluate.
%
%   - S2 is the baseline signal to measure with.
%
%**** Output is one Value **** 
%
%   - distance is the euclidean distance between the two signals.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D = (S - S1).^2;

sum_res = sum( sum( D ) );

siz = size(S,1) * size(S,2);

distance = sum_res / siz;

end