function [V,D] = buildEmb(App, Ann, Apn, Anp, trpos, trneg, d)

trData = [trpos trneg];
T = size(trData,2);

% Compute L 
W = sparse(T,T);
W(1:T/2,1:T/2) = App;
W(T/2+1:T,T/2+1:T) = Ann;
L = (speye(T) - W)'*(speye(T) - W);

% Compute Lprime
Wpr = sparse(T,T);
Wpr(1:T/2,T/2+1:T) = Apn;
Wpr(T/2+1:T,1:T/2) = Anp;
Lpr = (speye(T) - Wpr)'*(speye(T) - Wpr);

A = trData*Lpr*trData'; B = trData*L*trData';
A = (A+A')/2; B = (B+B')/2;

% Compute discriminant directions
[V D] = DNM_TR(A,B,d,'full');
V = real(V); D = real(D);
