%2
lenna = imread('../Lenna.png');

%3
imshow(lenna);
pause;

%4
imwrite(lenna, 'lenna.jpg');

%5
imwrite(lenna, 'lenna.png');

%6
i_j = imfinfo('lenna.jpg');
i_p = imfinfo('lenna.png');

%7
k_jpg = (i_j.Width * i_j.Height * i_j.BitDepth) / (8 * i_j.FileSize);
k_png = (i_p.Width * i_p.Height * i_p.BitDepth) / (8 * i_p.FileSize);
if k_jpg > k_png
    fprintf("k_jpg > k_png\n");
else
    fprintf("k_jpg < k_png\n");
end

%8
lenna_gray = rgb2gray(lenna);
imshow(lenna_gray);
pause;
imwrite(lenna_gray, 'lenna_gray.png');

% %9
lenna_bin25 = mat2gray(lenna_gray, [255*0.25, 255]);
imshow(lenna_bin25);
pause;
lenna_bin50 = mat2gray(lenna_gray, [255*0.50, 255]);
imshow(lenna_bin50);
pause;
lenna_bin75 = mat2gray(lenna_gray, [255*0.75, 255]);
imshow(lenna_bin75);
pause;
imwrite(lenna_bin25, './Logical/lenna_bin25.png');
imwrite(lenna_bin50, './Logical/lenna_bin50.png');
imwrite(lenna_bin75, './Logical/lenna_bin75.png');

%10 lenna_gray уже уинт8
%lenna_gray = im2uint8(lenna_gray);
lenna_1 = logical(bitget(lenna_gray, 1));
imshow(lenna_1);
pause;
lenna_2 = logical(bitget(lenna_gray, 2));
imshow(lenna_2);
pause;
lenna_3 = logical(bitget(lenna_gray, 3));
imshow(lenna_3);
pause;
lenna_4 = logical(bitget(lenna_gray, 4));
imshow(lenna_4);
pause;
lenna_5 = logical(bitget(lenna_gray, 5));
imshow(lenna_5);
pause;
lenna_6 = logical(bitget(lenna_gray, 6));
imshow(lenna_6);
pause;
lenna_7 = logical(bitget(lenna_gray, 7));
imshow(lenna_7);
pause;
lenna_8 = logical(bitget(lenna_gray, 8));
imshow(lenna_8);
pause;

imwrite(lenna_1, './BitPlane/lenna_1.png');
imwrite(lenna_2, './BitPlane/lenna_2.png');
imwrite(lenna_3, './BitPlane/lenna_3.png');
imwrite(lenna_4, './BitPlane/lenna_4.png');
imwrite(lenna_5, './BitPlane/lenna_5.png');
imwrite(lenna_6, './BitPlane/lenna_6.png');
imwrite(lenna_7, './BitPlane/lenna_7.png');
imwrite(lenna_8, './BitPlane/lenna_8.png');

%11
lenna_d5 = mat2gray(blkproc(lenna_gray, [5 5], 'mean2(x) * ones(size(x))'));
lenna_d10 = mat2gray(blkproc(lenna_gray, [10 10], 'mean2(x) * ones(size(x))'));
lenna_d20 = mat2gray(blkproc(lenna_gray, [20 20], 'mean2(x) * ones(size(x))'));
lenna_d50 = mat2gray(blkproc(lenna_gray, [50 50], 'mean2(x) * ones(size(x))'));
imwrite(lenna_d5, './Discret/lenna_d5.png');
imwrite(lenna_d10, './Discret/lenna_d10.png');
imwrite(lenna_d20, './Discret/lenna_d20.png');
imwrite(lenna_d50, './Discret/lenna_d50.png');

%12
lenna_q4 = mat2gray(imquantize(lenna_gray, linspace(0, 255, 5)));
lenna_q16 = mat2gray(imquantize(lenna_gray, linspace(0, 255, 17)));
lenna_q32 = mat2gray(imquantize(lenna_gray, linspace(0, 255, 33)));
lenna_q64 = mat2gray(imquantize(lenna_gray, linspace(0, 255, 65)));
lenna_q128 = mat2gray(imquantize(lenna_gray, linspace(0, 255, 129)));

