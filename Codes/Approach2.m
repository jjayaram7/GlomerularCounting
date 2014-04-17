% Approach 2 - Cluster features into a binary image and learn a regressor
% Set up directories
addpath(genpath('Common/'));

% Set up directories
dBase = 'Gnd'; % Choice: Gnd, A, B, C, D, E
imdir = ['Data/' dBase '/Crops/'];
if(strcmp(dBase, 'Gnd'))
    trdir = ['Data/' dBase '/Truth/'];
end
stdir = ['Store/' dBase '/'];
resdir = ['SegResults/' dBase '/'];
feadir = ['Features/' dBase '/'];


% Options
doProj = 0;
doSeg = 0;
doSift = 0;
doReg = 1;
grMethod = 'SC'; % LR - Low Rank; SC - Sparse Coding

% Learn Discriminative Projections
projfile = [stdir 'Proj_' grMethod '.mat'];
if(doProj)
    learnProj(imdir,trdir,grMethod,projfile);
end

% Obtain segmented images
if(doSeg)
    load(projfile);
    computeSeg(imdir,resdir,V);
end

% Compute SIFT features
if(doSift)
    extr_sift(resdir, feadir);
end

% Load Regressors
regfile = [stdir 'Reg_' grMethod '_App2.mat'];
if(doReg)
    learnRegBin(trdir,feadir,projfile,regfile);
end

% Measure Glomerular Number for Test Images
count = estimateGN2(feadir,regfile);

fprintf('Estimated Glomerular Number = %d \n', sum(count));
