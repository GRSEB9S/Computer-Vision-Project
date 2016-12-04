clear all;
load('feature_color');
result = [];
for i = 19636:22440;
    tile_name = list(randind(i)).name;
    ind = regexp(tile_name, '_[0-9]+', 'match');
    pic_ind = ind(1);
    pic_ind = pic_ind{1};
    pic_ind = str2num(pic_ind(2:end));
    class_ind = ind(2);
    class_ind = class_ind{1};
    class_ind = str2num(class_ind(2:end));
    pic_path = strcat('../Data/Classification/img', int2str(pic_ind), '/img', int2str(pic_ind), '.bmp');
    I = imread(pic_path);
    I = padarray(I, [25 25], 'replicate'); % pad to prevent out of bound error


    if strncmpi(tile_name, 'epi', 3) == 1
        load(strcat('../Data/Classification/img', int2str(pic_ind), '/img', int2str(pic_ind), '_epithelial.mat'));
        true_out = 1;
    elseif strncmpi(tile_name, 'fib', 3) == 1
        load(strcat('../Data/Classification/img', int2str(pic_ind), '/img', int2str(pic_ind), '_fibroblast.mat'));
        true_out = 2;
    elseif strncmpi(tile_name, 'inf', 3) == 1
        load(strcat('../Data/Classification/img', int2str(pic_ind), '/img', int2str(pic_ind), '_inflammatory.mat'));
        true_out = 3;
    elseif strncmpi(tile_name, 'oth', 3) == 1
        load(strcat('../Data/Classification/img', int2str(pic_ind), '/img', int2str(pic_ind), '_others.mat'));
        true_out = 4;
    end

    center = round(detection(class_ind, :)) + 25;
    X = linspace(center(1)-3, center(1)+3, 7);
    Y = linspace(center(2)-3, center(2)+3, 7);
    one_hot = [0 0 0 0];
    for x = X
        for y = Y
            tile = I(y-13:y+13, x-13:x+13, :);
            desc = color_feature_descriptor(tile);
            dist1 = mean(pdist2(desc, feat1));
            dist2 = mean(pdist2(desc, feat2));
            dist3 = mean(pdist2(desc, feat3));
            dist4 = mean(pdist2(desc, feat4));
            [~, prediction] = min([dist1 dist2 dist3 dist4]);
            if [x y] == center
                one_hot(prediction) = one_hot(prediction) + 1;
            else
                one_hot(prediction) = one_hot(prediction) + 1/norm([x y]-center);
            end
        end
    end

    [~, w_prediction] = max(one_hot);
    if w_prediction == true_out
        result = [result 1];
    else
        result = [result 0];
    end
end