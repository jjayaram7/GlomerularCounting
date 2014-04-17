function [] = learnReg(imdir,trdir,projfile,regfile)

load(projfile);
numtr = 5;

fnames = dir(fullfile([imdir '*.bmp']));
gnames = dir(fullfile([trdir '*.bmp']));

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
    imtest = imread([imdir fnames(f).name]);
    imtest = im2double(imtest);
    immask = double(imtest > 0.2);
    immask = imfill(immask);
    imtest = imtest.*immask;
    
    pat = im2col(imtest,[bb,bb],'sliding');
    
    mind = find(pat(ceil(bb^2/2),:)~=0);
    teData = pat(:,mind);
    
    Xte_norm = sqrt(sum(double(teData).^2));
    teData = bsxfun(@times,double(teData),1./Xte_norm);
    
    tefea = V'*teData;
    
    % Build Graph
   
end

% Learn Regressor

save(regfile,'A','beta');


