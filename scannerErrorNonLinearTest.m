close all; clc; clearvars;
% systematic errors
drho = 0.5;
kappa = 2*pi/180;
phi = 4*pi/180;    % pitch bias [rad]
omega = 3*pi/180; 
delta = [1 2 3]';
%scanner 
alpha = 15*pi/180;
fp = 5000;      % laser pulse rate
fs = 10;      % laser scan rate

%simulation
T = 0.1;        % simulation period
t = 0:1/fp:(T-1/fp);   % simulation time series
N = length(t);
%surfaces
s = [repmat([0 0 -1 0]',1,N/5)...
     repmat([1 0 -1 0]',1,N/5)...
     repmat([-1 0 -1 0]',1,N/5)...
     repmat([0 1 -1 0]',1,N/5)...
     repmat([0 -1 -1 0]',1,N/5)];
%platform
v = [90;0;0];   % platform velocity
x0 = [0;0;1000]; % platform initial position
x = repmat(x0,1,N) + repmat(v,1,N).*repmat(t,3,1);  % trajectory
euler = [0;0;0];
euler = repmat(euler,1,N);

% calculate range
alpha = -linspace(-alpha,alpha,N);
Rm = Euler2Dcm(omega,phi, kappa);
for i=1:N
    Rs = Euler2Dcm(alpha(i),0,0);
    Rs_tag(:,i) = Rs*[0;0;-1];
    Rins = Euler2Dcm(euler(:,i));
    c(i,:) = s(1:3,i)'*Rins;
end
r = Rm*Rs_tag;
d = sum(c'.*r); 
rho = -((sum(s(1:3,:).*x) + s(4)) +(c*delta)'+d*drho)./d;
plot(x(1,:),rho);

% recover biases
[biases] = NLBiasesRecovery(x,s ,euler,rho,alpha);
biases(1:4)
biases(5:7)*180/pi