%=========================================
% this function precompute some results that are common for each time point
% w.r.t. the same transition matrix.
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% TM: transition matrix
%-----------------outputs-----------------
% EspMatrix: n(n-1)*n matrix,  matrix version of "aArr", contains transition points. EspMatrix = [\alpha_1, ...,  \alpha_{k-1},NaN,..]
% qM: n(n-1)*n matrix, matrix version of "qArr", contains q w.r.t. the corresponding transition point 
% dM: n(n-1)*n matrix, matrix version of "dArr", contains d w.r.t. the corresponding transition point
% QDplusInd: n(n-1)*n matrix, contains 0 or 1 means whether the position exist a transition points
%=========================================

function [EspMatrix, qM, dM, QDplusInd]= preCompQDMatrix(TM)

n=size(TM,1);
pairs=[VChooseK(int16(1:n), 2); fliplr(VChooseK(int16(1:n), 2))]';

QM=TM(pairs(1,:), :);
DM=TM(pairs(2,:), :);
[QM, DM]=sortRatioM1M2_DES(QM,DM);
QDplusInd = QM>DM;
QM=QM.*QDplusInd;
DM=DM.*QDplusInd;

qM=cumsum(QM, 2);
dM=cumsum(DM, 2);

qM=qM.*QDplusInd;
dM=dM.*QDplusInd;
 
EspMatrix=log( (QM-DM)./ ( qM.*DM - QM.*dM ) +1);

% if q==d
% all(all(isnan(EspMatrix))) will be 1

end