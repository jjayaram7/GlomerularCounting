function [trpos,trneg] =  buildTrData(imdir,trdir)

trnames = dir(imdir);
trnames = trnames(3:end);
trpos = [];
trneg = [];
bb = 5;
numtr = 5;
numsamp = 1500;

for ind = 1:numtr
    imorig = imread([imdir trnames(ind).name]);
    imorig = im2double(imorig);
    
    immask = double(imorig > 0.1);
    immask = imfill(immask);
    imorig = imorig.*immask;
    
    figure(1);imshow(imorig,[]);
    %[roi imorig] = extractROI(imorig);
    title('');
    pat = im2col(imorig,[bb,bb],'sliding');
    mind = find(pat(ceil(bb^2/2),:)==0);
    pat(:,mind) = [];
    
    imgnd = imread([trdir trnames(ind).name]);
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
    im_pos = imresize(uint8(im_pos),[256 256]);
    patseg = im2col(im_pos,[bb,bb],'sliding');
    patseg(:,mind) = [];
    
    pind = find(patseg(ceil(bb*bb/2),:) == 1);
    temp = pat(:,pind);
    rp = randperm(size(temp,2));
    trpos = [trpos temp(:,rp(1:numsamp))];
    
    pat(:,pind) = [];
    rp = randperm(size(pat,2));
    trneg = [trneg pat(:,rp(1:numsamp))];
end