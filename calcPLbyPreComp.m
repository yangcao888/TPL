%=========================================
% this function calculate the incremental privacy leakag, i.e. L(a), by
% pre-computating the common results
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% EspMatrix: n(n-1)*n matrix, contains transition points
% qM: n(n-1)*n matrix, contains q w.r.t. the corresponding transition point
% dM: n(n-1)*n matrix, contains d w.r.t. the corresponding transition point
%-----------------outputs-----------------
% maxPL: maximum incremental privacy leakage
% q,d: the ones satisfying theorem 4 in our ICDE/TKDE paper.
%=========================================

function [maxPL, q, d]=calcPLbyPreComp(a, EspMatrix, qM, dM)
% s=tic;

qdIdx=EspMatrix>a;
jA = sum(qdIdx, 2);
rLen = size(EspMatrix, 1);
iA=(1:rLen)';
id= (jA-1).*rLen + iA;
id=id(id>0); % in case q==d
qArr=qM(id);
dArr=dM(id);


bplArr = log( (qArr.*(exp(a)-1) + 1)./(dArr.*(exp(a)-1) + 1));
[maxPL, idx] = max(bplArr);
q=qArr(idx);
d=dArr(idx);


% runtime=toc(s);
end