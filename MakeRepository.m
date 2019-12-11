
function Rep=MakeRepository(Structure, Rep)
    
    global SM_Settings;
    nRep = SM_Settings.nRep;

    nGroup=numel(Structure);    
    Temp_Rep=[];
    
    for i=1:nGroup                                    
            Temp_Rep=[Temp_Rep
                Structure(i).Group(~[Structure(i).Group.IsDominated])];                
    end
    Temp_Rep=[Temp_Rep
        Rep];
    Costs=[Temp_Rep.Cost]; 
    for i=1:numel(Temp_Rep)
        y=Temp_Rep(i).Cost;
        res=find(all(Costs<=y) & any(Costs<y));

        if ~isempty(res)
                Temp_Rep(i).IsDominated=true;
        end        
        
    end
    Rep=Temp_Rep(~[Temp_Rep.IsDominated]);
     
    Rep=CrowdingDistance(Rep);
    if size(Rep,1)>nRep        
        DelSize=size(Rep,1)-nRep;
        cds = [Rep.CD];
        P=exp(cds/sum(cds));
        P=P/sum(P); 
        sel=[];
        while numel(sel)~=DelSize  
            [~,index]=min(cds);
            sel=[sel index];
            cds(index)=1000;                
        end
        Rep(sel,:)=[];
        Rep=CrowdingDistance(Rep);
    end            

end