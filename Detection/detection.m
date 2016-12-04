I = im2single(imread('../Data/Detection/img64/img64.bmp'));      % I in RGB color space
load('../Data/Detection/img64/img64_detection.mat');


figure;
imshow(I);
hold on;

%% 

HE = [1.48, -1.07; -0.16 1.12; 0.51 -0.28];

he_i = zeros([size(I,1), size(I,2), 2]);

for i=1:size(I,1)
    for j=1:size(I,2)
        p_ij = reshape(I(i, j, :), [1,3]); % to 1x3 vector
        p_he = p_ij * HE;
        he_i(i,j,:) = reshape(p_he, [1,1,2]);
    end
end

h = he_i(:,:,1) / 3;
e = he_i(:,:,2);

E = edge(imgradient(e), 'canny', 0.3);

hh = h;
hh(hh<0.5) = 0;

hh = imfilter(hh, fspecial('gauss'));
% e = edge(hh, 'canny', 0.7);

% a is voting image
dmin = 1; dmax = 5;

%%
a = zeros(size(E));
% have a mask for disk of size
[gridX, gridY] = meshgrid(1:size(E,1));

for i=1:size(I,1)
    for j=1:size(I,2)
        if E(i,j) % if edge here
            mask = createCirclesMask(E, [j, i], dmax);
            a = a + mask;
        end
    end
end
