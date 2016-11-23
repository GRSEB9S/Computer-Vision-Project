run('../../../vlfeat-0.9.20/toolbox/vl_setup.m');
I = imread('../Data/Classification/img1/img1.bmp');

%% try ingrammatory
load('../Data/Classification/img1/img1_inflammatory.mat');
% imshow(I);
% hold on;
patch = {size(detection,1)};
for i = 1:size(detection,1)
%     x = detection(i, 1);
%     y = detection(i, 2);
%     ang=0:0.1:2*pi; 
%     xp=13.5*cos(ang);
%     yp=13.5*sin(ang);
%     plot(x+xp, y+yp, 'r');
    patch{i} = I(max(round(x-13.5),1):min(round(x+13.5),size(I,1)), ...
                 max(round(y-13.5),1):min(round(y+13.5),size(I,2)), :);
end

% hold off;
[F,D] = vl_sift(im2single(patch{2}(:,:,1)));
imshow(patch{2});


%% Try fibroblast
load('../Data/Classification/img1/img1_fibroblast.mat');
patch = {size(detection,1)};
for i = 1:size(detection,1)
%     x = detection(i, 1);
%     y = detection(i, 2);
%     ang=0:0.1:2*pi; 
%     xp=13.5*cos(ang);
%     yp=13.5*sin(ang);
%     plot(x+xp, y+yp, 'r');
    patch{i} = I(max(round(x-13.5),1):min(round(x+13.5),size(I,1)), ...
                 max(round(y-13.5),1):min(round(y+13.5),size(I,2)), :);
end
[F,D] = vl_sift(im2single(patch{2}(:,:,1)));
imshow(patch{2});

