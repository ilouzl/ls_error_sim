close all; clc; clear all;
delta_rho = 0;
kappa = 0*pi/180;
phi = 1*pi/180;    % pitch bias [rad]
omega = 2*pi/180; 
alpha = 15*pi/180;
s = [1 1 -1 0]; % surface [a,b,c,d]. ax + by + cz + d = 0;
v = [90;0;0];   % platform velocity
x0 = [0;0;1000]; % platform initial position
fp = 5000;      % laser pulse rate
fs = 10;      % laser scan rate
T = 0.1;        % simulation period
t = 0:1/fp:T;   % simulation time series
alpha = -linspace(-alpha,alpha,length(t));
x = repmat(x0,1,length(t)) + repmat(v,1,length(t)).*repmat(t,3,1);  % trajectory
% rho = -(s(1:3)*x + s(4))./(s(1)*phi-s(2)*alpha + s(3)); % range = ([a,b,c]*x + d)/(b*phi+c)  . from geolocation equation
% rho = -(s(1:3)*x + s(4))./(-s(2)*(alpha+omega)+s(3)*(1+alpha*omega));
rho = (s(1:3)*x + s(4)+delta_rho.*(s(2)*alpha-s(3)))./(s(1)*(kappa*alpha+phi)+s(2)*(-omega-alpha)+s(3)*(1-alpha*omega));
plot(x(1,:),rho);


w = -(s(1:3)*x + s(4))+rho.*(s(3) - s(2)*alpha);
A = [s(2)*alpha'-s(3) -s(1)*alpha'.*rho' -s(1)*rho' rho'.*(s(2)+s(3)*alpha')];
% phi = -(s(1:3)*x + s(4)+s(3)*rho - s(2)*rho.*alpha)./(s(1)*rho);
% omega = (s(1:3)*x + s(4)+s(3)*rho)./(s(2)*rho-rho*s(3).*alpha);
A =  A(:,[3 4]);
biases = inv(A'*A)*A'*w'
biases*180/pi
figure
plot(phi*180/pi)
plot(omega*180/pi)