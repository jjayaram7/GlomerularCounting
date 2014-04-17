function [] = learnProj(imdir,trdir,grMethod,projfile)

fprintf('Building training data set... \n');

[trpos,trneg] = buildTrData(imdir,trdir);


fprintf('Building Graph Affnities... \n');

if strcmp(grMethod,'SC')
    [App, Ann, Apn, Anp] = buildGrSC(trpos,trneg);
else
    [App, Ann, Apn, Anp] = buildGrLR(trpos,trneg);
end


fprintf('Computing Discriminative Projections... \n');

d = 10;
[V,D] = buildEmb(App, Ann, Apn, Anp, trpos, trneg, d);
save(projfile,'labels','V');