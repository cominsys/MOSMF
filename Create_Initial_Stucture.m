
function Structure=Create_Initial_Stucture()

    global ProblemSettings
    global SM_Settings
    
    CostFunction=ProblemSettings.CostFunction;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
    nStyle=SM_Settings.nStyle;
    nPop=SM_Settings.nPop;
    nGroup=SM_Settings.nGroup;
    
    candidate_solution.Decision=[];
    candidate_solution.Cost=[];
    candidate_solution.IsDominated=false;    
    candidate_solution.CD=0; 
    candidate_solution.Velocity=[];
    candidate_solution.BestP=[];
    candidate_solution.BestC=[];
      
    sol=repmat(candidate_solution,nPop,1);
    
    % Create Initial Candidate Solutions in sol Matrix
    for i=1:nPop

        sol(i).Decision=unifrnd(VarMin,VarMax,VarSize);
        
        sol(i).Velocity=zeros(VarSize);
        sol(i).BestP=sol(i).Decision;
        
        sol(i).Cost=CostFunction(sol(i).Decision);
        sol(i).BestC=sol(i).Cost;
                
    end
    
    %% Remove the Best individual from sol Matrix
    Solutions=sol;
    
    %% Create the Population Struct
    Structure.Group=repmat(candidate_solution,0,1);
    Structure.Style=[];
    Structure.CurrentGroupCost=[];
    Structure.PrevGroupCost=[];
    Structure.BestGroupCost=[];
    
    
    Structure=repmat(Structure,nGroup,1);
    
    %% Distributes Individuals to Population Groups
    for j=1:numel(Solutions)               
        
        sec_ind=rem(j,nGroup)+1;
        Structure(sec_ind).Group=[Structure(sec_ind).Group
                                    Solutions(j)];
    end
    
    %% Set Initial Value for Style Vectors in Each Population Group
    for i=1:numel(Structure)   
            Structure(i).Style=ones(1, nStyle);
    end
    
    %% Compute Cost for Each Population Group
    Structure=Update_Group_Cost(Structure, 0);

end % End of Function