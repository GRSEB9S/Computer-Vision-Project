function descriptor = gray_feature_descriptor(tile)
    %% calculate the dominant color descriptor for a tile
    descriptor = [];
    tile = rgb2gray(tile);
    for i = 0:8
        for j = 0:8
            block = tile(i*3+1:(i+1)*3, j*3+1:(j+1)*3, :);
            % for each block: descriptor = [[R],[G],[B]]
            for k = 1:1
                nomo = block(:,:,k);
                bin = [0,0,0,0,0,0,0,0];
                for x = 1:3
                    for y = 1:3
                        if nomo(x,y) >=0 && nomo(x,y) < 32
                            bin(1) = bin(1)+1;
                        elseif nomo(x,y) >=32 && nomo(x,y) < 64
                            bin(2) = bin(2)+1;
                        elseif nomo(x,y) >=64 && nomo(x,y) < 96
                            bin(3) = bin(3)+1;
                        elseif nomo(x,y) >=96 && nomo(x,y) < 128
                            bin(4) = bin(4)+1;
                        elseif nomo(x,y) >=128 && nomo(x,y) < 160
                            bin(5) = bin(5)+1;
                        elseif nomo(x,y) >=160 && nomo(x,y) < 192
                            bin(6) = bin(6)+1;
                        elseif nomo(x,y) >=192 && nomo(x,y) < 224
                            bin(7) = bin(7)+1;
                        elseif nomo(x,y) >=224 && nomo(x,y) < 256
                            bin(8) = bin(8)+1;
                        end
                    end
                end
                descriptor = [descriptor bin];
            end
        end
    end