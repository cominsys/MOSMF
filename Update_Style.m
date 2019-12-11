%% This Function Updates Style Vector For A GROUP
function Structure=Update_Style(Structure, Applied_Style_ID)   
        
    global SM_Settings;
    nStyle=SM_Settings.nStyle;            
    MaxIt=SM_Settings.MaxIt;
    Others=1:nStyle;
    Others(Applied_Style_ID)=[];
    
    %%% RATING MECHANISM For MOVEMENT STYLE 
    if(nStyle<=1)
        Structure.Style(Applied_Style_ID)=Structure.Style(Applied_Style_ID)+0.0001;
        return;
    end
    if (IsDominated(Structure.CurrentGroupCost, Structure.PrevGroupCost )) 
        
        Structure.Style(Applied_Style_ID)=Structure.Style(Applied_Style_ID)+1;                
        
    else
        
        Structure.Style(Applied_Style_ID)=1;  
        Structure.Style(Others)=Structure.Style(Others)+1;

    end
    
    %%% -----------------
end