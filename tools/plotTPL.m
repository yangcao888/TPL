%=========================================
% plot TPL, including BPL and FPL, on timeline
% 05-Dec-2017 author: Yang Cao 
%=========================================
function plotTPL(eArr, TM_B, TM_F, printTPL)

[EspMatrix_B, qM_B, dM_B, QDplusInd_B]= preCompQDMatrix(TM_B);
EspMatrix_B(isnan(EspMatrix_B)) = 0;

[EspMatrix_F, qM_F, dM_F, QDplusInd_F]= preCompQDMatrix(TM_F);
EspMatrix_F(isnan(EspMatrix_F)) = 0;

a1=0;
an=100;
[aArrMax_B, qArrMax_B, dArrMax_B] = genLFunc(a1, an, EspMatrix_B, qM_B, dM_B);
[aArrMax_F, qArrMax_F, dArrMax_F] = genLFunc(a1, an, EspMatrix_F, qM_F, dM_F);

T=size(eArr, 2);

bplArr=zeros(1,T);
fplArr=zeros(1,T);

bplArr(1) = eArr(1);
fplArr(T)= eArr(T);

for t=2:T
    bplArr(t) = calcPLbyFunc(bplArr(t-1), aArrMax_B, qArrMax_B, dArrMax_B) + eArr(t);
end


for t=T-1:-1:1
    fplArr(t) = calcPLbyFunc(fplArr(t+1), aArrMax_F, qArrMax_F, dArrMax_F) + eArr(t);
end



tplArr = bplArr+fplArr - eArr;

if printTPL
    tplArr
end

figure;
plot((1:T), eArr, '-k*', (1:T), bplArr, '--bo', (1:T), fplArr, '--ms', (1:T), tplArr, '-r^', 'LineWidth', 1 )
ax = gca;
ax.YScale='linear';
ax.FontSize = 12;
ax.XTick=1:T;
ax.YLim=[0,max(tplArr)+0.1];
ax.XLabel.String = 'time';
ax.YLabel.String = 'privacy loss';
legend({'budget', 'BPL', 'FPL', 'TPL'}, 'FontSize',16);
end