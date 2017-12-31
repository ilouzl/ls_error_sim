function [biases, A, w] = BiasesRecovery(l,surfaces,euler,rho,tau)

[~,n] = size(l);
s=[];
for i=1:n
    surfaces(1:3,i) = surfaces(1:3,i);
    s(:,i) = [surfaces(1:2,i)' -1 surfaces(3,i)]';
    c(:,i) = s(1:3,i)'*Euler2Dcm(euler(:,i));
end

w = -(sum(s.*[l;ones(1,n)])'+ rho'.*(c(3,:)'-c(2,:)'.*tau'));
A = [c(1,:)' c(2,:)' c(3,:)' (tau(:).*c(2,:)'-c(3,:)')  ...
    -tau(:).*rho(:).*c(1,:)' -rho(:).*c(1,:)'  ...
    rho(:).*(c(2,:)'+tau(:).*c(3,:)')]; %[dx dx dz dr rM(z) rM(y) rM(x)] profiler cant restore dz and rM(z) biases

% if its profiler - cant restore dz and rM(z) biases
if sum(tau) == 0 && var(tau) == 0
    A = A(:,[1 2 4 6 7]);
end

biases = inv(A'*A)*A'*w

% corrcoef(A)
% eig(A'*A)