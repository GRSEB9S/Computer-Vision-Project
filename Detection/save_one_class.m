function save_one_class(I, file_path, save_name)
    load(file_path);
    for j = 1: size(detection, 1)
        x = detection(j,1) + 15;
        y = detection(j,2) + 15;
        tile = I(round(y-13):round(y+13), round(x-13):round(x+13), :);
        % save tile
        path = strcat('../Data/Detection/tiles/', save_name, int2str(j), '.jpg');
        imwrite(tile, path);
        
        x = ceil(rand(1) * 499 + 15);
        y = ceil(rand(1) * 499 + 15);
        tile = I(round(y-13):round(y+13), round(x-13):round(x+13), :);
        path = strcat('../Data/Detection/tiles/', save_name, int2str(j), '_f.jpg');
        imwrite(tile, path);
    end
end

