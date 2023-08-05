%Otsu全局阈值分割算法
function [im2,trd,lamda] = ImageSeg_Otsu_Tresholding(ima,falg)

%falg :用来判断是否需要将小于阈值的部分变为0,如果falg=0则不需要；如果falg=1则需要

ima = double(ima);
im2 = ima;
H = myHist(ima);            % S1: 归一化后的直方图
L = length(H);
P1 = zeros(L,1);
avg_local = P1;
sigmaB = P1;
lamda = P1;
avg_global = mean(ima(:));  % S4: 计算全局灰度均值

for k = 1 : L
    P1(k) = sum(H(1:k));              % S2: 被分到C1类的像素累加概率
    avg_local(k) = (0:k-1) * H(1:k);  % S3: 累计灰度均值
    
    % S5: 计算类间方差sigmaB
    sigmaB(k) = (avg_global*P1(k)-avg_local(k))^2/(P1(k)*(1-P1(k))+eps);
    lamda(k) = sigmaB(k)/var(ima(:));
end

idx = find(sigmaB == max(sigmaB));    % S6: 搜索最佳分割阈值trd
idx = idx - 1;
if length(idx) == 1
    trd = idx;
    lamda = lamda(idx+1);
else
    trd = mean(idx);
    lamda = mean(lamda(idx+1));
end
im2(im2>=trd) = 255;
if falg == 1
    im2(im2<trd) = 0;
end
im2 = uint8(im2);
end

% 直方图归一化
function H = myHist(ima)

ima = double(ima);
[r,c] = size(ima);
L = 256;
H = zeros(256,1);
for k = 1 : L
    rk = k - 1;
    ind = find(ima(:) == rk);
    H(k) = length(ind);
end
H = H/(r*c);
end