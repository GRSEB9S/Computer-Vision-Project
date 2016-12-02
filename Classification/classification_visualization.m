%run('../../../vlfeat-0.9.20/toolbox/vl_setup.m');
I = imread('../Data/Classification/img1/img1.bmp');
I = rgb2gray(I);
I = padarray(I,[13 13],220);

% feature contains all features of all four classes:
% feature{1}:inflammatory
% feature{2}:fibroblast
% feature{3}:epithelial
% feature{4}:others
feature = {4};

imshow(I);
hold on;

%% ingrammatory
load('../Data/Classification/img1/img1_inflammatory.mat');
%imshow(I);
%hold on;
patch = {size(detection,1)};
feature{1} = [];
for i = 1:size(detection,1)
    x = detection(i, 1)+13;
    y = detection(i, 2)+13;
    ang=0:0.1:2*pi; 
    xp=13.5*cos(ang);
    yp=13.5*sin(ang);
    plot(x+xp, y+yp, 'r');
    patch{i} = I(round(y-13):round(y+13), round(x-13):round(x+13));
    feature{1} = [feature{1}; hog_feature_vector(patch{i})];
%     subplot(1,size(detection,1),i);
%     imshow(patch{i});
end

%% fibroblast
load('../Data/Classification/img1/img1_fibroblast.mat');
%imshow(I);
%hold on;
patch = {size(detection,1)};
feature{2} = [];
for i = 1:size(detection,1)
    x = detection(i, 1)+13;
    y = detection(i, 2)+13;
    ang=0:0.1:2*pi; 
    xp=13.5*cos(ang);
    yp=13.5*sin(ang);
    plot(x+xp, y+yp, 'g');
    patch{i} = I(round(y-13):round(y+13), round(x-13):round(x+13));
    feature{2} = [feature{2}; hog_feature_vector(patch{i})];
%     subplot(1,size(detection,1),i);
%     imshow(patch{i});
end

%% epithelial
load('../Data/Classification/img1/img1_epithelial.mat');
%imshow(I);
%hold on;
patch = {size(detection,1)};
feature{3} = [];
for i = 1:size(detection,1)
    x = detection(i, 1)+13;
    y = detection(i, 2)+13;
    ang=0:0.1:2*pi; 
    xp=13.5*cos(ang);
    yp=13.5*sin(ang);
    plot(x+xp, y+yp, 'b');
    patch{i} = I(round(y-13):round(y+13), round(x-13):round(x+13));
    feature{3} = [feature{3}; hog_feature_vector(patch{i})];
%     subplot(1,size(detection,1),i);
%     imshow(patch{i});
end

%% others
load('../Data/Classification/img1/img1_others.mat');
%imshow(I);
%hold on;
patch = {size(detection,1)};
feature{4} = [];
for i = 1:size(detection,1)
    x = detection(i, 1)+13;
    y = detection(i, 2)+13;
    ang=0:0.1:2*pi; 
    xp=13.5*cos(ang);
    yp=13.5*sin(ang);
    plot(x+xp, y+yp, 'w');
    patch{i} = I(round(y-13):round(y+13), round(x-13):round(x+13));
    feature{4} = [feature{4}; hog_feature_vector(patch{i})];
%     subplot(1,size(detection,1),i);
%     imshow(patch{i});
end

%% fibroblast: use SIFT
%{
load('../Data/Classification/img1/img1_fibroblast.mat');
%imshow(I);
%hold on;
patch = {size(detection,1)};
F = {size(detection,1)};
D = {size(detection,1)};
for i = 1:size(detection,1)
    x = detection(i, 1);
    y = detection(i, 2);
    ang=0:0.1:2*pi; 
    xp=13.5*cos(ang);
    yp=13.5*sin(ang);
    plot(x+xp, y+yp, 'r');
    patch{i} = I(max(round(y-13.5),1):min(round(y+13.5),size(I,2)), ...
                 max(round(x-13.5),1):min(round(x+13.5),size(I,1)), :);
    [F{i},D{i}] = vl_sift(im2single(patch{i}(:,:,1)));
    subplot(1,size(detection,1),i);
    imshow(patch{i});
    hold on
    vl_plotframe(F{i});
end
%}