%��ָ��ͼ����й�һ������
function im2 = myStandardization(im1)

ims=double(im1);
[r,c]=size(im1);
m=20;               %��ͼ��ָ��20*20��
fr=floor(r/m);      %ÿ�зֿ��С
fc=floor(c/m);      %ÿ�зֿ��С
M0=mean2(ims);      %ԭͼ��Ҷȵľ�ֵ
V=std2(ims);        %ԭͼ��Ҷȵı�׼��
V0=V*V;             %ԭͼ��Ҷȵķ���
M1=80;              %ָ����ͼ��Ҷȵľ�ֵ
V1=6000;            %ָ����ͼ��Ҷȵķ���
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