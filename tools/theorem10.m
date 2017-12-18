%=========================================
% this function calculate the upper bound of BPL or FPL by given q,d,e  
% according to Theorem 10 in our TKDE paper.
% 05-Dec-2017 author: Yang Cao 
%-----------------inputs-----------------
% q: the stable value of q when achiving supremum
% d: the stable value of d when achiving supremum
% e: privacy budget at each time point
%-----------------outputs-----------------
% sup: the upper bound of BPL or FPL
%=========================================

function [sup]=theorem10(q,d,e)
if abs(q-d)<eps
    sup=e;
elseif d~=0
    sup=log( ((4*d*exp(e)*(1-q)+(d+q*exp(e)-1)^2)^0.5+d+q*exp(e)-1) /(2*d));
elseif q~=1 && e<=log(1/q)
    sup=log(((1-q)*exp(e))/(1-q*exp(e)));
elseif q~=1 && e>log(1/q)
    sup=Inf;
else
    sup=Inf;
end
end