pt = 'D:\文档\实验\数字图像\存储数据';
ext = '*.bmp';
dis = dir([pt, ext]);
nms = {dis.name};
a = imread([pt, nms{1}]);
images = zeros(size(a, 1), size(a, 2), length(nms));
for i = 1 : length(nms)
    nm = [pt, nms{i}];
    image = imread(nm);
    images(:, :, i) = image;
end
images = uint8(images);
save images_mat images;