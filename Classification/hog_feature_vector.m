function [feature] = hog_feature_vector(im)
% INPUT => im (input tile)
% OUTPUT => HOG feature vector for that tile

% Convert RGB iamge to grayscale
if size(im,3)==3
    im=rgb2gray(im);
end
im=double(im);

rows=size(im,1);
cols=size(im,2);

% use central gradient as suggested in the paper
[Ix, Iy] = imgradientxy(im, 'central');

angle=atand(Ix./Iy); % Matrix containing the angles of each edge gradient
angle=imadd(angle,90); %Angles in range (0,180)
magnitude=sqrt(Ix.^2 + Iy.^2);

% Remove NAN in angles. 
angle(isnan(angle))=0;
magnitude(isnan(magnitude))=0;

feature=[]; %initialized the feature vector

% Iterations for Blocks, block size = 9*9
for i = 0: rows/3 - 3
    for j= 0: cols/3 - 3
        mag_patch = magnitude(3*i+1 : 3*i+9 , 3*j+1 : 3*j+9);
        ang_patch = angle(3*i+1 : 3*i+9 , 3*j+1 : 3*j+9);
        
        block_feature=[];
        
        %Iterations for cells in a block, 3x3 cells per block
        %Each cell: 3x3 pixels
        for x= 0:2
            for y= 0:2
                angleA =ang_patch(3*x+1:3*x+3, 3*y+1:3*y+3);
                magA   =mag_patch(3*x+1:3*x+3, 3*y+1:3*y+3); 
                histr  =zeros(1,9);
                
                %Iterations for pixels in one cell
                for p=1:3
                    for q=1:3
                        
                        alpha= angleA(p,q);
                        
                        % Binning Process (Bi-Linear Interpolation)
                        if alpha>10 && alpha<=30
                            histr(1)=histr(1)+ magA(p,q)*(30-alpha)/20;
                            histr(2)=histr(2)+ magA(p,q)*(alpha-10)/20;
                        elseif alpha>30 && alpha<=50
                            histr(2)=histr(2)+ magA(p,q)*(50-alpha)/20;                 
                            histr(3)=histr(3)+ magA(p,q)*(alpha-30)/20;
                        elseif alpha>50 && alpha<=70
                            histr(3)=histr(3)+ magA(p,q)*(70-alpha)/20;
                            histr(4)=histr(4)+ magA(p,q)*(alpha-50)/20;
                        elseif alpha>70 && alpha<=90
                            histr(4)=histr(4)+ magA(p,q)*(90-alpha)/20;
                            histr(5)=histr(5)+ magA(p,q)*(alpha-70)/20;
                        elseif alpha>90 && alpha<=110
                            histr(5)=histr(5)+ magA(p,q)*(110-alpha)/20;
                            histr(6)=histr(6)+ magA(p,q)*(alpha-90)/20;
                        elseif alpha>110 && alpha<=130
                            histr(6)=histr(6)+ magA(p,q)*(130-alpha)/20;
                            histr(7)=histr(7)+ magA(p,q)*(alpha-110)/20;
                        elseif alpha>130 && alpha<=150
                            histr(7)=histr(7)+ magA(p,q)*(150-alpha)/20;
                            histr(8)=histr(8)+ magA(p,q)*(alpha-130)/20;
                        elseif alpha>150 && alpha<=170
                            histr(8)=histr(8)+ magA(p,q)*(170-alpha)/20;
                            histr(9)=histr(9)+ magA(p,q)*(alpha-150)/20;
                        elseif alpha>=0 && alpha<=10
                            histr(1)=histr(1)+ magA(p,q)*(alpha+10)/20;
                            histr(9)=histr(9)+ magA(p,q)*(10-alpha)/20;
                        elseif alpha>170 && alpha<=180
                            histr(9)=histr(9)+ magA(p,q)*(190-alpha)/20;
                            histr(1)=histr(1)+ magA(p,q)*(alpha-170)/20;
                        end  
                    end
                end
                block_feature=[block_feature histr]; % Concatenation of Four histograms to form one block feature           
            end
        end
        % Normalize the values in the block using L1-Norm
        % block_feature=block_feature/sqrt(norm(block_feature)^2+.01);

        feature=[feature block_feature]; %Features concatenation
    end
end

feature(isnan(feature))=0; %Removing Infinitiy values

% Normalization of the feature vector using L2-Norm
% feature=feature/sqrt(norm(feature)^2+.001);
% for z=1:length(feature)
%     if feature(z)>0.2
%          feature(z)=0.2;
%     end
% end
feature=feature/sqrt(norm(feature)^2+.001);        
      