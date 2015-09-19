function biases = BiasesRecovery(l,s,euler,rho)
% BiasesRecovery  - recover biases based on Filin's method
%   biases = MYPLUSFCN(A, B) adds matrices A and B.
%   OUT = MYPLUSFCN(A, B, C, ...) adds all the matrices
%         provided. All of the matrices must be either
%         the same size or mix of same-sized matrices
%         and scalars.
%
% Examples:
%   out = myPlusFcn(1:3, 5);
%
%   out = myPlusFcn(2, eye(3), rand(3), magic(3));
%
% See also PLUS, SUM.

[~,n] = size(l);
for i=1:n
    c(:,i) = s(1:3)*Euler2Dcm(euler(:,i));
end

w = rho'.*c(3,:)' -(s*[l;ones(1,n)])';
A = [c(1,:)' c(2,:)' c(3,:)' -rho'.*c(1,:)' rho'.*c(2,:)' -c(3,:)'];
A = [-c(3,:)'];
B = eye(n);
biases = inv(A'*A)*A'*w;