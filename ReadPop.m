function out = ReadPop( Structure )
    tempc=[];
    for i=1:numel(Structure)
       tempc=[tempc [Structure(i).Group.Cost]];
    end
    out = tempc;
end

