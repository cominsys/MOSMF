function [ A, S, X ] = Load_BigOPT_Instance( instance_Name )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A BigOPT instance loader file is provided.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

formatSpec = '%f';

if strcmpi(instance_Name, 'D4')
    
    fileID = fopen('ProblemData/D4A.txt','r');
    
    sizeA = [4 4];
    
    A = fscanf(fileID,formatSpec,sizeA);
    
    A = A.';
    
    fileID = fopen('ProblemData/D4S.txt','r');
    
    sizeS = [256 4];
    
    S = fscanf(fileID,formatSpec,sizeS);
    
    S = S.';
    
    fileID = fopen('ProblemData/D4X.txt','r');
    
    sizeX = [256 4];
    
    X = fscanf(fileID,formatSpec,sizeX);
    
    X = X.';
    
elseif strcmpi(instance_Name, 'D4N')
        
        fileID = fopen('ProblemData/D4NA.txt','r');
        
        sizeA = [4 4];
        
        A = fscanf(fileID,formatSpec,sizeA);
        
        A = A.';
        
        fileID = fopen('ProblemData/D4NS.txt','r');
        
        sizeS = [256 4];
        
        S = fscanf(fileID,formatSpec,sizeS);
        
        S = S.';
        
        fileID = fopen('ProblemData/D4NX.txt','r');
        
        sizeX = [256 4];
        
        X = fscanf(fileID,formatSpec,sizeX);
        
        X = X.';
        
elseif strcmpi(instance_Name, 'D12')
            
            fileID = fopen('ProblemData/D12A.txt','r');
            
            sizeA = [12 12];
            
            A = fscanf(fileID,formatSpec,sizeA);
            
            A = A.';
            
            fileID = fopen('ProblemData/D12S.txt','r');
            
            sizeS = [256 12];
            
            S = fscanf(fileID,formatSpec,sizeS);
            
            S = S.';
            
            fileID = fopen('ProblemData/D12X.txt','r');
            
            sizeX = [256 12];
            
            X = fscanf(fileID,formatSpec,sizeX);
            
            X = X.';
            
elseif strcmpi(instance_Name, 'D12N')
                
                fileID = fopen('ProblemData/D12NA.txt','r');
                
                sizeA = [12 12];
                
                A = fscanf(fileID,formatSpec,sizeA);
                
                A = A.';
                
                fileID = fopen('ProblemData/D12NS.txt','r');
                
                sizeS = [256 12];
                
                S = fscanf(fileID,formatSpec,sizeS);
                
                S = S.';
                
                fileID = fopen('ProblemData/D12NX.txt','r');
                
                sizeX = [256 12];
                
                X = fscanf(fileID,formatSpec,sizeX);
                
                X = X.';
                
elseif strcmpi(instance_Name, 'D19')
                    
                    fileID = fopen('ProblemData/D19A.txt','r');
                    
                    sizeA = [19 19];
                    
                    A = fscanf(fileID,formatSpec,sizeA);
                    
                    A = A.';
                    
                    fileID = fopen('ProblemData/D19S.txt','r');
                    
                    sizeS = [256 19];
                    
                    S = fscanf(fileID,formatSpec,sizeS);
                    
                    S = S.';
                    
                    fileID = fopen('ProblemData/D19X.txt','r');
                    
                    sizeX = [256 19];
                    
                    X = fscanf(fileID,formatSpec,sizeX);
                    
                    X = X.';
                    
else
                        
                        fileID = fopen('ProblemData/D19NA.txt','r');
                        
                        sizeA = [19 19];
                        
                        A = fscanf(fileID,formatSpec,sizeA);
                        
                        A = A.';
                        
                        fileID = fopen('ProblemData/D19NS.txt','r');
                        
                        sizeS = [256 19];
                        
                        S = fscanf(fileID,formatSpec,sizeS);
                        
                        S = S.';
                        
                        fileID = fopen('ProblemData/D19NX.txt','r');
                        
                        sizeX = [256 19];
                        
                        X = fscanf(fileID,formatSpec,sizeX);
                        
                        X = X.';
                        
end
                    
end


