%% by Titterton, D. H.Weston, J. L. A. I. of A. and A. of E. E. (n.d.). Strapdown Inertial Navigation Technology. page 319
function Q = UpdateQ_N(Q_0,omega,delta_t)
sigma = norm(delta_t*omega);
if sigma == 0
    Q = Q_0;
    return;
end
r = [cos(sigma/2);...
    (sin(sigma/2)/sigma)*delta_t*omega(:)]';
Q = quatmultiply(Q_0,r);
Q = Q/quatnorm(Q);