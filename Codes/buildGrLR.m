function [App, Ann, Apn, Anp] = buildGrLR(trpos,trneg)

lambda= 0.05;

% Compute App
X = trpos;
Dict = trpos;
Q = orth(Dict');
A = Dict*Q;
[Z,E] = lrra(X,A,lambda);
App = Q*Z;


% Compute Ann
X = trneg;
Dict = trneg;
Q = orth(Dict');
A = Dict*Q;
[Z,E] = lrra(X,A,lambda);
Ann = Q*Z;


% Compute Apn
X = trpos;
Dict = trneg;
Q = orth(Dict');
A = Dict*Q;
[Z,E] = lrra(X,A,lambda);
Apn = Q*Z;

% Compute Anp
X = trneg;
Dict = trpos;
Q = orth(Dict');
A = Dict*Q;
[Z,E] = lrra(X,A,lambda);
Anp = Q*Z;