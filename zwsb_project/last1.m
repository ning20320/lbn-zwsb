% �ҳ�һ�˵���rΪ�뾶�������ڵ��κζ˵�ͽ���������ż��������num��û���κε������˵�ͽ����
function [pxy3,error2]=last1(thin,r,txy,num)
error=0;
[pxy2,error]=single_point(txy,r);
n=size(pxy2,1);
l=1;
error2=0;
pxy3=[];
for i=1:n
    [error,a,b]=walk(thin,pxy2(i,1),pxy2(i,2),num);
    if error~=1
        pxy3(l,1)= pxy2(i,1);
        pxy3(l,2)= pxy2(i,2);
        pxy3(l,3)= pxy2(i,3);
        l=l+1;
        error2=0;
    end
end

