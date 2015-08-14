function [phi, theta, psi]= Dcm2Euler(C)
theta = -asin(C(1,3));
phi = atan2(C(2,3),C(3,3));
psi = atan2(C(1,2),C(1,1));

if nargout < 3
    phi = [phi, theta, psi]';
end