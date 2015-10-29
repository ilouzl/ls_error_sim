function Cbn = INS(t)
d2r = pi/180;
phi = 5*t*pi/180;
theta = 5*t*pi/180;
psi = 5*t*pi/180;
Cbn = Euler2Dcm(phi, theta, psi);