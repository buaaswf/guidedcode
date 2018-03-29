% example: guided feathering

close all;

% I = double(imread('.\img_feathering\toy.bmp')) / 255;
% p = double(rgb2gray(imread('.\img_feathering\toy-mask.bmp'))) / 255;
I = double(imread('.\depth\img_5001.png')) / 255;
%I = double(imread('.\depth\segmatation.png')) / 255;
I = imresize(I,[360 480]);
%I = cat(3, I, I, I);

p = double((imread('.\depth\depth_img_5001.png'))) / 255;


r = 20;
eps = 10^-6;

tic;
q = guidedfilter_color(I, p, r, eps);
toc;

s = 4;
tic;
q_sub = fastguidedfilter_color(I, p, r, eps, s);
toc;

figure();
imshow([I, repmat(p, [1, 1, 3]), repmat(q, [1, 1, 3]), repmat(q_sub, [1, 1, 3])], [0, 1]);
