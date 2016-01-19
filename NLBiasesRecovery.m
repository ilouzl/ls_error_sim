function [biases, A, w] = NLBiasesRecovery(l,surfaces,euler,rho,tau)
[~,n] = size(l);
for i=1:n
    Rs = Euler2Dcm(tau(i),0,0);
    Rs_tag(:,i) = Rs*[0;0;-1];
    Rins = Euler2Dcm(euler(:,i));
    s(:,i) = [surfaces(1:2,i)' -1 surfaces(3,i)]';
    c(i,:) = s(1:3,i)'*Rins;
end


biases = 1;
[phi,kappa,omega,delta_rho] = deal(0);
while sum(abs(biases)) > 0.0001 
    Rm = Euler2Dcm(omega,phi, kappa);
    r = Rm*Rs_tag;
    d = sum(c'.*r); 
    w = -((sum(s(1:3,:).*l) + s(4))+d.*(rho+delta_rho))';%
    A = [d' rho'.*(r(2,:)'.*c(:,1)-r(1,:)'.*c(:,2)) ...
         rho'.*(r(1,:)'.*c(:,3)-r(3,:)'.*c(:,1)) ...
         rho'.*(r(3,:)'.*c(:,2)-r(2,:)'.*c(:,3))];
    A = A(:,[1 2 4]);
    biases = inv(A'*A)*A'*w;
    delta_rho = delta_rho + biases(1);
    kappa = kappa + biases(2);
%     phi = phi + biases(3);
    omega = omega + biases(3);
end
biases = [delta_rho kappa phi omega];

