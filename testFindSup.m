%=========================================
% test findSup. comparing the results of findSup with the one calculated
% step by step until the BPL (or FPL) is stable.
%
% There are different test cases.
%
% 05-Dec-2017 author: Yang Cao 
%=========================================

addpath('tools/');

%% test case 0 of sup (qArr==dArr)

% n=10;
% m=abs(normrnd(1,1,n,n));
% di=sum(m, 2);
% TM=bsxfun(@rdivide, m, di);
% TM=[TM(1,:); TM(1,:)];
% 
% e=1;

%% test case 1 of sup (q~=0/1 d~=0/1)

n=5;
m=abs(normrnd(1,1,n,n));
di=sum(m, 2);
TM=bsxfun(@rdivide, m, di);

e=0.1;

%% test case 2 of sup  (d==0, e<log(1/q))
% n=50;
% m=abs(normrnd(1,1,n,n));
% di=sum(m, 2);
% TM=bsxfun(@rdivide, m, di);
% 
% TM(1,[1:n-1])=0;
% TM(1,n)=1;
% 
% e=0.001;

%% test case 3 of sup  (d==0, e>=log(1/q))
% n=4;
% m=abs(normrnd(1,1,n,n));
% di=sum(m, 2);
% TM=bsxfun(@rdivide, m, di);
% TM(1,[1:n-2])=0;
% TM(1,n-1)=0.2;
% TM(1,n)=0.8;

% e=0.314;

%% test case 4 of sup  (d==0, q==1)
% n=50;
% m=abs(normrnd(1,1,n,n));
% di=sum(m, 2);
% TM=bsxfun(@rdivide, m, di);
% 
% % with element 0
% TM(1,[1:n-1])=0;
% TM(1,n)=1;
% TM(2,[1:n-2])=0;
% TM(2, n-1)=1;
% TM(2,n)=0;
% 
% e=1;

%% findSup
a1=0;
an=10;
[EspMatrix, qM, dM, QDplusInd]= preCompQDMatrix(TM);
[aArrMax, qArrMax, dArrMax] = genLFunc(a1, an, EspMatrix, qM, dM);

tic;
% [maxSup, q_sup, d_sup] =findSup(TM, e, [], [], [])
[maxSup, q_sup, d_sup] = findSup(TM, e, qM, dM, QDplusInd)
toc;

% maxSup
% q_sup
% d_sup


%%  calc by TM

T=200;

aArr=zeros(1,T);
aArr(1,1) = e;
for i=2:T
%      cprintf('blue',['t=',num2str(i),'\n']);
    [maxBPL, q, d] = calcPLbyFunc(aArr(1,i-1),  aArrMax, qArrMax, dArrMax);
    aArr(1,i) = maxBPL+e;
end

aArr(1,T)
% % hold on
% % plot(aArr)





