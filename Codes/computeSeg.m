function [] = computeSeg(imdir,resdir,V)

fnames = dir(fullfile([imdir '/*.bmp']));

bb = 5;
for f = 1:length(fnames)   
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
    labte = kmeanspp(tefea,2);
    [val,cls] = sort([sum(labte==1) sum(labte==2)],'descend');
    
    labte(labte==cls(1)) = 0;
    labte(labte==cls(2)) = 1;
    
    imres = zeros(size(pat,2),1);
    imres(mind) = labte;
    
    imres = reshape(imres,[sqrt(size(pat,2)) sqrt(size(pat,2))]);       
         
    id = strfind(fnames(f).name,'_') - 1;
    h3 = figure(3); imshow(imres,[]);
    save([resdir fnames(f).name(1:id) '_seg'],'imres');
end


