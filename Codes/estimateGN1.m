function count = estimateGN1(imdir,projfile,regfile)

load(projfile);
load(regfile);
fnames = dir(fullfile([imdir '/*.bmp']));

count = zeros(length(fnames));

for f = 1:numtr
    imtest = imread([imdir '/' fnames(f).name]);
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
    
    % Build Graph and predict Glomerular Number   
    
end