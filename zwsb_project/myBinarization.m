%图像二值化
function im2 = myBinarization(im1)

temp=(1/9)*[1 1 1;1 1 1;1 1 1]; % 模板系数、均值滤波
[r,c]=size(im1);
Im=double(im1);
In=zeros(r,c);
ims=ones(r,c);

% 均值滤波
for a=2:r-1
    for b=2:c-1
        In(a,b)=Im(a-1,b-1)*temp(1,1)+Im(a-1,b)*temp(1,2)+Im(a-1,b+1)*temp(1,3)+Im(a,b-1)*temp( 2,1)+Im(a,b)*temp(2,2)+Im(a,b+1)*temp(2,3)+Im(a+1,b-1)*temp(3,1)+Im(a+1,b)*temp(3,2)+ Im(a+1,b+1)*temp(3,3);
    end
end
im1=In;
new_Im=zeros(r,c);

% 基于方向场二值化
for x=5:r-5
    for y=5:c-5
        sum1=im1(x,y-4)+im1(x,y-2)+im1(x,y+2)+im1(x,y+4); 
        sum2=im1(x-2,y+4)+im1(x-1,y+2)+im1(x+1,y-2)+im1(x+2,y-4); 
        sum3=im1(x-2,y+2)+im1(x-4,y+4)+im1(x+2,y-2)+im1(x+4,y-4); 
        sum4=im1(x-2,y+1)+im1(x-4,y+2)+im1(x+2,y-1)+im1(x+4,y-2); 
        sum5=im1(x-2,y)+im1(x-4,y)+im1(x+2,y)+im1(x+4,y); 
        sum6=im1(x-4,y-2)+im1(x-2,y-1)+im1(x+2,y+1)+im1(x+4,y+2); 
        sum7=im1(x-4,y-4)+im1(x-2,y-2)+im1(x+2,y+2)+im1(x+4,y+4); 
        sum8=im1(x-2,y-4)+im1(x-1,y-2)+im1(x+1,y+4)+im1(x+2,y+4); 
        sumi=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8];
        summax=max(sumi); summin=min(sumi); summ=sum(sumi);
        b=summ/8;
        if (summax+summin+ 4*im1(x,y))> (3*summ/8)
            sumf = summin;
        else
            sumf =summax;
        end
        if sumf > b
            new_Im(x,y)=128;
        else
            new_Im(x,y)=255;
        end
    end
end
for i=1:r
    for j =1:c
        ims(i,j)=ims(i,j)*new_Im(i,j);
    end
end
for i=1:r
    for j =1:c
        if (ims(i,j)==128)
            ims(i,j)=0;
        else
            ims(i,j)=1;
        end
    end
end
im2 = ims;