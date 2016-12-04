function save_one_class(I, file_path, save_name)
    load(file_path);
    for j = 1: size(detection, 1)
        x = detection(j,1) + 15;
        y = detection(j,2) + 15;
        tile = I(round(y-13):round(y+13), round(x-13):round(x+13), :);
        tile = rgb2gray(tile);
        % save tile
        path = strcat('./tiles_gray/', save_name, int2str(j), '.jpg');
        imwrite(tile, path);
    end
end

