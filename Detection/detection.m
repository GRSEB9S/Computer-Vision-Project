function detection()

    I = im2single(imread('../Data/Detection/img5/img5.bmp'));      % I in RGB color space
    load('../Data/Detection/img5/img5_detection.mat');


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

end
