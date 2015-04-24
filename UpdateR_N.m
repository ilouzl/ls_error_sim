%% by Woodman 2009  
function C = UpdateR_N(C_0,omega,delta_t)
sigma = norm(delta_t*omega);
if sigma == 0
    C = C_0;
    return;
end
B = SkewSymmetric(omega)*delta_t;
C = C_0*(eye(3) + (sin(sigma)/sigma)*B + ((1-cos(sigma))/(sigma^2))*B*B);