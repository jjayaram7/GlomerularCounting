function [App, Ann, Apn, Anp] = buildGrSC(trpos,trneg)

param.lambda = 0.1;
param.numThreads = -1;
param.mode = 2;
param.pos = 1;

% Compute App
X = trpos;
Dict = trpos;
N = size(X,2);

CMat = zeros(N,N);
for i = 1:N
    CMat([1:i-1 i+1:N],i) = mexLasso(X(:,i),[Dict(:,1:i-1)...
        Dict(:,i+1:N)],param);
end
App = BuildAdjacency(CMat,0);

% Compute Ann
X = trneg;
Dict = trneg;
N = size(X,2);

CMat = zeros(N,N);
for i = 1:N
    CMat([1:i-1 i+1:N],i) = mexLasso(X(:,i),[Dict(:,1:i-1)...
        Dict(:,i+1:N)],param);
end
Ann = BuildAdjacency(CMat,0);


% Compute Apn
X = trpos;
Dict = trneg;
N = size(X,2);
K = size(Dict,2);

CMat = zeros(K,N);
for i = 1:N
    CMat(:,i) = mexLasso(X(:,i),Dict,param);
end
Apn = BuildAdjacency(CMat,0);

% Compute Anp
X = trneg;
Dict = trpos;
N = size(X,2);
K = size(Dict,2);

CMat = zeros(K,N);
for i = 1:N
    CMat(:,i) = mexLasso(X(:,i),Dict,param);
end
Anp = BuildAdjacency(CMat,0);