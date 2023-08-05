% 找出距离某一端点最近的两个端点或交叉点
function pxy=find_point(x0,y0,txy,num)
x=txy(:,1);
y=txy(:,2);
n=length(x);
l(1,n)=0;
lnn=1;
pxy(num,:)=[0,0,0];
for i=1:n
    l(i)=sqrt((x(i)-x0)^2+(y(i)-y0)^2);
end
ll=sort(l);
if num >= n
    num = n - 1;
end
for i=1:num
    xiao=ll(i+lnn);
    nn=find(l==xiao);
    lnn=length(nn);
    pxy(i,:)=[x(nn(1)),y(nn(1)),txy(nn(1),3)];
end
