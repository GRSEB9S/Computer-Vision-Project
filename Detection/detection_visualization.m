I = imread('../Data/Detection/img5/img5.bmp');
load('../Data/Detection/img5/img5_detection.mat');

figure;
I = I(:,:,1);
imshow(I);
hold on;

%%
K = imadjust(I,[0.2 0.6],[]);
figure;
imshow(K);
hold on;

for i = 1:size(detection,1)
    x = detection(i, 1);
    y = detection(i, 2);
    ang=0:0.1:2*pi; 
    xp=7*cos(ang);
    yp=7*sin(ang);
    plot(x+xp, y+yp, 'r', 'LineWidth',3);
end

%%
im = im2single(K);
[F,D] = vl_sift(im);
vl_plotframe(F);