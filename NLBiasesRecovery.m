function [biases, A, w] = NLBiasesRecovery(l,surfaces,euler,rho,tau)
[~,n] = size(l);
s = surfaces;
for i=1:n
    Rs = Euler2Dcm(tau(i),0,0);
    Rs_tag(:,i) = Rs*[0;0;-1];
    Rins = Euler2Dcm(euler(:,i));
    c(i,:) = s(1:3,i)'*Rins;
end

% if its profiler - cant restore dz and rM(z) biases
if sum(tau) == 0 && var(tau) == 0
    profiler = 1;
else
    profiler = 0;
end

biases = 1;
[phi,kappa,omega,drho] = deal(0);
delta = zeros(3,1);
while sum(abs(biases)) > 0.0001 
    Rm = Euler2Dcm(omega,phi, kappa);
    r = Rm*Rs_tag;
    d = sum(c'.*r); 
    w = -((sum(s(1:3,:).*l) + s(4))+(c*delta)'+d.*(rho+drho))';%
    A = [c d' rho'.*(r(2,:)'.*c(:,1)-r(1,:)'.*c(:,2)) ...
         rho'.*(r(1,:)'.*c(:,3)-r(3,:)'.*c(:,1)) ...
         rho'.*(r(3,:)'.*c(:,2)-r(2,:)'.*c(:,3))];
     %[dx dx dz drho rM(z) rM(y) rM(x)] profiler cant restore dz and rM(z) biases
    if profiler
        A = A(:,[1 2 4 6 7]);
    end
%     A = A(:,[1 2 3 4 5 6]);
    biases = inv(A'*A)*A'*w;
    delta = delta + biases(1:3);
    drho = drho + biases(4);
    kappa = kappa + biases(5);
    phi = phi + biases(6);
    omega = omega + biases(7);
end
biases = [delta' drho kappa phi omega];

