%% /////////////////////////////////////////////////////////////
% Which algorithms are selected for hybridization, the switch statement in 
% this function (Movement.m) should be numbered iteratively - 1 to nStyle -

% exp, if you want to hybridize three solution generation methods (nStyle = 3)
% the switch statement should have three cases and each case instruction
% set implements the specified solution generation method.

% exp, for hybridizing SinCosin and PSO algorithms (nStyle = 2):
% change the case numbers to 1 and 2 in lines 45 and 182 respectively,
%% /////////////////////////////////////////////////////////////

function Structure=Movement(Structure, Rep, it)
    
    global ProblemSettings
    global SM_Settings 
    CostFunction=ProblemSettings.CostFunction;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    MaxIt=ProblemSettings.MaxIt;
    nVar=ProblemSettings.nVar;
    VarMax=ProblemSettings.VarMax;  
    L=SM_Settings.L;
    W=SM_Settings.W;    
    nGroup=numel(Structure); 
    
    for i=1:nGroup
        RepMat=[];
        for k=1:numel(Rep)
           RepMat(k,:)=Rep(k).Decision; 
        end
        % Get the Group Style Vector
        Style=Structure(i).Style;

        % Compute Probability Vector for i'th Group Style Vector
        P=exp(-Style/sum(Style));
        P=1-P;
        P=P/sum(P);
        % Select one of the Groups based on the Probability Vector
        % and Roulette Wheel Selection Method
        Selected_Style=RouletteWheelSelection(P);%
        
        switch Selected_Style
            
            case 100  % SinCosin Algorithm
                              
               a = SM_Settings.a_s;
               for j=1:numel(Structure(i).Group)
                    
                    rep_ind=randi(numel(Rep)); 
                    rd=randi(2);
                    if rd==2
                        mm=Rep(1).Decision;
                    else
                        mm=Rep(end).Decision;
                    end
                    
                    r1=a-it*((a)/MaxIt); % r1 decreases linearly from a to 0
                    if r1<0
                        r1=0;
                    end
                    r2=(2*pi)*rand();
                    r3=2*rand;
                    r4=rand();

                    if r4<=0.5
                        newSol= Structure(i).Group(j).Decision+r1*(sin(r2)*abs(r3*mm - ...
                            Structure(i).Group(j).Decision));
                    else                      
                        newSol= Structure(i).Group(j).Decision+r1*(cos(r2)*(r3*mm - ...
                            Structure(i).Group(j).Decision));
                    end
                    newSol = BoundSearchSpace(newSol);
                    newCost=CostFunction(newSol);
                    Structure(i).Group(j).Decision = newSol;
                    Structure(i).Group(j).Cost = newCost;
      
               end                                                                    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
            case 200 % CMX Crossover Operator
                
                for j=1:numel(Structure(i).Group)                    
                    
                    if randi(2)==1
                        rep_ind=1;%
                    else
                        rep_ind=numel(Rep);%
                    end
                    rep_ind2=randi(numel(Rep));
                    Gind=randi(numel(Structure));
                    
                    ind=randi(numel(Structure(Gind).Group));

                    m=1/3*(Rep(rep_ind).Decision+Rep(rep_ind2).Decision+Structure(Gind).Group(ind).Decision);
                    xv=2*m-Structure(i).Group(j).Decision;
                    alpha=rand(VarSize);
                    y1.Decision=zeros(1,nVar);
                    y1.Decision=alpha.*(xv-Structure(i).Group(j).Decision)+...
                             Structure(i).Group(j).Decision;                 

                    y1.Decision=BoundSearchSpace(y1.Decision);                    
                    y1.Cost=CostFunction(y1.Decision);                    
                                                                        
                    Structure(i).Group(j).Decision=y1.Decision;
                    Structure(i).Group(j).Cost=y1.Cost;   
                                   
                end                                
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 2 % SBX Crossover Operator                

                if SM_Settings.nu<=1
                    SM_Settings.nu=1;
                end
                nu=SM_Settings.nu;

                for j=1:numel(Structure(i).Group)
                    rep_ind=randi(numel(Structure));
                    zz=randi(numel(Structure(rep_ind).Group));                    

                    y1.Decision=zeros(1,nVar);
                    y2.Decision=zeros(1,nVar);
                    
                    for kk=1:nVar
                        u=rand;
                        if u<=0.5
                            beta(kk)=(2*u)^(1/(nu+1));
                        else
                            beta(kk)=(1/(2*(1-u)))^(1/(nu+1));
                        end
                    end
                        ind=randi(numel(Structure(i).Group(j)));                
                        mm=1/3*(Rep(1).Decision+ Rep(end).Decision+Structure(rep_ind).Group(zz).Decision);

                        y1.Decision=0.5*((1+beta).*mm+(1-beta).*...
                            Structure(i).Group(j).Decision);
                        y2.Decision=0.5*((1-beta).*mm+(1+beta).*...
                            Structure(i).Group(j).Decision);
                    
                    y1.Cost=CostFunction(y1.Decision);
                    y2.Cost=CostFunction(y2.Decision); 
                    y=[];
                    if  Dominates(y1.Cost, y2.Cost)                        
                        y.Decision=y1.Decision;
                        y.Cost=y1.Cost;                         
                    elseif  Dominates(y2.Cost, y1.Cost)
                        y.Decision=y2.Decision;
                        y.Cost=y2.Cost;   
                    else 
                        y.Decision=Structure(i).Group(j).Decision;
                        y.Cost=Structure(i).Group(j).Cost;  
                    end

                    Structure(i).Group(j).Decision=y.Decision;
                    Structure(i).Group(j).Cost=y.Cost;
                                       
                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 400 %ICA Assimilation Operator                   
              
                for j=1:numel(Structure(i).Group)
                                         
                    if randi(2)==1
                        sel=1;
                    else
                        sel=numel(Rep);
                    end

                    temp.Decision  = Structure(i).Group(j).Decision+ ...
                         2*rand(VarSize).*(Rep(sel,:).Decision-Structure(i).Group(j).Decision); 
                    temp.Decision = BoundSearchSpace(temp.Decision);
                    temp.Cost=CostFunction(temp.Decision);

                    Structure(i).Group(j).Decision=temp.Decision;
                    Structure(i).Group(j).Cost=temp.Cost;                    
                    
                end  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            case 1  %  PSO Algorithm
                               
                for j=1:numel(Structure(i).Group)
                    
                    CC=SM_Settings.CC;                    
                    if rand<=0.5
                        rep_ind=1;
                    else
                        rep_ind=numel(Rep);
                    end
                    SM_Settings.CC=2.5-(2)*(it/MaxIt)^4;
                    CC2=2.5-2*(it/MaxIt)^4;
                    Structure(i).Group(j).Velocity = W*Structure(i).Group(j).Velocity ...
                    +CC*rand(VarSize).*(Structure(i).Group(j).BestP-Structure(i).Group(j).Decision) ...
                    +CC2*rand(VarSize).*(Rep(rep_ind).Decision-Structure(i).Group(j).Decision);
        
                    % Apply Velocity Limits
                    Structure(i).Group(j).Velocity = max(Structure(i).Group(j).Velocity,VarMin);
                    Structure(i).Group(j).Velocity = min(Structure(i).Group(j).Velocity,VarMax);

                    % Update Position
                    Structure(i).Group(j).Decision = Structure(i).Group(j).Decision + Structure(i).Group(j).Velocity;

                    % Velocity Mirror Effect
                    IsOutside=( Structure(i).Group(j).Decision<VarMin |  Structure(i).Group(j).Decision>VarMax);
                    Structure(i).Group(j).Velocity(IsOutside)=-Structure(i).Group(j).Velocity(IsOutside);

                    % Apply Position Limits
                    Structure(i).Group(j).Decision = max(Structure(i).Group(j).Decision,VarMin);
                    Structure(i).Group(j).Decision = min(Structure(i).Group(j).Decision,VarMax);

                    % Evaluation
                    Structure(i).Group(j).Cost = CostFunction(Structure(i).Group(j).Decision);

                    % Update Personal Best
                    if Dominates(Structure(i).Group(j).Cost,Structure(i).Group(j).BestC)

                        Structure(i).Group(j).BestP=Structure(i).Group(j).Decision;
                        Structure(i).Group(j).BestC=Structure(i).Group(j).Cost;

                    end
                    
                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 600 %Mutation Operator
                
                  nPop=numel(Structure(i).Group);                
