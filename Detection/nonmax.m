function filtered = nonmax(image, a)
% the a is the size of the disk filter

	% domain is a 2a+1 square matrix
	domain = fspecial('disk', a) > 0;
	
	% we are finding the strongest value
	filtered = ordfilt2(image, 2*a+1, domain);
    % filtered = (filtered == image) & (filtered < 0.2);
end
