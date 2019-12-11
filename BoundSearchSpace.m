function Sol = BoundSearchSpace( Sol )
                
    global ProblemSettings

    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax; 
    
    % Brigs Out of Search Space Individuals to the Search Space
    Sol(1) = max(Sol(1),0);
    Sol(1) = min(Sol(1),1);    

    Sol(2:end) = max(Sol(2:end),VarMin);
    Sol(2:end) = min(Sol(2:end),VarMax);      

end

