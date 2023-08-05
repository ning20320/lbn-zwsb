% 对八个领域的坐标进行定义
function j = P (img, x, y, i)
%得到基于图像素值
%  4 | 3 | 2
%  5 |   | 1
%  6 | 7 | 8
switch (i)
    case {1, 9}
        j = img(x+1, y);
    case 2
        j = img(x + 1, y-1);
    case 3
        j = img(x, y - 1);
    case 4
        j = img(x - 1, y - 1);
    case 5
        j = img(x - 1, y);
    case 6
        j = img(x - 1, y + 1);
    case 7
        j = img(x, y + 1);
    case 8
        j = img(x + 1, y + 1);
end