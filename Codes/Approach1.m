% Approach 1 - Using the features directly for learning the regressor

% Set up directories
addpath(genpath('Common/'));

% Set up directories
dBase = 'Gnd'; % Choice: Gnd, A, B, C, D, E
imdir = ['Data/' dBase '/Crops/'];
if(strcmp(dBase, 'Gnd'))
    trdir = ['Data/' dBase '/Truth/'];
end
stdir = ['Store/' dBase '/'];


% Options
doProj = 1;
grMethod = 'SC'; % LR - Low Rank; SC - Sparse Coding
doReg = 1;

% Learn Discriminative Projections
projfile = [stdir 'Proj_' grMethod '.mat'];
if(doProj)
    learnProj(imdir,trdir,grMethod,projfile);
end

% Learn Regressor to estimate the glomerular number
regfile = [stdir 'Reg_' grMethod '_App1.mat'];
if(doReg)
    learnReg(imdir,trdir,projfile,regfile);
end

% Measure Glomerular Number for Test Images
count = estimateGN1(imdir,projfile,regfile);

fprintf('Estimated Glomerular Number = %d \n', sum(count));