function Cbn = INS(t)
d2r = pi/180;
phi = (-5+200*t)*0*pi/180;
theta = (-5+200*t)*0*pi/180;
psi = 0*t*pi/180;
Cbn = Euler2Dcm(phi, theta, psi);