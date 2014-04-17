function count = estimateGN2(feadir,regfile)

load(regfile);
fnames = dir(fullfile(feadir));

count = zeros(length(fnames));

for f = 1:numtr
    tefea = load([feadir fnames(f).name]);
    
    % Build Bag of words
    
    % Estimate the Glomerular number using the regressor
    
end