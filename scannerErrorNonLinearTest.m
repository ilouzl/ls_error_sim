close all; clc;
phi = 2*pi/180;    % pitch bias [rad]
omega = 2*pi/180;
s = [-1 0 1 0]; % surface [a,b,c,d]. ax + by + cz + d = 0;
v = [90;0;0];   % platform velocity
x0 = [0;0;1000]; % platform initial position
fs = 5000;      % laser scan rate
T = 0.1;        % simulation period
t = 0:1/fs:T;   % simulation time series
x = repmat(x0,1,length(t)) + repmat(v,1,length(t)).*repmat(t,3,1);  % trajectory
rho = (s(1:3)*x + s(4))/(s(1)*sin(phi)+s(3)*cos(phi)); % range = ([a,b,c]*x + d)/(b*phi+c)  . from geolocation equation
% rho = (s(1:3)*x + s(4))/(-s(2)*omega+s(3));
plot(x(1,:),rho);

% hold on; plot(x(1,:),rho);
phi = 0;
w = (s(1:3)*x + s(4))';
dphi = 1;
while abs(dphi) > 0.00001
    W = w-(rho*(s(1)*sin(phi) + s(3)*cos(phi)))';
    A = (rho*(s(1)*cos(phi) - s(3)*sin(phi)))';
    dphi = inv(A'*A)*A'*W;
    phi = phi + dphi
end
% omega = (s(1:3)*x + s(4)-s(3)*rho)./(-s(2)*rho);
figure
plot(phi*180/pi)
% plot(omega*180/pi)