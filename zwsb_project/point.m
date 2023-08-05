% 找出所有端点及交叉点
function txy=point(thin)
count = 1;
txy(count, :) = [0,0,0];
siz=min(size(thin,1),size(thin,2));
for x=40:siz - 40
    for y=40:siz - 40
        if (thin(y, x) )
            CN = 0;
            for i = 1:8
                CN = CN + abs (P(thin, y, x, i) - P(thin, y, x, i + 1));
            end
            if (CN == 2)                     % 端点
                txy(count, :) = [x, y,2];    % y=2时为端点
                count = count + 1;
            end
            if (CN == 6)                     % 交叉点
                txy(count, :) = [x, y,6];    % y=2时为交叉点
                count = count + 1;
            end
        end
    end
end
for i=1:count - 1
    x(i) =txy(i, 1);
    y(i)= txy(i, 2);
end