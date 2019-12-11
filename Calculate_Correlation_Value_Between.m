function [ Objective_Value ] = Calculate_Correlation_Value_Between(X1, X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the correlation values between two signals (Matrices).
%
%**** Inputs are two Matrices **** 
%
%   - S1 is the signal (solution) to evaluate.
%
%   - S2 is the baseline signal to measure with.
%
%**** Output is one Value **** 
%
%   - Objective_Value is the correlation between the two signals.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pearson_Correlation_Matrix = Calculate_Pearson_Correlation_Matrix_For(X1, X);

On_Diagonal_Value = Calculate_On_Diagonal_Value( Pearson_Correlation_Matrix );

Off_Diagonal_Value = Calculate_Off_Diagonal_Value( Pearson_Correlation_Matrix );

Objective_Value = On_Diagonal_Value + Off_Diagonal_Value;

end