clc
clear all;

%1
img1 = zeros(800, 800);
%2
A = imnoise2('rayleigh', 800, 800, 0, 1);
img1 = img1 + A;
%3
histogram(img1);
title('Гистограмма распределения шума Релэя');
pause;
saveas(gcf, 'histogram_noise.png');
%4
obj1 = zeros(800, 800);
obj1 = insertShape(obj1, "rectangle", [300, 300, 150, 150], Color = "w", LineWidth=5);
obj1 = insertShape(obj1, "rectangle", [350, 350, 50, 50], Color = "w", LineWidth=5);
imwrite(obj1, 'obj1.png');
%5
obj1_big = imresize(obj1, 2, "nearest");
obj1_small = imresize(obj1, 0.5, "bilinear");
imwrite(obj1_big, 'obj1_big.png');
imwrite(obj1_small, 'obj1_small.png');
%6
obj2 = zeros(800, 800);
obj2 = insertShape(obj2, 'circle', [150, 150, 120], Color = 'w', LineWidth = 3);
obj2 = insertShape(obj2, 'circle', [150, 150, 80], Color = 'w', LineWidth = 3);

obj3 = zeros(800, 800);
obj3 = insertShape(obj3, "filled-rectangle", [680, 600, 20, 150], Color = 'W', Opacity = 1);

obj = obj1 + obj2 + obj3 + A;
imshow(obj);

%7
flipped_x = flipdim(obj, 2);
imwrite(flipped_x, 'flipped_x.png');

%8 
flipped_y = flipdim(obj, 1);
imwrite(flipped_y, 'flipped_y.png');

%9
rotate_plus = imrotate(obj, -45);
imwrite(rotate_plus, 'rotate_plus.png')

%10
rotate_minus = imrotate(obj, 45);
imwrite(rotate_minus, 'rotate_minus.png')

%11
fon = imread("fon.jpg");

%12
targetSize = [800 800];
r = centerCropWindow2d(size(fon), targetSize);
fon = imcrop(fon, r);

%13
fon_dark = fon / 4;

%14
fon_dark = im2double(im2gray(fon_dark));
new_obj = fon_dark + obj1 + obj2 + A;
 
%15
negativ = imcomplement(new_obj);
imwrite(negativ, "negativ.png");

%16
new_obj2 = fon_dark + obj1 + A;
imwrite(new_obj2, "new_obj2.png");

%17
diff = new_obj - new_obj2;
imwrite(diff, 'diff.png');
