clear all;
import_path = '../Data/Detection/img';

for i = 1:100
    I = imread(strcat(import_path, int2str(i), '/img', int2str(i), '.bmp'));
    I = padarray(I, [15 15], 'replicate'); % pad to prevent out of bound error

    %% process epithelial
    file_path = strcat(import_path, int2str(i), '/img', int2str(i), '_detection');
    save_name = strcat(int2str(i), '_');
    save_one_class(I, file_path, save_name);
end