%                 %%%%%%%%%%%%%%%%%%GAUSSIAN MUTATION%%%%%%%%%%%%%%%%                 
                  for j=1:nPop    %OK
                     if  rand<L
                         sel=randi(nVar,1,randi(nVar));
                         newsol=unifrnd(VarMin,VarMax,VarSize);
                         Structure(i).Group(j).Decision(sel)=newsol(sel);
                         Structure(i).Group(j).Cost=CostFunction(Structure(i).Group(j).Decision);
                     end
                   end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            case 700 %BAT Algorithm
                                                
                Qmin=0;
                Qmax=1;
                BATr=0.8;
                y=[];
                y.Decision=[];
                sigma=0.05*(VarMax-VarMin);
                for j=1:numel(Structure(i).Group)
%                   if(ismember(Structure(i).Group(j).Decision,RepMat,'rows'))
%                        continue;
%                   end
                  k1=randi(numel(Structure));
                  k2=randi(numel(Structure(k1)));
                  y.Decision=Structure(i).Group(j).Decision;
                  rep_ind=randi(numel(Rep));
                  rep_ind2=randsample([1, numel(Rep)],1);
                  Q=Qmin+(Qmax-Qmin)*rand;
                  if rand>=0.75
                      mm=((Rep(end).Decision)-Structure(i).Group(j).Decision);
                  else                      
                      mm=((Rep(1).Decision)-Structure(i).Group(j).Decision);
                  end
                  
                  Structure(i).Group(j).Velocity=rand*Structure(i).Group(j).Velocity+Q*mm;
                  
                  y.Decision=Structure(i).Group(j).Decision+Structure(i).Group(j).Velocity;
                                                  
                  % Pulse rate  r decresing
                  if rand<L
                     mu=0.1;
                     nMu=ceil(mu*nVar);
                     kk=randsample(nVar,nMu);
                     y.Decision(kk)=Structure(i).Group(j).Decision(kk)+...
                         sigma.*randn(size(kk'));
                  end
                  y.Decision=BoundSearchSpace(y.Decision);  
                  y.Cost=CostFunction(y.Decision);

                  if  (rand<0.9) 
                        Structure(i).Group(j).Decision=y.Decision;
                        Structure(i).Group(j).Cost=y.Cost;
                  end
                                       
                end  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 800  %WOA Algorithm
                a=4-it*((4)/MaxIt);
                a2=-1+it*((-1)/MaxIt);  
                for j=1:numel(Structure(i).Group)
                    r1=rand(); % r1 is a random number in [0,1]
                    r2=rand(); % r2 is a random number in [0,1]

                    A=4*a*r1-a;  
                    C=4*r2;     
                    b=1;               
                    l=(a2-1)*rand+1;   

                    p = rand();     

                    if randi(2)==1
                        rep_ind=1;%
                    else
                        rep_ind=numel(Rep);%
                    end
                    rep_ind2=randi(numel(Rep));

                    if p<0.5   
                        if abs(A)>=1
                            D_X_rand=abs(C*Rep(rep_ind2).Decision-Structure(i).Group(j).Decision); 
                            Structure(i).Group(j).Decision=Rep(rep_ind2).Decision-A*D_X_rand;     

                        elseif abs(A)<1
                            D_Leader=abs(C*Rep(rep_ind2).Decision-Structure(i).Group(j).Decision); 
                            Structure(i).Group(j).Decision=Rep(rep_ind2).Decision-A*D_Leader;     
                        end

                    elseif p>=0.5

                        distance2Leader=abs(Rep(rep_ind2).Decision-Structure(i).Group(j).Decision);
                        Structure(i).Group(j).Decision=distance2Leader*exp(b.*l).*cos(l.*2*pi)+Rep(rep_ind2).Decision;

                    end
                    Structure(i).Group(j).Decision = max(Structure(i).Group(j).Decision,VarMin);
                    Structure(i).Group(j).Decision = min(Structure(i).Group(j).Decision,VarMax);

                    Structure(i).Group(j).Cost = CostFunction(Structure(i).Group(j).Decision);

                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 900 %MFO
                a=-1-it*((1/MaxIt));                
                if rand<=0.5
                   ind=1; 
                else
                   ind=numel(Rep);
                end
                Flame_no=round(numel(Structure(i).Group)-it*((numel(Structure(i).Group)-1)/MaxIt));
                newsol=Structure(i).Group(1);
                for j=1:numel(Structure(i).Group)

                       if j<=Flame_no
                           distance_to_flame=(Rep(ind).Decision-Structure(i).Group(j).Decision);
                           b=1;
                           t=(a-1)*rand+1;
                           newsol.Decision=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+Rep(ind).Decision;                           
                       end
                       if j>Flame_no
                           distance_to_flame=(Rep(ind).Decision-Structure(i).Group(j).Decision);
                           b=1;
                           t=(a-1)*rand+1;
                           newsol.Decision=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+Rep(ind).Decision;
                       end

                    newsol.Decision = max(newsol.Decision, VarMin);
                    newsol.Decision = min(newsol.Decision, VarMax);
                    newsol.Cost=CostFunction(newsol.Decision);

                    Structure(i).Group(j).Decision=newsol.Decision;
                    Structure(i).Group(j).Cost=newsol.Cost;

                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 1000  % HTS Algorithm
                % Can be requested from its author 
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            case 1100  % Trader Algorithm
                % Can be requested from its author 			
                
                
                
        end  %END OF SWITCH

            Structure(i)=DetermineDomination(Structure(i), 1);
            Rep=MakeRepository(Structure, Rep);        
            % Update Group Costs for i'th Group
            Structure=Update_Group_Cost(Structure, i);  
            % Update Style Vector of the Group
            Structure(i)=Update_Style(Structure(i), Selected_Style);
    
    end  % End of for 
    
end  %End of function