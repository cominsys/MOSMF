function [ pearson_Correlation_Matrix ] = Calculate_Pearson_Correlation_Matrix_For(S1, S2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates the pearson coefficients and return the corresponding pearson
% correlation Matrix.
%
% INPUTS: Two Matrices S1 and S2
%
% OUTPUT: Pearson Correlation Matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(S1, 1)
    
    std_Line_S1 = std( S1(i, :) );
    
    mean_Line_S1 = mean( S1(i, :) );
    
    for j = 1 : size(S2, 1)
       
        std_Line_S2 = std( S2(j, :) );
       
        mean_Line_S2 = mean( S2(j, :) );
        
        correlation_Coefficient(i, j) = 0;
        
        mul_Std = std_Line_S2 * std_Line_S1;
        
        for k = 1 : size(S1, 2)
            
            val_S1 = S1(i, k) - mean_Line_S1;
            
            val_S2 = S2(j, k) - mean_Line_S2;
            
            val = val_S1 * val_S2;
            
            correlation_Coefficient(i,j) = val + correlation_Coefficient(i, j);
        
        end
        
        if abs( mul_Std ) > 0.00000000001
            
            correlation_Coefficient(i, j) = correlation_Coefficient(i, j) / ( size(S1, 2) * mul_Std );
        
        else
            
            correlation_Coefficient(i, j) = 0;
        
        end
        
    end
    
end

pearson_Correlation_Matrix = correlation_Coefficient;

end