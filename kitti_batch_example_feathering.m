% example: guided feathering

close all;

pathimg='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\Test134\';
%pathimg='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\rgb\0018\15-deg-left\';
pathimg='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\rgb\0018\fog\';

pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\1104_png\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\result\result\'
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daug98k\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic288\make3daugbasic288\png\';
pathdepth ='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\png\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\ccnn\vkitti_fog\png\';
pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\frcn\frcn\fog\';
%pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\15-deg-left\15-deg-left\';
%pathdepth='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\depthdatamake3d\make3daugbasic265\png\';
pathsegmentaion='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\make3dseg\labels2imgs2\labels2imgs2\regions\';
pathsegmentation='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\semantic\0018\15-deg-left\';
pathsegmentation='E:\code\fast-guided-filter-code-v1\fast-guided-filter-code-v1\output\kitti\semantic\0018\fog\';
% %imagefiles = dir('H:\reid\0001\0001\*.jpg');  %F:\reid\wild    
imagefiles = dir(strcat(pathimg,'*.png'));  %F:\reid\wild  
% %imagefiles = dir('F:\reid\SSGoDec\SSGoDec\SSGoDec\picture\*.bmp');
nfiles = length(imagefiles);    % Number of files found
% %imageMatrix = uint8(zeros(144,176,nfiles));
%headname='depth_'
headname=''
for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    test = extractBetween(currentfilename,1,length(currentfilename)-4);
    test = test{1};
    currentfilenamenotail = strcat(test,'.png');
    I = imread(strcat(pathimg,currentfilename));
    I = double(imresize(I,[360 480]))/255;
    temp=strcat(pathdepth,strcat(headname',currentfilenamenotail));
    flag = exist(strcat(pathdepth,strcat(headname,currentfilenamenotail)));
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
           p = double((imread(strcat(pathdepth,strcat(headname,currentfilenamenotail))))) / 255;
           p = imresize(p,[360 480]);


           r = 20;
           eps = 10^-6;

           tic;
           q = guidedfilter_color(I, p, r, eps);
           toc;
           %imwrite(q,strcat('output\make3d\basic288\img\q\',currentfilenamenotail));
           %imwrite(q,strcat('output\kitti\output\15-deg-left\seg\q\',currentfilenamenotail));
           imwrite(q,strcat('output\kitti\output\frcn\fog\img\q\',currentfilenamenotail));

           s = 4;
           tic;
           q_sub = fastguidedfilter_color(I, p, r, eps, s);
           toc;
           imwrite(q_sub,strcat('output\kitti\output\frcn\fog\img\subq\',currentfilenamenotail));
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imagefiles = dir(strcat(pathsegmentaion,'*.jpg'));  %F:\reid\wild  
% %imagefiles = dir('F:\reid\SSGoDec\SSGoDec\SSGoDec\picture\*.bmp');
% nfiles = length(imagefiles);    % Number of files found
% %imageMatrix = uint8(zeros(144,176,nfiles));
% headname='depth_'
% %headname=''
% for ii=1:nfiles
%     currentfilename = imagefiles(ii).name;
%     test = extractBetween(currentfilename,1,length(currentfilename)-length('-resized.jpg'));
%     test = test{1};
%     currentfilenamenotail = strcat(test,'.png');
%     I = imread(strcat(pathsegmentaion,currentfilename));
%     I = double(imresize(I,[360 480]))/255;
%     temp=strcat(pathdepth,strcat(headname',currentfilenamenotail));
%     flag = exist(strcat(pathdepth,strcat(headname,currentfilenamenotail)));
%    %I = double(imread(strcat(pathsegmentaion,currentfilename))) / 255;
% %    I = imresize(I,[360 480]);
%     I = cat(3, I, I, I);
%    %I = double(imread('.\depth\segmatation.png')) / 255;
% 
%    %p = double((imread('.\depth\depth_img_5001.png'))) / 255;
% %    temp=strcat(pathdepth,strcat('depth_',currentfilename));
% %    flag = exist(strcat(pathdepth,strcat('depth_',currentfilename)));
% %    if flag ==2
% %        %error(display(strcat(pathdepth,strcat('depth_',currentfilename))));
% %        p = double((imread(strcat(pathdepth,strcat('depth_',currentfilename))))) / 255;
% 
%      if flag == 2
%            %error(display(strcat(pathdepth,strcat('depth_',currentfilename))));
%            p = double((imread(strcat(pathdepth,strcat(headname,currentfilenamenotail))))) / 255;
%            p = imresize(p,[360 480]);
% 
% 
%            r = 4;
%            eps = 10^-6;
% 
%            tic;
%            q = guidedfilter_color(I, p, r, eps);
%            toc;
%            imwrite(q,strcat('output\make3d\basic288\seg\q\',currentfilenamenotail));
% 
%            s = 4;
%            tic;
%            q_sub = fastguidedfilter_color(I, p, r, eps, s);
%            toc;
%            imwrite(q_sub,strcat('output\make3d\basic288\seg\subq\',currentfilenamenotail));
%       end
%    
% % 
% %    figure();
% %    imshow([I, repmat(p, [1, 1, 3]), repmat(q, [1, 1, 3]), repmat(q_sub, [1, 1, 3])], [0, 1]);
% %    imshow([I, repmat(p, [1, 1, 3]), repmat(q, [1, 1, 3]), repmat(q_sub, [1, 1, 3])], [0, 1]);
% %   currentimage = imread(strcat('F:\reid\SSGoDec\SSGoDec\SSGoDec\picture\',currentfilename));
% %    currentimage = imresize(currentimage, [360,480]);
% %    currentimage =rgb2gray(currentimage);
% %    imageMatrix(:,:,ii) = currentimage;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% I = double(imread('.\img_feathering\toy.bmp')) / 255;
% p = double(rgb2gray(imread('.\img_feathering\toy-mask.bmp'))) / 255;
% I = double(imread('.\depth\img_5001.png')) / 255;
% I = double(imread('.\depth\segmatation.png')) / 255;
% I = imresize(I,[360 480]);
% I = cat(3, I, I, I);
% 
% p = double((imread('.\depth\depth_img_5001.png'))) / 255;
% 
% 
% r = 20;
% eps = 10^-6;
% 
% tic;
% q = guidedfilter_color(I, p, r, eps);
% toc;

% s = 4;
% tic;
% q_sub = fastguidedfilter_color(I, p, r, eps, s);
% toc;
% 
% figure();
% imshow([I, repmat(p, [1, 1, 3]), repmat(q, [1, 1, 3]), repmat(q_sub, [1, 1, 3])], [0, 1]);
