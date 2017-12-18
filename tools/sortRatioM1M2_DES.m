%% m1 are Qs, m2 are Ds; e.g., 1st row in m2 -- 1st row in m2
function [m1, m2] = sortRatioM1M2_DES(m1, m2)


rNum=size(m1,1);
cNum=size(m1,2);

[~,idx]=sort((m1./m2),2,'descend', 'MissingPlacement', 'last');
 
idx=(idx-1)*rNum+repmat((1:rNum)',1, cNum);

m1=m1(idx);
m2=m2(idx);

% m1_sorted = m1;
% m2_sorted =m2;

end