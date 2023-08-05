%对指纹图像进行归一化处理
function im2 = myStandardization(im1)

ims=double(im1);
[r,c]=size(im1);
m=20;               %将图像分割成20*20块
fr=floor(r/m);      %每行分块大小
fc=floor(c/m);      %每列分块大小
M0=mean2(ims);      %原图像灰度的均值
V=std2(ims);        %原图像灰度的标准差
V0=V*V;             %原图像灰度的方差
M1=80;              %指定新图像灰度的均值
V1=6000;            %指定新图像灰度的方差
for i=1:r
    for j=1:c
        if ims(i,j)>M0
            new_ims(i,j)=M1+sqrt(V1*((ims(i,j)-M0)*(ims(i,j)-M0))/V0);
        else
            new_ims(i,j)=M1-sqrt(V1*((ims(i,j)-M0)*(ims(i,j)-M0))/V0);
        end
    end
end

for i = 1:m
    for j = 1:m
        indr = ((i-1)*fr+1):(i*fr);
        indc = ((j-1)*fc+1):(j*fc);
        temp = new_ims(indr,indc);
        [temp1,trd,lamda] = ImageSeg_Otsu_Tresholding(temp,0);
         new_ims(indr,indc) = temp1;
    end
end
im2 = new_ims;