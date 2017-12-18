% qM, dM, QDplusInd are optional, they can be pre-computed by preCompQDMatrix(TM)

%=========================================
% this function precompute some results that are common for each time point
% w.r.t. the same transition matrix.
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% TM: transition matrix
% e: privacy  budget at each time
% qM: n(n-1)*n matrix, matrix version of "qArr", contains q w.r.t. the corresponding transition point 
% dM: n(n-1)*n matrix, matrix version of "dArr", contains d w.r.t. the corresponding transition point
% QDplusInd: n(n-1)*n matrix, contains 0 or 1 means whether the position exist a transition points
%-----------------outputs-----------------
% maxSup:  supremum of privacy leakage (BPL or FPL)
% q_sup : the value of q w.r.t. such privacy leakage
% d_sup : the value of d w.r.t. such privacy leakage
%=========================================


function [maxSup,q_sup, d_sup]=findSup(TM,e, qM, dM, QDplusInd)

if isempty(qM) || isempty(dM)  || isempty(QDplusInd)
%     cprintf('blue', 'compute qM, dM, QDplusInd now...\n')
    n=size(TM,1);
    pairs=VChooseK(int16(1:n), 2);
    pairs=[pairs; fliplr(pairs)]';
    
    QM=TM(pairs(1,:), :);
    DM=TM(pairs(2,:), :);
    [QMs,DMs]=sortRatioM1M2_DES(QM,DM);
    
    QDplusInd = QMs>DMs;
    qM=cumsum(QMs, 2);
    dM=cumsum(DMs, 2);
%      cprintf('blue', 'compution done.\n')
end

% note that qs and ds will not be the same order as shown in original vector,
% but this doesn't affect the result.
qs=qM(QDplusInd);
ds=dM(QDplusInd);

rNums=numel(qs);

if rNums==0
    maxSup = e;
    q_sup=NaN;
    d_sup=NaN;
else
    maxSup=-1;
    for i=1:rNums
        sup=theorem10(qs(i), ds(i), e);
        if maxSup<sup
            maxSup = sup;
            q_sup = qs(i);
            d_sup = ds(i);
        end
    end
    
end

end