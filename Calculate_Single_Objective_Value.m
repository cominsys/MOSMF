function single_Objective_Value = Calculate_Single_Objective_Value(candidate_Solution, S, A, X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This conversion from array to matrix is essential because the Genetic Algorithm implemented in
% Matlab uses an array instead of a matrix.
candidate_Solution = vec2mat(candidate_Solution,256);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[F1, F2] = Calculate_BigOPT_Objective_Values(candidate_Solution, S, A, X);
 
single_Objective_Value = F1 + F2;

end

