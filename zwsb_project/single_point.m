% 找出比较独特的端点来作为识别的特征点
function [pxy2,error]=single_point(txy,r)
error=0;
x=txy(:,1);
y=txy(:,2);
n=length(x);
d(1:n,1:n)=0;
for j=1:n
    for i=1:n
        if (i~=j)
            d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        else
            d(i,j)=2*r;
        end
    end
end
[a,b]=min(d);
c=find(a>r);
pxy2=txy(c,:);
pxy2=pxy2(find(pxy2(:,3)==2),:);
t=size(pxy2,1);
if t==0
    error=1;
end