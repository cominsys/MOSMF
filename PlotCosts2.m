
function PlotCosts2(rep)
    
    figure(1);
    
    rep_costs=rep;

    plot(rep_costs(1,:),rep_costs(2,:),'bo');
    hold on;

    xlabel('F_1');
    ylabel('F_2');
    
    hold off;

end