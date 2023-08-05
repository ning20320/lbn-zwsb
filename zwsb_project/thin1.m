function img2 = thin1(img1)
% 对指纹图像进行滤波处理
img1_1 = ordfilt2(img1, 5, ones(3, 3));
img1_2 = img1_1;
[r, c] = size(img1_2);
% 去除毛刺
for i = 2 : r - 1
    for j = 2 : c - 1
        if(img1_2(i, j) == 0)
            if(img1_2(i, j - 1) + img1_2(i - 1, j) + img1_2(i, j + 1) + img1_2(i + 1, j) >= 3)
                img1_2(i, j) = 1;
            else
                img1_2(i, j) = img1_2(i, j);
            end
        end
    end
end
% 去除空洞
for i = 2 : r - 1
    for j = 2 : c - 1
        if(img1_2(i, j) == 1)
            if(abs(img1_2(i, j + 1) - img1_2(i - 1, j + 1)) + abs(img1_2(i - 1, j + 1) - img1_2(i - 1, j))...
                    + abs(img1_2(i - 1, j) - img1_2(i - 1, j - 1)) + abs(img1_2(i - 1, j - 1) - img1_2(i, j - 1))...
                    + abs(img1_2(i, j - 1) - img1_2(i + 1, j - 1)) + abs(img1_2(i + 1, j - 1) - img1_2(i + 1, j))...
                    + abs(img1_2(i + 1, j) - img1_2(i + 1, j + 1)) + abs(img1_2(i + 1, j + 1) - img1_2(i, j + 1)) ~= 1)
                if((img1_2(i, j + 1) + img1_2(i - 1, j + 1) + img1_2(i - 1, j)) * (img1_2(i, j - 1) + img1_2(i + 1, j - 1) + img1_2(i + 1, j))...
                        + (img1_2(i - 1, j) + img1_2(i - 1, j - 1) + img1_2(i, j - 1)) * (img1_2(i + 1, j) + img1_2(i + 1, j + 1) + img1_2(i, j + 1)) == 0)
                    img1_2(i, j) = 0;
                end
            end
        end
    end
end
% 取反
img1_3 = ~img1_2;
% 构建一个宽度为3个元素的正方形结构元素
SE = strel('square', 3);
% 开操作，先腐蚀后膨胀
J = imopen(img1_3, SE);
% 闭操作， 先膨胀后腐蚀
img1_3 = imclose(J, SE);
% 对图像进行细化
img2 = bwmorph(img1_3, 'thin', Inf);