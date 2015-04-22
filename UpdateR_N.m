function C = UpdateR_N(C_0,omega,delta_t)
if delta_t == 0
    C = C_0;
    return;
end
sigma = norm(delta_t*omega);
B = SkewSymmetric(omega)*delta_t;
C = C_0*(eye(3) + (sin(sigma)/sigma)*B + ((1-cos(sigma))/(sigma^2))*B*B);