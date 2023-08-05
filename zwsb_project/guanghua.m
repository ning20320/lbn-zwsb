function  [w,txy]=guanghua(thin,txy)
for j=1:5
    txy=point(thin);
    pxy=txy(find(txy(:,3)==2),:);
    n=size(pxy,1);
    for i=1:n
        error=0;
        error=walk(thin,pxy(i,1),pxy(i,2),5);
        if  error==1
            thin(pxy(i,2),pxy(i,1))=0;
        end
    end
end
w=thin;