%_________________________________________________________________________%
% Hybrid Multi-objective Evolutionary Algorithm based on Search Manager
% Framework for Big Data Optimization Problems
% (* Proposed Configurations of Multi-objective Search Manager *)
%                                                                         
%  Developed in MATLAB R2017a                                                                                                                   %
%                                                                                                                        
%                 
%     
%  Author & Programmer: Yousef Abdi
% 
%  e-Mail: y.abdi@tabrizu.ac.ir
%           yousef.abdi@gmail.com
%  https://doi.org/10.1016/j.asoc.2019.105991
%
% Last modified: August 30, 2019
% ******************************
% Big Data probelms have been implemented by Mohammed Amine El-Majdouli,
%     Mohammed V University of Rabat, Morocco.
%_________________________________________________________________________%

clc;
clear;
close all;

[A, S, X] = Load_BigOPT_Instance('D4'); % Load Data Set - D4N, D12, D12N, D19, D19N
row = 4;  % 4 to use D4,D4N - 12 to use D12,DN12 - 19 to use D19,D19N
col = 256;
SIZE = row * col;
%%  Globalization of Parameters and Settings 

global ProblemSettings;
global SM_Settings;
    
nVar=SIZE;   % Number of decision variables        

CostFunction=@(x) Calculate_BigOPT_Objective_Values(x, S, A, X);  %Cost Function

% Bound of Decision Variables
VarMin = -8;
VarMax =  8;

VarSize=[1 nVar];   % Decision Variables Matrix Size

%% SEARCH MANAGER Parameters

MaxIt=4000;         % Maximum Number of Iterations
                    % 4000 for D4 and D4N Problems
                    % 6000 for D12 and D12N Problems
                    % 8000 for D19 and D19N Problems

nPop=49;            % Population Size
nGroup=4;           % Number of Groups     

nStyle=2;           % Number of Optimization Styles that want to be hybridized
L=0.2;
P=1;
%% Initialization
ProblemSettings.CostFunction=CostFunction;
ProblemSettings.nVar=nVar;
ProblemSettings.VarSize=VarSize;
ProblemSettings.VarMin=VarMin;
ProblemSettings.VarMax=VarMax;
ProblemSettings.MaxIt=MaxIt;

SM_Settings.MaxIt=MaxIt;
SM_Settings.nPop=nPop;
SM_Settings.nRep=49;
SM_Settings.nGroup=nGroup;
SM_Settings.nStyle=nStyle;
SM_Settings.L=L;
SM_Settings.W=[];  
SM_Settings.P=P; 
SM_Settings.a_abc=1;
SM_Settings.C_abc=zeros(nPop,1);
SM_Settings.nu=5;
SM_Settings.CC=2;
%%------------------------------------------------
HV=zeros(MaxIt);
    
% Create Initial Structure
Structure=Create_Initial_Stucture(); 

%% Determine Domination & Create Initial Repository
Rep = [];
Structure=DetermineDomination(Structure, 0);
Rep = MakeRepository(Structure, Rep);

PlotCosts2([Rep.Cost]);
SM_Settings.nu=5;

%% Search Manager Main Loop
for it=1:MaxIt                

        SM_Settings.L=(((MaxIt-it)/MaxIt)*0.2);
        SM_Settings.W=((MaxIt-it)/MaxIt);
        SM_Settings.nu=5-3*(it/MaxIt)^2;

        % Movement Operations
        Structure=Movement(Structure, Rep, it);        

        % Dominations ...
        Structure=DetermineDomination(Structure, 0);
        
        % Make Repository
        Rep=MakeRepository(Structure, Rep);            

        HV(it)=approximate_hypervolume_ms([Rep.Cost],[1.01;22.34]);  %Reference POINT is [1.01; 22.34]
        disp(['HV= ' num2str(HV(it)) ' - Iteration: ' num2str(it) ' :  # of Solutions in the Archive = ' num2str(numel(Rep))]);    

        %Plot Costs
        figure(1);
        PlotCosts2([Rep.Cost]);
        pause(0.0001);               

end
