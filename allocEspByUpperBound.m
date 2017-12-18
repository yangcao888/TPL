%=========================================
% allocation privacy budget at each t for satisfying desired TPL by calculating upper bound.
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% a: desired TPL privacy level
% TM_B: backward transition matrix
% TM_F: forward transition matrix
%-----------------outputs-----------------
% e: allocated privacy budget at every time points
%=========================================


function [e]=allocEspByUpperBound(a, TM_B, TM_F)

[~,qM_B, dM_B, QDplusInd_B]= preCompQDMatrix(TM_B);
[~, qM_F, dM_F, QDplusInd_F]= preCompQDMatrix(TM_F);

% updateTime=0;
% find a_B
bingo = false;
range=a;
e=0.5*a;
while ~bingo
%     updateTime=updateTime+1;
    range=range*0.5;
    
    [sup_B,~, ~]=findSup(TM_B, e, qM_B, dM_B, QDplusInd_B);
    [sup_F,~, ~]=findSup(TM_F, e, qM_F, dM_F, QDplusInd_F);
    
    
    if abs(sup_B + sup_F - e - a)<eps*10
        bingo = true;
    elseif sup_B + sup_F -e > a
        e = e-range;
    else
        e = e+range;
    end
end

% updateTime

end