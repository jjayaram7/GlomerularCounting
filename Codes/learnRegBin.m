function [] = learnRegBin(trdir,feadir,projfile,regfile)

load(projfile);
numtr = 5;

fnames = dir(fullfile(feadir));
gnames = dir(fullfile([trdir '/*.bmp']));

bb = 5;
for f = 1:numtr
    % Measure Glomerular Number From Ground Truth
    imgnd = imread([trdir gnames(f).name]);
    [m n c] = size(imgnd);
    im_pos = zeros(m,n);
    
    map1 = [237; 28; 36];
    for i1 = 1:m
        for i2 = 1:n
            if prod(double(reshape(imgnd(i1,i2,:),3,1) == map1))
                im_pos(i1,i2) = 1;
            end
        end
    end
    im_pos= imresize(uint8(im_pos),[256 256]);
    count(f) = blobcount(im_pos);
    
    % Compute Embedding for the Corresponding Image
    tefea = load([feadir fnames(f).name]);
    
    % Build Bag-of-Words using the SIFT features
   
end

% Learn Regressor

save(regfile,'A','beta');


