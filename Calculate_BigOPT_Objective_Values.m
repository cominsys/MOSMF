function Objective_Values = Calculate_BigOPT_Objective_Values(S1, S, A, X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the objective values of the Big Optimization Problem.
%
%**** Inputs are two Matrices **** 
%
%   - S1 is the signal (solution) to evaluate.
%
%   - S2 is the baseline signal to measure with.
%
%**** Outputs are two Values **** 
%
%   - First_Objective_Value is the euclidean distance between the two signals.
%
%   - Second_Objective_Value is the correlation between the two signals.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S1 = vec2mat(S1, 256);

First_Objective_Value = Calculate_L2_Norm_Value_Between(S1, S);

X1 = A * S1;

Second_Objective_Value = Calculate_Correlation_Value_Between(X1, X);

Objective_Values=[Second_Objective_Value 
        First_Objective_Value];

end

