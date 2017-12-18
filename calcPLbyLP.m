%=========================================
% this function calculate the incremental privacy leakag, i.e. L(a), by Linear
% programming. note that this function only calc L(a), while BPL or FPL = L(a)+ eps_t 
%-----------------inputs-----------------
% TM: transition matrix
% a: previouts BPL or the next FPL
% method: string, 'gurobi' or 'cplex', or 'matlab'. 
%         gurobi works for ONLY matlab2016b, prolematic for matlab2017b
%-----------------outputs-----------------
% maxPL: maximum incremental privacy leakage L(a)
% maxPL_ij: 2*1 array, ith row is the q vector, jth row is the d vector
%=========================================


function [maxPL, maxPL_ij]=calcPLbyLP(TM, a, method)

n=size(TM,2);
maxPL=-1;
maxPL_ij=[];

pairs=VChooseK(int16(1:n), 2);
pairs=[pairs; fliplr(pairs)];

for eachPair=pairs'
    v1=TM(eachPair(1),:);
    v2=TM(eachPair(2),:);
    if strcmp(method,'cplex')
        [bpl, x] =calcPLbyLP_cplex(v1,v2, a);
    elseif strcmp(method,'gurobi')
        [bpl, x] =calcPLbyLP_gu(v1,v2, a);
    elseif strcmp(method,'matlab')
        [bpl, x] =calcPLbyLP_matlab(v1,v2, a);
    end
    
    if maxPL<bpl
        maxPL = bpl;
        maxPL_ij=eachPair;
    end
end


end