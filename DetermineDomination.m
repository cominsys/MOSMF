
function Structure=DetermineDomination(Structure,G)
    if G==0
        nGroup=numel(Structure);    

        for i=1:nGroup        
            for j=1:numel(Structure(i).Group)
                Structure(i).Group(j).IsDominated=false;
            end
        end

        for i=1:nGroup

            Costs=[Structure(i).Group.Cost];
            for j=1:numel(Structure(i).Group)
                y=Structure(i).Group(j).Cost;
                res=find(all(Costs<=y) & any(Costs<y));
                if ~isempty(res)
                    Structure(i).Group(j).IsDominated=true;
                end
            end

        end
    else
        NonDominateCosts=[];
        for j=1:numel(Structure.Group)
            Structure.Group(j).IsDominated=false;
        end
        Costs=[Structure.Group.Cost];
        for j=1:numel(Structure.Group)
            y=Structure.Group(j).Cost;
            res=find(all(Costs<=y) & any(Costs<y));
            if ~isempty(res)
                Structure.Group(j).IsDominated=true;
            end            
        end
        
    end   % IF G=0 

end