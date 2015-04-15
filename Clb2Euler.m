function [phi, theta, psi]= Clb2Euler(C)
theta = -asin(C(1,3))*180/pi;
phi = atan2(C(2,3),C(3,3))*180/pi;
psi = atan2(C(1,2),C(1,1))*180/pi;