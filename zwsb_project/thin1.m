function img2 = thin1(img1)
% ��ָ��ͼ������˲�����
img1_1 = ordfilt2(img1, 5, ones(3, 3));
img1_2 = img1_1;
[r, c] = size(img1_2);
% ȥ��ë��
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
% ȥ���ն�
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
% ȡ��
img1_3 = ~img1_2;
% ����һ�����Ϊ3��Ԫ�ص������νṹԪ��
SE = strel('square', 3);
% ���������ȸ�ʴ������
J = imopen(img1_3, SE);
% �ղ����� �����ͺ�ʴ
img1_3 = imclose(J, SE);
% ��ͼ�����ϸ��
img2 = bwmorph(img1_3, 'thin', Inf);