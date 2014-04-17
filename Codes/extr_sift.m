function extr_sift(imdir, feadir)

gridSpacing = 8;
patchSize = 8;
nrml_threshold = 1;

CalculateSiftDescriptor(imdir, feadir, gridSpacing, patchSize, nrml_threshold);