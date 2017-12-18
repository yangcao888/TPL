
%=========================================
% plot two figures of privacy budget allocation schemes
% for stisfying the desired TPL
% 05-Dec-2017 author: Yang Cao 
%=========================================
addpath('tools/');

clc;
clear;

T=30;

%% initialize random TMs
n=10;
m=abs(normrnd(1,1,n,n));
di=sum(m, 2);
TM_B=bsxfun(@rdivide, m, di);

m=abs(normrnd(2,1,n,n));
di=sum(m, 2);
TM_F=bsxfun(@rdivide, m, di);

%% precomputation
a1=0;
an=100;
[EspMatrix_B, qM_B, dM_B, QDplusInd_B]= preCompQDMatrix(TM_B);
[aArrMax_B, qArrMax_B, dArrMax_B] = genLFunc(a1, an, EspMatrix_B, qM_B, dM_B);

a1=0;
an=100;
[EspMatrix_F, qM_F, dM_F, QDplusInd_F]= preCompQDMatrix(TM_F);
[aArrMax_F, qArrMax_F, dArrMax_F] = genLFunc(a1, an, EspMatrix_F, qM_F, dM_F);


%% alloc budget by upper bound
a=1;
[e]=allocEspByUpperBound(a, TM_B, TM_F);
eArr=ones(1,T)*e;

cprintf('blue', 'alloc budget by upper bound ')
printTPL=1;
plotTPL(eArr, TM_B, TM_F, printTPL);


%% alloc budget by quantification
a=1;
[e_s, e_mid, e_end]=allocEspByQuantify(a, TM_B, TM_F)
eArr_mid=ones(1, T-2)*e_mid;
eArr=[e_s, eArr_mid, e_end];

cprintf('blue', 'alloc budget by quantification ')
printTPL=1;
plotTPL(eArr, TM_B, TM_F, printTPL);





