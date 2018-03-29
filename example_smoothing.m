% example: edge-preserving smoothing

close all;

%I = double(imread('.\img_smoothing\cat.bmp')) / 255; % this image is too small to fully unleash the power of Fast GF
I = double(imread('E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic265\png\depth_img-10.21op2-p-015t000.png')) / 255;

p = I;
r = 4;
eps = 0.2^2; % try eps=0.1^2, 0.2^2, 0.4^2

tic;
q = guidedfilter(I, p, r, eps);
toc;

s = 4; % sampling ratio
tic;
q_sub = fastguidedfilter(I, p, r, eps, s);
toc;

figure();
imshow([I, q, q_sub], [0, 1]);
