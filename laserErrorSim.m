clearvars; close all; clc;

run systematic_errors.m;
run LS_parameters.m;
run surface_definition.m;
run platform_parameters.m;

j = 1; % scan line
i = 0; % laser beam within scan
t=0;
surface=[];
ALS_loc = [];
ALS_scan=[];
e=[];
while t<0.5
    i = i+1;
    if i > n
        i=1;
        j = j+1;
    end
    t = (j-1)/f_s + (i-1)/f_p;
    tau_i = tau/2 - (i-1)*tau/(n-1);
    delta_tau_i = eps + delta_tau/2 - delta_tau*(i-1)/(n-1);
    delta_R_L = eye(3) + ...
        SkewSymmetric([delta_tau_i delta_phi delta_kappa]*pi/180); % scan angle errors
    R_L = Euler2Clb(-tau_i,0,0);
    R_N = INS(t);
    Rtag = R_N*R_M*R_L;
    t_GPS = GPS(t,v,t_GPS0);
    ALS_loc = [ALS_loc t_GPS];
    c = R_N*t_LG+t_GPS;
    [p s] = GetTrueFootprint(Rtag,c,surfaceDefinition);
    surface = [surface p];
    pstar = delta_R_N*R_N*(delta_R_M*R_M*delta_R_L*R_L*[0;0;(s+delta_r)]+t_LG+delta_t_LG)+t_GPS;
    ALS_scan = [ALS_scan pstar];
end
R_G = Euler2Clb(180,0,0);
ALS_scan = (ALS_scan'*R_G)';
surface = (surface'*R_G)';
ALS_loc = (ALS_loc'*R_G)';
ALS_err = ALS_scan-surface;
figure(1);
scatter3(surface(1,:),surface(2,:),surface(3,:),'.');hold on;
plot3(ALS_loc(1,:),ALS_loc(2,:),ALS_loc(3,:),'g');
scatter3(ALS_scan(1,:),ALS_scan(2,:),ALS_scan(3,:),'r','.');
xlabel('X'); ylabel('Y'); zlabel('Z');
legend({'surface','trajectory', 'scan'}); 

figure(2);
Scatter2Surf(ALS_scan(1,:),ALS_scan(2,:),ALS_scan(3,:));
hold on;
Scatter2Surf(surface(1,:),surface(2,:),surface(3,:));
legend({'scan','surface'}); 