imwrite(lenna_q4, './Quantiz/lenna_q4.png');
imwrite(lenna_q16, './Quantiz/lenna_q16.png');
imwrite(lenna_q32, './Quantiz/lenna_q32.png');
imwrite(lenna_q64, './Quantiz/lenna_q64.png');
imwrite(lenna_q128, './Quantiz/lenna_q128.png');

%13 
x_cent = i_j.Width/2;
y_cent = i_j.Height/2;
crop_size = 100;
xmin = x_cent-crop_size/2;
ymin = y_cent-crop_size/2;
lenna_crop = imcrop(lenna_gray, [xmin ymin crop_size crop_size]);
imshow(lenna_crop);
pause;
imwrite(lenna_crop, './Crop/lenna_crop.png');

%14
N1 = [lenna_gray(20, 17), lenna_gray(21, 16),lenna_gray(22, 17),lenna_gray(21, 18)];
N2 = [lenna_gray(14, 11), lenna_gray(15, 10),lenna_gray(16, 11),lenna_gray(15, 12)];
N3 = [lenna_gray(18, 88), lenna_gray(18, 87),lenna_gray(19, 87),lenna_gray(20, 87), lenna_gray(20, 88), lenna_gray(20, 89),lenna_gray(19, 89),lenna_gray(18, 89)];

%15
I_mean = mean(mean(lenna_gray));

%16
new_lenna = lenna_gray;
patch_size = 20;
lenna_crop_1 = imcrop(lenna_gray, [0 0 patch_size patch_size]);
lenna_crop_2 = imcrop(lenna_gray, [i_j.Height-patch_size 0 patch_size patch_size]);
lenna_crop_3 = imcrop(lenna_gray, [0 i_j.Width-patch_size patch_size patch_size]);
lenna_crop_4 = imcrop(lenna_gray, [i_j.Height-patch_size i_j.Width-patch_size patch_size patch_size]);
lenna_crop_5 = imcrop(lenna_gray, [x_cent-patch_size/2 y_cent-patch_size/2 patch_size patch_size]);
mean_crop1 = mean(mean(lenna_crop_1));
mean_crop2 = mean(mean(lenna_crop_2));
mean_crop3 = mean(mean(lenna_crop_3));
mean_crop4 = mean(mean(lenna_crop_4));
mean_crop5 = mean(mean(lenna_crop_5));

if mean_crop1 < 128
    new_lenna = insertShape(new_lenna, "FilledRectangle", [0 0 patch_size patch_size], "Color", {"white"}, "Opacity", 1);
else
    new_lenna = insertShape(new_lenna, "FilledRectangle", [0 0 patch_size patch_size], "Color", {"black"}, "Opacity", 1);
end

if mean_crop2 < 128
    new_lenna = insertShape(new_lenna, "FilledRectangle", [i_j.Height-patch_size 0 patch_size patch_size], "Color", {"white"}, "Opacity", 1);
else
    new_lenna = insertShape(new_lenna, "FilledRectangle", [i_j.Height-patch_size 0 patch_size patch_size], "Color", {"black"}, "Opacity", 1);
end

if mean_crop3 < 128
    new_lenna = insertShape(new_lenna, "FilledRectangle", [0 i_j.Width-patch_size patch_size patch_size], "Color", {"white"}, "Opacity", 1);
else
    new_lenna = insertShape(new_lenna, "FilledRectangle", [0 i_j.Width-patch_size patch_size patch_size], "Color", {"black"}, "Opacity", 1);
end

if mean_crop4 < 128
    new_lenna = insertShape(new_lenna, "FilledRectangle", [i_j.Height-patch_size i_j.Width-patch_size patch_size patch_size], "Color", {"white"}, "Opacity", 1);
else
    new_lenna = insertShape(new_lenna, "FilledRectangle", [i_j.Height-patch_size i_j.Width-patch_size patch_size patch_size], "Color", {"black"}, "Opacity", 1);
end

if mean_crop5 < 128
    new_lenna = insertShape(new_lenna, "FilledRectangle", [x_cent-patch_size/2 y_cent-patch_size/2 patch_size patch_size], "Color", {"white"}, "Opacity", 1);
else
    new_lenna = insertShape(new_lenna, "FilledRectangle", [x_cent-patch_size/2 y_cent-patch_size/2 patch_size patch_size], "Color", {"black"}, "Opacity", 1);
end
imshow(new_lenna);
imwrite(new_lenna, './Marks/lenna_marked.png');
