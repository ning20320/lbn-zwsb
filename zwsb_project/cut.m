% È¥³ýÍ¼Ïñ±ßÔµµÄ¶Ëµã
function txy=cut(thin,txy)
s(8,8)=0;
delta(8,8)=0;
n=size(txy,1);
for i=1:8
    for j=1:8
        mp{i,j}=thin(1+31*(i-1):31+31*(i-1),1+31*(j-1):31+31*(j-1));
        s(i,j)=sum(sum(mp{i,j}))/(31*31);
        mp{i,j}=(mp{i,j}-s(i,j)).^2;
        delta(i,j)=sum(sum(mp{i,j}));
        if delta(i,j)<=70
            for k=1:n
                if (txy(k,1)>=1+31*(i-1)&&txy(k,1)<=31+31*(i-1)&&txy(k,2)>=1+31*(j-1)&&txy(k,2)<=31+31*(j-1)&&txy(k,3)==2)
                    txy(k,:)=[0,0,0];
                end
            end
        end
    end
end
txy=txy(find(txy(:,1)),:);