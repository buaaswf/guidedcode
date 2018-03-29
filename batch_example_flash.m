% example: flash/noflash denoising

close all;



pathimg='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\Test134\';
pathimg='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\rgb\0018\fog\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\1104_png\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\result\result\'
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic265\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic288\make3daugbasic288\png\';
pathdepth ='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\ccnn\vkitti_fog\png\';
pathdepth ='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\output\ccnn\fog\seg\subq\';
%pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic265\png\';
pathsegmentaion='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\make3dseg\labels2imgs2\labels2imgs2\regions\';
pathsegmentaion='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\make3d\basic265\seg\q\';
pathsegmentaion='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\make3d\basic288\seg\q\';

imagefiles = dir(strcat(pathimg,'*.png'));  %F:\reid\wild  
%imagefiles = dir('F:\reid\SSGoDec\SSGoDec\SSGoDec\picture\*.bmp');
nfiles = length(imagefiles);    % Number of files found
%imageMatrix = uint8(zeros(144,176,nfiles));
%headname='depth_'
headname=''
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    test = extractBetween(currentfilename,1,length(currentfilename)-length('.png'));
    test = test{1};
    currentfilenamenotail = strcat(test,'.png');
    I = imread(strcat(pathimg,currentfilename));
    I = double(imresize(I,[360 480]))/255;
    temp=strcat(pathdepth,strcat(headname',currentfilenamenotail));
    flag = exist(strcat(pathdepth,strcat(headname,currentfilenamenotail)));
   %I = double(imread(strcat(pathsegmentaion,currentfilename))) / 255;
%    I = imresize(I,[360 480]);
   %I = double(imread('.\depth\segmatation.png')) / 255;

   %p = double((imread('.\depth\depth_img_5001.png'))) / 255;
%    temp=strcat(pathdepth,strcat('depth_',currentfilename));
%    flag = exist(strcat(pathdepth,strcat('depth_',currentfilename)));
%    if flag ==2
%        %error(display(strcat(pathdepth,strcat('depth_',currentfilename))));
%        p = double((imread(strcat(pathdepth,strcat('depth_',currentfilename))))) / 255;

     if flag == 2
           %error(display(strcat(pathdepth,strcat('depth_',currentfilename))));
           p = double((imread(strcat(pathdepth,strcat(headname,currentfilenamenotail))))) / 255;
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
%            imwrite(q(:,:,1),strcat('output\make3d\basic288\imgflash\img\q\',currentfilenamenotail));
%            imwrite(q_sub(:,:,1),strcat('output\make3d\basic288\imgflash\img\subq\',currentfilenamenotail));
           imwrite(q(:,:,1),strcat('output\kitti\output\ccnn\fog\imgflash\seg\q\',currentfilenamenotail));
           imwrite(q_sub(:,:,1),strcat('output\kitti\output\ccnn\fog\imgflash\seg\subq\',currentfilenamenotail));
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
