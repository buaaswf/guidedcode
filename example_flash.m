% example: flash/noflash denoising

close all;

% I = double(imread('.\img_flash\cave-flash.bmp')) / 255;
% p = double(imread('.\img_flash\cave-noflash.bmp')) / 255;
I = double(imread('E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\make3d\basic265\q\img-10.21op2-p-015t000.png')) / 255;

p = double(imread('E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic265\png\depth_img-10.21op2-p-015t000.png')) / 255;
I = imresize(I,[360 480]);
p = imresize(p,[360 480]);
I = cat(3, I, I, I);
p = cat(3, p, p, p);

r = 8;
eps = 0.02^2;

q = zeros(size(I));
tic;
q(:, :, 1) = guidedfilter(I(:, :, 1), p(:, :, 1), r, eps);
q(:, :, 2) = guidedfilter(I(:, :, 2), p(:, :, 2), r, eps);
q(:, :, 3) = guidedfilter(I(:, :, 3), p(:, :, 3), r, eps);
toc;

s = 4;
q_sub = zeros(size(I));
tic;
q_sub(:, :, 1) = fastguidedfilter(I(:, :, 1), p(:, :, 1), r, eps, s);
q_sub(:, :, 2) = fastguidedfilter(I(:, :, 2), p(:, :, 2), r, eps, s);
q_sub(:, :, 3) = fastguidedfilter(I(:, :, 3), p(:, :, 3), r, eps, s);
toc;

figure();
imshow([I, p, q, q_sub], [0, 1]);
