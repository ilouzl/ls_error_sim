function R_N = INS(t)
d2r = pi/180;
phi = 0*pi/180;
theta = 0*pi/180;
psi = 0*pi/180;
R_N = Euler2Dcm(phi, theta, psi);