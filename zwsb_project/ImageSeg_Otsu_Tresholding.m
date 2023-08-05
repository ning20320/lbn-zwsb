%Otsuȫ����ֵ�ָ��㷨
function [im2,trd,lamda] = ImageSeg_Otsu_Tresholding(ima,falg)

%falg :�����ж��Ƿ���Ҫ��С����ֵ�Ĳ��ֱ�Ϊ0,���falg=0����Ҫ�����falg=1����Ҫ

ima = double(ima);
im2 = ima;
H = myHist(ima);            % S1: ��һ�����ֱ��ͼ
L = length(H);
P1 = zeros(L,1);
avg_local = P1;
sigmaB = P1;
lamda = P1;
avg_global = mean(ima(:));  % S4: ����ȫ�ֻҶȾ�ֵ

for k = 1 : L
    P1(k) = sum(H(1:k));              % S2: ���ֵ�C1��������ۼӸ���
    avg_local(k) = (0:k-1) * H(1:k);  % S3: �ۼƻҶȾ�ֵ
    
    % S5: ������䷽��sigmaB
    sigmaB(k) = (avg_global*P1(k)-avg_local(k))^2/(P1(k)*(1-P1(k))+eps);
    lamda(k) = sigmaB(k)/var(ima(:));
end

idx = find(sigmaB == max(sigmaB));    % S6: ������ѷָ���ֵtrd
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

% ֱ��ͼ��һ��
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