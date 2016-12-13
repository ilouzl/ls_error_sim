%% by Woodman, O. J. (2009). An introduction to inertial navigation. Arquivos de Neuro-Psiquiatria, 67(696), 961?2. https://doi.org/10.1017/S0373463300036341
function C = UpdateR_N(C_0,omega,delta_t)
sigma = norm(delta_t*omega);
if sigma == 0
    C = C_0;
    return;
end
B = SkewSymmetric(omega)*delta_t;
C = C_0*(eye(3) + (sin(sigma)/sigma)*B + ((1-cos(sigma))/(sigma^2))*B*B);