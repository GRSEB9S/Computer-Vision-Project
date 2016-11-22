I = imread('./Data/Detection/img1/img1.bmp');
load('./Data/Detection/img1/img1_detection.mat');

figure;
imshow(I);
hold on;

for i = 1:size(detection,1)
    x = detection(i, 1);
    y = detection(i, 2);
    ang=0:0.1:2*pi; 
    xp=7*cos(ang);
    yp=7*sin(ang);
    plot(x+xp, y+yp, 'r');
end