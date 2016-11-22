I = imread('./Data/Classification/img1/img1.bmp');
load('./Data/Classification/img1/img1_inflammatory.mat');

figure;
imshow(I);
hold on;
for i = 1:size(detection,1)
    x = detection(i, 1);
    y = detection(i, 2);
    ang=0:0.1:2*pi; 
    xp=13.5*cos(ang);
    yp=13.5*sin(ang);
    plot(x+xp, y+yp, 'r');
end
