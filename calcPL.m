%=========================================
% This function calculate the incremental privacy leakag, i.e. L(a), by Theorem 4 and Corollary 2 (in our TKDE paper). 
% note1: this function only calc L(a), while BPL or FPL = L(a)+ eps_t.
% note2: some precision problem  could happen when a is large (e.g. a>30,
% because exp(a)),but calcBPLbyPreComp.m and calcBPLbyFunc.m is robust to precision problem
% 04-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% TM: transition matrix
% a: previouts BPL or the next FPL
%-----------------outputs-----------------
% maxPL: maximum incremental privacy leakage L(a)
% q,d: two scalars that satisfy Theorem 4 in our TKDE paper
%=========================================


function [maxPL, q, d]=calcPL(TM, a)
% transition matrix M, previous BPL a
% s=tic;

n=size(TM,1);
pairs=VChooseK(int16(1:n), 2);
pairs=[pairs; fliplr(pairs)]';

QM=TM(pairs(1,:), :);
DM=TM(pairs(2,:), :);
% [QM, DM]=sortRatioM1M2_DES(QM,DM);


QDplusInd = QM>DM;
QM=QM.*QDplusInd;
DM=DM.*QDplusInd;

update = true;
while update
    sizeRemain = sum(sum(QDplusInd));
    valArr =  (sum(QM, 2).*(exp(a)-1)+1)./(sum(DM,2).*(exp(a)-1)+1);
    QDplusIndNew = QM./DM>valArr;
    if sizeRemain == sum(sum(QDplusIndNew))
        update = false;
    else
        idx=find(QDplusIndNew~=QDplusInd);
        QM(idx)=0;
        DM(idx)=0;
        QDplusInd = QDplusIndNew;      
    end
end


[maxVal, I]=max(valArr);
maxPL= log(maxVal);

qArr=sum(QM, 2);
q=qArr(I);

dArr=sum(DM, 2);
d=dArr(I);


% runtime=toc(s);

end