% 进行特征点提取、寻找、匹配
function error = main2(th1,th2)

% 特征点提取
txy1 = point(th1);
txy2 = point(th2);
[w1,txy1] = guanghua(th1,txy1);
[w2,txy2] = guanghua(th2,txy2);
th1 = w1;
th2 = w2;
txy1 = cut(th1,txy1);
txy2 = cut(th2,txy2);

% 特征点寻找
[pxy31,error2] = last1(th1,8,txy1,60);
[pxy32,error3] = last1(th2,8,txy2,60);
 if isempty(pxy31) == 1 || isempty(pxy32) == 1  % 判断数组pxy31和pxy32是否为空
    error = 1;
    return;
 end

% 特征点匹配
num = 20;
cxy1 = pxy31;
cxy2 = pxy32;
% 第一种情况：脊线长度匹配
d1 = distance(cxy1(1,1),cxy1(1,2),num,th1);
d2 = distance(cxy2(1,1),cxy2(1,2),num,th2);
f = (sum(abs(d1./d2-1)));
if f <= 0.5
    errorf = 0;
else
    errorf = 1;
end
% 第二种情况：三角形边长匹配
c11 = find_point(cxy1(1,1),cxy1(1,2),txy1,1);
c12 = find_point(cxy1(1,1),cxy1(1,2),txy1,2);
c21 = find_point(cxy2(1,1),cxy2(1,2),txy2,1);
c22 = find_point(cxy2(1,1),cxy2(1,2),txy2,2);
cxy1(2,:) = c11;
cxy1(3,:) = c12(2,:);
cxy2(2,:) = c21;
cxy2(3,:) = c22(2,:);
x11 = cxy1(1,1);
y11 = cxy1(1,2);
x12 = cxy1(2,1);
y12 = cxy1(2,2);
x13 = cxy1(3,1);
y13 = cxy1(3,2);
x21 = cxy2(1,1);
y21 = cxy2(1,2);
x22 = cxy2(2,1);
y22 = cxy2(2,2);
x23 = cxy2(3,1);
y23 = cxy2(3,2);
dd1(1) = juli(x11,y11,x12,y12);
dd1(2) = juli(x12,y12,x13,y13);
dd1(3) = juli(x13,y13,x11,y11);
dd2(1) = juli(x21,y21,x22,y22);
dd2(2) = juli(x22,y22,x23,y23);
dd2(3) = juli(x23,y23,x21,y21);
ff = (sum(abs((dd1./dd2)-1)));
if ff <= 1.5
    errorff = 0;
else
    errorff = 1;
end
% 第三种情况：点类型匹配
cxy1(2:41,:) = find_point(pxy31(1,1),pxy31(1,2),txy1,40);
cxy2(2:41,:) = find_point(pxy32(1,1),pxy32(1,2),txy2,40);
f11 = length(find(cxy1(:,3)==2));
f12 = length(find(cxy1(:,3)==6));
f21 = length(find(cxy2(:,3)==2));
f22 = length(find(cxy2(:,3)==6));
fff = abs(f11-f21)/(f11+f12);
if fff <= 0.2
    errorfff = 0;
else
    errorfff = 1;
end
if errorf == 0 && errorff == 0 && errorfff == 0
    error = 0;
else
    error = 1;
end