%=========================================
% test correctness of calcBPL 
%
% 05-Dec-2017 author: Yang Cao 
%=========================================
addpath('tools/');

clc;
clear;

a=0.1;

% initialize transition matrix
n=30;  
m=abs(normrnd(1,1,n,n));
di=sum(m, 2);
TM=bsxfun(@rdivide, m, di);


%% calc by cplex
tic;
[maxBPL_cplex] = calcPLbyLP(TM,a, 'cplex')
toc;

%% calcPL by theorem 4
tic;
[maxBPL1, ~, ~] = calcPL(TM,a)
toc;


%% calc by precomputation
[EspMatrix, qM, dM, ~]= preCompQDMatrix(TM);
tic;
[maxBPL2, ~, ~] = calcPLbyPreComp(a, EspMatrix, qM, dM)
toc;


%% calc by function L(a)
a1=0;
an=a;
[aArrMax, qArrMax, dArrMax] = genLFunc(a1, an, EspMatrix, qM, dM);
tic;
[maxBPL3] = calcPLbyFunc(a, aArrMax, qArrMax, dArrMax)
toc;



