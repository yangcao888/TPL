%=========================================
% This function calculate the incremental privacy leakag, i.e. L(a), by L(a) function. 
%
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% a: the previous BPL or the next FPL
% aArrMax: vector, contains transition points,defines domains on each segment of L(a)
% qArrMax: vector, contains values of q, defines parameters of L(a)
% dArrMax: vector, contains values of d, defines parameters of L(a)
%-----------------outputs-----------------
% maxPL: maximum incremental privacy leakage L(a)
% q,d: two scalars that satisfy Theorem 4 in our TKDE paper
%=========================================

function [maxBPL, q, d] = calcPLbyFunc(a, aArrMax, qArrMax, dArrMax)

% aArrMax = evalin('base', 'aArrMax');
% qArrMax = evalin('base', 'qArrMax');
% dArrMax = evalin('base', 'dArrMax');

if isempty(aArrMax)
    maxBPL = 0;
    q=0;
    d=0;
else
    if a>aArrMax(end)
        error('a should be in the range of aArrMax');
    end
    idx = sum(aArrMax<a)+1;
    q=qArrMax(idx);
    d=dArrMax(idx);
    maxBPL = log( (q*(exp(a)-1)+1)/(d*(exp(a)-1)+1));
    
end



end