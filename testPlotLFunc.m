%=========================================
% plot the figure 4 used in our TKDE paper,
% which demonstrates the L(a) function.
%
% 05-Dec-2017 author: Yang Cao 
%=========================================
addpath('tools/');

clc;
clear;


TM=[0.1 0.2 0.7; 0.3 0.3 0.4; 0.5 0.3 0.2];

% n=5;
% m=abs(normrnd(1,1,n,n));
% di=sum(m, 2);
% TM=bsxfun(@rdivide, m, di);

dim = size(TM,2);

[EspMatrix, qM, dM, QDplusInd]= preCompQDMatrix(TM);

%% common for plot and fplot
maxEsp= max(max(EspMatrix(~isinf(EspMatrix) & ~isnan(EspMatrix))));
if ~isempty(maxEsp)
    maxEsp=maxEsp+3.5;
else
    maxEsp=100;
end
EspMatrix(isinf(EspMatrix)) = maxEsp;
EspMatrix(isnan(EspMatrix)) = 0;

%% plot

% get (q d) pairs
qArr=qM(QDplusInd);
dArr=dM(QDplusInd);

% get x \in [x_l, x_b] for each (q d) pair
x_u= EspMatrix(QDplusInd);
x_l= EspMatrix(circshift(QDplusInd, 1, 2));

figure
plotPoints = 1000;
linewidth = 1;
StemSpec = ':o';
plotFuncs(qArr, dArr, x_l, x_u, plotPoints, linewidth, StemSpec, 1);



a1= 0;
an=maxEsp;
[EspMatrix, qM, dM, QDplusInd]= preCompQDMatrix(TM);
[aArrMax, qArrMax, dArrMax] = genLFunc(a1, an, EspMatrix, qM, dM);
x_uMax= aArrMax';
x_lMax=[a1; x_uMax];
x_lMax=x_lMax(1:end-1);
linewidth = 3;


qArrMax = qArrMax';
dArrMax = dArrMax';
% draw top func
rNums=numel(qArrMax);

% get x data
x=zeros(rNums, plotPoints);
for i = 1:rNums
    x(i,:) = linspace(x_lMax(i), x_uMax(i), plotPoints);
end

% qArr = repmat(qArr, 1, dataPointsNum);
% dArr = repmat(dArr, 1, dataPointsNum);

y= log((qArrMax.*(exp(x)-1)+1) ./ (dArrMax.*(exp(x)-1)+1));

x_end = [x_lMax, x_uMax];
y_end= log((qArrMax.*(exp(x_end)-1)+1) ./ (dArrMax.*(exp(x_end)-1)+1));

plot(x',y', 'LineWidth', linewidth)

ax = gca;
ax.FontSize = 20;
% ax.XTick=nArr;
% ax.XGrid = 'on';
% ax.YGrid = 'on';
ax.XLabel.String = '\alpha';
ylabel('Incremental Privacy leakage');
% ylabel('$\mathcal{L}(\alpha)$', 'Interpreter', 'latex');



% legend({'Algo2', 'Cplex'}, 'FontSize',16);

%% plot a special point & annotation
x_intersec = x_lMax(2);
y_intersec = log((qArrMax.*(exp(x_intersec)-1)+1) ./ (dArrMax.*(exp(x_intersec)-1)+1));
plot(x_intersec, y_intersec, 'p', 'MarkerSize', 18)

 x = [0.4,0.5];
 y = [0.7,0.58];
 annotation('textarrow',x, y, 'String', '$\mathcal{L}(\alpha)$', 'FontSize', 18, 'Interprete', 'latex')

