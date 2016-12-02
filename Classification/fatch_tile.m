clear all;
import_path = '../Data/Classification/img';

for i = 1:100
    I = imread(strcat(import_path, int2str(i), '/img', int2str(i), '.bmp'));
    I = padarray(I, [15 15], 'replicate'); % pad to prevent out of bound error

    %% process epithelial
    file_path = strcat(import_path, int2str(i), '/img', int2str(i), '_epithelial');
    save_name = strcat('epithelial_', int2str(i), '_');
    save_one_class(I, file_path, save_name);
    %% process fibroblast
    file_path = strcat(import_path, int2str(i), '/img', int2str(i), '_fibroblast');
    save_name = strcat('fibroblast_', int2str(i), '_');
    save_one_class(I, file_path, save_name);
    %% process inflammatory
    file_path = strcat(import_path, int2str(i), '/img', int2str(i), '_inflammatory');
    save_name = strcat('inflammatory_', int2str(i), '_');
    save_one_class(I, file_path, save_name);
    %% process others
    file_path = strcat(import_path, int2str(i), '/img', int2str(i), '_others');
    save_name = strcat('others_', int2str(i), '_');
    save_one_class(I, file_path, save_name);
end