% 算出脊的长度
function d=distance(x0,y0,num,thin)
num2=fix(num/5);
for i=1:num2
    [error,a,b]=walk(thin,x0,y0,5*i);
    if error~=1
        d(i)=sqrt((a-x0)^2+(b-y0)^2);
    else
        break;
    end
end