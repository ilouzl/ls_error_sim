clc; clear all;
syms phi theta xi;
% phi = 30;
% xi = 45;
% theta = 22;
Rx=[1 0 0; ...
    0 cos(phi) sin(phi);...
    0 -sin(phi) cos(phi)];
Ry=[cos(theta) 0 -sin(theta);...
    0 1 0;...
    sin(theta) 0 cos(theta)];
Rz=[cos(xi) sin(xi) 0;...
    -sin(xi) cos(xi) 0;...
    0 0 1];
U = Rx*Ry*Rz
disp('Calculate Un = U(10,20,40)');
Un = subs(U,[phi theta xi],[10 20 40])
[eVectors , eValues] = eig(Un);
eValues=round((1e10)*eValues)*1e-10;  %% round Numerical Inaccuracies
eValues=eValues*[1;1;1]
eVectors
eVectorOf1 = eVectors(:,[eValues == 1])
difference  = Un*eVectorOf1 - eVectorOf1;
difference=round((1e10)*difference)*1e-10  %% round Numerical Inaccuracies
