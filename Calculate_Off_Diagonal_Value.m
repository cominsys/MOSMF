function [ returnValue ] = Calculate_Off_Diagonal_Value( M )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Calculates the Off-Diagonal value of the optimization Objective function.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = 0;

for i = 1 : size(M, 1)
   
    for j = 1 : size(M, 2)
        
        if i ~= j
        
            s = s + M(i, j)^2;
        
        end
        
    end
    
end

returnValue = s / size(M, 1) / (size(M, 1) - 1);

end

