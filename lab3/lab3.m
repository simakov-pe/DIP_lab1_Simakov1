clc
clear all;

%1
img = im2double(rgb2gray(imread("penguin.png")));
imwrite(img, "img.png");
histogram(img);
title('Гистограмма полутонового изображения');
saveas(gcf, 'histogram.png');

%2
log_transform = log(1 + img);
imwrite(log_transform, 'Log\log_transform.png');
histogram(log_transform);
title('Гистограмма лог. преобр');
saveas(gcf, 'histogram_log.png');

%3
degree01 = img.^0.1;
degree045 = img.^0.45;
degree5 = img.^5;

imwrite(degree01, 'Degree\degree01.png');
imwrite(degree045, 'Degree\degree045.png');
imwrite(degree5, 'Degree\degree5.png');

histogram(degree01);
title('Гистограмма степень 0.1');
saveas(gcf, 'Degree\histogram_01.png');

histogram(degree045);
title('Гистограмма степень 0.45');
saveas(gcf, 'Degree\histogram_045.png');

histogram(degree5);
title('Гистограмма степень 5');
saveas(gcf, 'Degree\histogram_5.png');

%4
func_points = [0, 0; 25, 10; 45, 180; 250, 250];
x = func_points(:, 1);
y = func_points(:, 2);

kl_img = zeros(800, 800);

for i = 1:800
    for j = 1:800
        if img(i, j) <= x(1)
            kl_img(i, j) = img(i, j) * y(1) / x(1);
        elseif img(i, j) >= x(4)
            kl_img(i, j) = (img(i, j) - x(4) + y(4)) * (255-y(4)) / (255-x(4));
        else
            for k = 1:length(x)-1
                if img(i, j) >= x(k) && img(i, j) < x(k+1)
                    kl_img(i, j) = (img(i, j) - x(k) + y(k)) * (y(k+1) - y(k)) / (x(k+1) - x(k));
                    break;
                end
            end
        end
    end
end    

imshow(kl_img);
imwrite(kl_img, "Line_Contrast\kl_img.png");
histogram(kl_img);
title('Гистограмма лин-кус');
saveas(gcf, "Line_contrast\histogram_kl.png")

%5
equalized = histeq(img);
imwrite(equalized, 'Equaliz\equalized.png');

histogram(equalized);
title("Гистограмма эквализация")
saveas(gcf, 'Equaliz\histogram_equalized.png');

%6
mask3 = ones(3) / 3^2;
mask15 = ones(15) / 15^2;
mask35 = ones(35) / 35^2;

mask3_img = imfilter(img, mask3);
mask15_img = imfilter(img, mask15);
mask35_img = imfilter(img, mask35);

imwrite(mask3_img, 'Filter\mask3.png');
imwrite(mask15_img, 'Filter\mask15.png');
imwrite(mask35_img, 'Filter\mask35.png');

%7
sharped = imsharpen(img);
imwrite(sharped, 'Filter\sharped.png');

%8
median3 = medfilt2(img, [3 3]);
median9 = medfilt2(img, [9 9]);
median15 = medfilt2(img, [15 15]);

imwrite(median3, 'Median\median3.png');
imwrite(median9, 'Median\median9.png');
imwrite(median15, 'Median\median15.png');

%9
roberts = edge(img, 'roberts');
prewitt = edge(img, 'prewitt');
sobel = edge(img, 'sobel');

imwrite(roberts, 'Edge\roberts.png')
imwrite(prewitt, 'Edge\prewitt.png')
imwrite(sobel, 'Edge\sobel.png')

%10 var1
img_n = img + imnoise2('exponential', 800, 800, 2.75);

gauss = imgaussfilt(img_n);
median = medfilt2(img_n);
mean = imfilter(img_n, fspecial('average'));
bilateral = imbilatfilt(img_n);
charmonic = spfilt(img_n, 'chmean', 3, 3, 1.5);

v0 = var(img(:));
v_gauss = abs(v0 - var(double(gauss(:))));
v_median = abs(v0 - var(double(median(:))));
v_mean = abs(v0 - var(double(mean(:))));
v_bilateral = abs(v0 - var(double(bilateral(:))));
v_charmonic = abs(v0 - var(double(charmonic(:))));
min_v = min([v_gauss, v_median, v_mean, v_bilateral, v_charmonic]);

%Медианный фильтр 
imwrite(img_n, 'Filter\noisy_image.png');
imwrite(median, 'Filter\median_filtered11.png');
