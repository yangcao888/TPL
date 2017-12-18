
%% NOTE: Gurobi 7.5/7.0 is runable only for Matlab 2016b or former
% can be also used for calculate FPL
% some precision problem could happen when  a is large (e.g. a>30)
% calcBPLbyPreComp.m and calcBPLbyFunc.m have no precision problem

%% can be also used for calculate FPL
function [bpl,x]=calcBPLbyLP_gu(Q,D, a)
n=size(Q,2);
m=n*(n-1)/2;

% constraints  exp(-a)<=yi/yj<=exp(a); D'*yi = 1;
row=repmat(1:2*m,2,1);
row=[row(:); 2*m+ones(n,1)];
col=nchoosek(1:n,2)';
col=[col(:); col(:); (1:n)'];
val=[repmat([-exp(a); 1],m,1) ; repmat([1; -exp(a)],m,1); D'];

% % constraints -y_i<0; y_i<1
% row=[row; 2*m+1+(1:2*n)'];
% col=[col; (1:n)'; (1:n)'];
% val=[val;-1*ones(n,1); ones(n,1)];

A=sparse(row,col,val);


clear model;
model.A = A;
model.obj = Q;
rhs =  [zeros(2*m, 1); 1];
% rhs = [rhs; zeros(n,1); 10000*ones(n,1)]; % constraints -y_i<0; y_i<1
model.rhs =rhs;
sense = [repmat('<', 1, 2*m), '=']; % TODO why not <=?
% sense = [sense, repmat('<', 1, 2*n)]; % constraints -y_i<0; y_i<1
model.sense = sense; 
% model.vtype = 'C';
model.modelsense = 'max';

% http://www.gurobi.com/documentation/7.5/refman/parameters.html#sec:Parameters
clear params;
params.method = -1; % auto
params.OutputFlag=0;

result = gurobi(model, params);

if strcmp(result.status, 'OPTIMAL')
    x=result.x;
    bpl=log(result.objbound);
else
    x = Inf;
    bpl= Inf;
    result
end

end


