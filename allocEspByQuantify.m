
%=========================================
% allocation privacy budget at each t for satisfying desired TPL by quantification.
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% a: desired TPL privacy level
% TM_B: backward transition matrix
% TM_F: forward transition matrix
%-----------------outputs-----------------
% the resulting budgets vector's pattern: [e_s, e_mid,...,e_mid,e_end].
% let t be current time point, T be the end time point.
% e_s: privacy budget at t=1
% e_mid: privacy budget at 1<t<T
% e_end: privacy budget at t=T
%=========================================

function [e_s,  e_mid, e_end]=allocEspByQuantify(a, TM_B, TM_F)

[EspMatrix_B, qM_B, dM_B, QDplusInd_B]= preCompQDMatrix(TM_B);
EspMatrix_B(isnan(EspMatrix_B)) = 0;

[EspMatrix_F, qM_F, dM_F, QDplusInd_F]= preCompQDMatrix(TM_F);
EspMatrix_F(isnan(EspMatrix_F)) = 0;

a1=0;
an=a;
[aArrMax_B, qArrMax_B, dArrMax_B] = genLFunc(a1, an, EspMatrix_B, qM_B, dM_B);
[aArrMax_F, qArrMax_F, dArrMax_F] = genLFunc(a1, an, EspMatrix_F, qM_F, dM_F);

% updateTime=0;

% find a_B
bingo = false;
range=a;
a_B=0.5*a;
while ~bingo
%     updateTime=updateTime+1;
    range=range*0.5;
    L_B=calcPLbyFunc(a_B, aArrMax_B, qArrMax_B, dArrMax_B);
    a_F = a-L_B;
    L_F=calcPLbyFunc(a_F, aArrMax_F, qArrMax_F, dArrMax_F);
    if abs(L_F+a_B - a)<eps*10
        bingo = true;
    elseif L_F+a_B < a
        a_B = a_B+range;
    else
        a_B = a_B-range;
    end
end

% updateTime

e_s = a_B;
% e_mid=a_B - L_B;
e_mid=a_B + a_F - a;
e_end = a_F;

end