% example: guided feathering

close all;

pathimg='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\images_224\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\1104_png\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\q\';
pathsegmentaion='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\semantic_224\';
%imagefiles = dir('H:\reid\0001\0001\*.jpg');  %F:\reid\wild    
imagefiles = dir(strcat(pathimg,'*.png'));  %F:\reid\wild  
%imagefiles = dir('F:\reid\SSGoDec\SSGoDec\SSGoDec\picture\*.bmp');
nfiles = length(imagefiles);    % Number of files found
%imageMatrix = uint8(zeros(144,176,nfiles));
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    I = imread(strcat(pathimg,currentfilename));
    I = double(imresize(I,[360 480]))/255;
    temp=strcat(pathdepth,strcat('',currentfilename));
    flag = exist(strcat(pathdepth,strcat('',currentfilename)));
   %I = double(imread(strcat(pathsegmentaion,currentfilename))) / 255;
%    I = imresize(I,[360 480]);
%    I = cat(3, I, I, I);
   %I = double(imread('.\depth\segmatation.png')) / 255;

   %p = double((imread('.\depth\depth_img_5001.png'))) / 255;
%    temp=strcat(pathdepth,strcat('depth_',currentfilename));
%    flag = exist(strcat(pathdepth,strcat('depth_',currentfilename)));
%    if flag ==2
%        %error(display(strcat(pathdepth,strcat('depth_',currentfilename))));
%        p = double((imread(strcat(pathdepth,strcat('depth_',currentfilename))))) / 255;

     if flag == 2
           %error(display(strcat(pathdepth,strcat('depth_',currentfilename))));
           p = double((imread(strcat(pathdepth,strcat('',currentfilename))))) / 255;


           r = 20;
           eps = 10^-6;

           tic;
           q = guidedfilter_color(I, p, r, eps);
           toc;
           imwrite(q,strcat('output\seg_img\q\',currentfilename));

           s = 4;
           tic;
           q_sub = fastguidedfilter_color(I, p, r, eps, s);
           toc;
           imwrite(q_sub,strcat('output\seg_img\subq\',currentfilename));
      end
   
% 
%    figure();
%    imshow([I, repmat(p, [1, 1, 3]), repmat(q, [1, 1, 3]), repmat(q_sub, [1, 1, 3])], [0, 1]);
%    imshow([I, repmat(p, [1, 1, 3]), repmat(q, [1, 1, 3]), repmat(q_sub, [1, 1, 3])], [0, 1]);
%   currentimage = imread(strcat('F:\reid\SSGoDec\SSGoDec\SSGoDec\picture\',currentfilename));
%    currentimage = imresize(currentimage, [360,480]);
%    currentimage =rgb2gray(currentimage);
%    imageMatrix(:,:,ii) = currentimage;
end
% I = double(imread('.\img_feathering\toy.bmp')) / 255;
% p = double(rgb2gray(imread('.\img_feathering\toy-mask.bmp'))) / 255;
I = double(imread('.\depth\img_5001.png')) / 255;
I = double(imread('.\depth\segmatation.png')) / 255;
I = imresize(I,[360 480]);
I = cat(3, I, I, I);

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
