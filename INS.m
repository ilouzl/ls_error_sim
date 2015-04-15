function R_N = INS(t)
phi = 0;
theta = 0;
psi = 0;
R_N = Euler2Clb(phi, theta, psi);