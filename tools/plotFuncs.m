%=========================================
% Plot L(a)
% 05-Dec-2017 author: Yang Cao 
%=========================================

function plotFuncs(qArrMax, dArrMax, x_lMax, x_uMax, dataPointsNum, linewidth, StemSpec, plotStemOrNot)
rNums=numel(qArrMax);

% get x data
x=zeros(rNums, dataPointsNum);
for i = 1:rNums
    x(i,:) = linspace(x_lMax(i), x_uMax(i), dataPointsNum);
end

% qArr = repmat(qArr, 1, dataPointsNum);
% dArr = repmat(dArr, 1, dataPointsNum);

y= log((qArrMax.*(exp(x)-1)+1) ./ (dArrMax.*(exp(x)-1)+1));



plot(x',y', 'LineWidth', linewidth)

ax = gca;
ax.FontSize = 18;
% ax.XTick=nArr;
% ax.XGrid = 'on';
% ax.YGrid = 'on';
ax.XLabel.String = '\alpha';
ax.YLabel.String = 'incremental privacy loss';

% legend({'Algo2', 'Cplex'}, 'FontSize',16);


if plotStemOrNot
    x_lMax_plot = x_lMax(x_lMax>min(x_lMax));
    qArrMax_plot_l = qArrMax(x_lMax>min(x_lMax));
    dArrMax_plot_l = dArrMax(x_lMax>min(x_lMax));
    
    x_uMax_plot = x_uMax(x_uMax<max(x_uMax));
    qArrMax_plot_u = qArrMax(x_uMax<max(x_uMax));
    dArrMax_plot_u = dArrMax(x_uMax<max(x_uMax));
    
    qArrMax_plot = [qArrMax_plot_l; qArrMax_plot_u]
    dArrMax_plot = [dArrMax_plot_l; dArrMax_plot_u]
    
    x_end = [x_lMax_plot; x_uMax_plot];
    
    y_end= log((qArrMax_plot.*(exp(x_end)-1)+1) ./ (dArrMax_plot.*(exp(x_end)-1)+1));
    hold on;
    stem(x_end', y_end', StemSpec, 'LineWidth', linewidth, 'MarkerSize', 8)
end
end