
function Rep=CrowdingDistance(Rep)    
    
    % Sort Repository
    tmp=[Rep.Cost];
    [~,ind]=sort(tmp(1,:));
    Rep=Rep(ind);
    
%     Rep(1).CD=100;
%     Rep(end).CD=100;
costs=[Rep.Cost]';
[~,I,~] = unique(costs, 'rows', 'first'); 
Rep=Rep(I);
    if numel(Rep)>=2
%         d1=abs((Rep(2).Cost(1)-Rep(1).Cost(1)));
%         d2=abs((Rep(2).Cost(2)-Rep(1).Cost(2)));
%         d=d1+d2;
        Rep(1).CD=100;
%         d1=abs((Rep(end).Cost(1)-Rep(end-1).Cost(1)));
%         d2=abs((Rep(end).Cost(2)-Rep(end-1).Cost(2)));
%         d=d1+d2;
        Rep(end).CD=100;
    elseif numel(Rep)==1
        Rep(1).CD=100;
    end
    cost=[Rep.Cost];
    fmin=min(cost,[],2);
    fmax=max(cost,[],2);
    for i=2:numel(Rep)-1
        d1=abs((Rep(i-1).Cost(1)-Rep(i+1).Cost(1)))/(fmax(1)-fmin(1));
        d2=abs((Rep(i-1).Cost(2)-Rep(i+1).Cost(2)))/(fmax(2)-fmin(2));
        d=d1+d2;
        Rep(i).CD=d;
    end
        
end