% 进行归一化、二值化、细化
function x4 = main1(x1)

x2 = myStandardization(x1);          % 归一化和分割
x3 = myBinarization(x2);             % 二值化
x4 = thin1(x3);                      % 细化
