close all; clc; clear all;
delta_rho = 0.2;
kappa = 0*pi/180;
phi = 0*pi/180;    % pitch bias [rad]
omega = 3*pi/180; 
alpha = 0*pi/180;
s = [-1 1 1 0]'; % surface [a,b,c,d]. ax + by + cz + d = 0;
v = [90;0;0];   % platform velocity
x0 = [0;0;1000]; % platform initial position
fp = 5000;      % laser pulse rate
fs = 10;      % laser scan rate
T = 0.1;        % simulation period
t = 0:1/fp:T;   % simulation time series
alpha = -linspace(-alpha,alpha,length(t));
x = repmat(x0,1,length(t)) + repmat(v,1,length(t)).*repmat(t,3,1);  % trajectory

Rins = eye(3);
Rm = Euler2Dcm(omega,phi, kappa);
Rs = eye(3);
r = Rm*Rs*[0;0;-1];
c = s(1:3)'*Rins;
d = c*r; 
rho = -(s(1:3)'*x + s(4)+d*delta_rho)/d;
plot(x(1,:),rho);
y = 1;
% hold on; plot(x(1,:),rho);
[phi,kappa,omega,delta_rho] = deal(0);
while sum(abs(y)) > 0.0001 
    Rins = eye(3);
    Rm = Euler2Dcm(omega,phi, kappa);
    Rs = eye(3);
    r = Rm*Rs*[0;0;-1];
    c = s(1:3)'*Rins;
    d = c*r; 
    w = -((s(1:3)'*x + s(4))+d*(rho+delta_rho))';%
    A = [ones(length(rho),1)*d rho'*(r(2)*c(1)-r(1)*c(2)) ...
         rho'*(r(1)*c(3)-r(3)*c(1)) rho'*(r(3)*c(2)-r(2)*c(3))];
    A = A(:,[1 4]);
    y = inv(A'*A)*A'*w;
    delta_rho = delta_rho + y(1)
%     kappa = kappa + y(2);
%     kappa*180/pi
%     phi = phi + y(2);
%     phi*180/pi
    omega = omega + y(2);
    omega*180/pi
end
figure
plot(phi*180/pi)
% plot(omega*180/pi)