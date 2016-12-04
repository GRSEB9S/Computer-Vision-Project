clear all;
list = dir('tiles');
list = list(4:end);
feat1 = []; 
feat2 = []; 
feat3 = []; 
feat4 = [];
randind = randperm(22444);
randind = randind(1:22440);

%%
for i = 1:10000
    tile = imread(strcat('tiles/', list(randind(i)).name));
    if strncmpi(list(randind(i)).name, 'epi', 3) == 1
        feat1 = [feat1; hog_feature_vector(tile)];
    elseif strncmpi(list(randind(i)).name, 'fib', 3) == 1
        feat2 = [feat2; hog_feature_vector(tile)];
    elseif strncmpi(list(randind(i)).name, 'inf', 3) == 1
        feat3 = [feat3; hog_feature_vector(tile)];
    elseif strncmpi(list(randind(i)).name, 'oth', 3) == 1
        feat4 = [feat4; hog_feature_vector(tile)];
    end
end

%%
result = [];
for i = 10000:11000
    tile = imread(strcat('tiles/', list(randind(i)).name));
    desc = hog_feature_vector(tile);
    if strncmpi(list(randind(i)).name, 'epi', 3) == 1
        true_out = 1;
    elseif strncmpi(list(randind(i)).name, 'fib', 3) == 1
        true_out = 2;
    elseif strncmpi(list(randind(i)).name, 'inf', 3) == 1
        true_out = 3;
    elseif strncmpi(list(randind(i)).name, 'oth', 3) == 1
        true_out = 4;
    end
    dist1 = mean(pdist2(desc, feat1));
    dist2 = mean(pdist2(desc, feat2));
    dist3 = mean(pdist2(desc, feat3));
    dist4 = mean(pdist2(desc, feat4));
    [~, prediction] = min([dist1 dist2 dist3 dist4]);
    if prediction == true_out
        result = [result 1];
    else
        result = [result 0];
    end
end