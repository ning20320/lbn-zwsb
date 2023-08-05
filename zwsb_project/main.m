x1 = imread('Áõ±şÄş×óÊ³Ö¸1.bmp');
% y1 = imread('Áõ±şÄşÓÒÊ³Ö¸.bmp');
y1 = imread('Áõ±şÄş×óÊ³Ö¸2.bmp');

x4 = main1(x1);
y4 = main1(y1);
error = main2(x4,y4);
figure();
if error == 0
    subplot(1,2,1)
    imshow(x4);
    title('Æ¥Åä³É¹¦');
    subplot(1,2,2)
    imshow(y4);
else
    subplot(1,2,1);
    imshow(x4);
    subplot(1,2,2)
    imshow(y4);
    title('Æ¥ÅäÊ§°Ü');
end