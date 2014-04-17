function [ W,D] = DNM_TR(A,B,d,dectype)
%DNM_TR - Decomposed Newton's method for trace ratio maximization

maxiter = 100;
tol = 1e-5;
llold = Inf;
ll = 0;
llarr = ll;
trr_arr = [];

% By default do a full decomposition and take the largest d values
if ~exist('a','var')
    dectype = 'full';
end

for i1 = 1:maxiter
    if (strcmpi(dectype,'partial'))
        [W D] = eigs(A-ll*B,d,'la');
        D = diag(D);
    else
        [W D] = eig(A-ll*B);
        D = diag(D);
        [sval sind] = sort(D,'descend');
        D = sval(1:d);
        W = W(:,sind(1:d));
    end
    
    betap = -diag(W'*B*W);
    
    llold = ll;
    ll = sum(llold*betap-D)/sum(betap);
    
    trr_arr = [trr_arr sum(diag(W'*A*W))/sum(diag(W'*B*W))];
%     
%     i1
    
    llarr = [llarr ll];
    if (i1 > 2)
        if (abs(ll-llold)/abs(llold) < tol)
            break;
        end
    end
end

if (strcmpi(dectype,'partial'))
    [W D] = eigs(A-ll*B,d,'la');
    D = diag(D);
else
    [W D] = eig(A-ll*B);
    D = diag(D);
    [sval sind] = sort(D,'descend');
    D = sval(1:d);
    W = W(:,sind(1:d));
end
% figure(1); plot(llarr,'r'); hold on; plot(trr_arr); hold off;
% legend('Lambda','Trace ratio');
end

