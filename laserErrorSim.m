clearvars; close all; clc; clear INSfile.m;

systematic_errors;
LS_parameters;
surface_definition;
platform_parameters;


external_INS = 1;

j = 1; % scan line
i = 0; % laser beam within scan
t=0;
surface=[];
ALS_loc = [];
ALS_scan=[];
e=[];
Cned2enu = Euler2Dcm(pi,0,pi/2);
while t<5
    i = i+1;
    if i > n
        i=1;
        j = j+1;
    end
    t = (j-1)/f_s + (i-1)/f_p;              % calculate time by line and pulse indices
    tau_i = tau/2 - (i-1)*tau/(n-1);        % instntaneous laser angle
    delta_tau_i = eps + delta_tau/2 - delta_tau*(i-1)/(n-1); % instntaneous laser angle error
    delta_Cla = eye(3) + ...
        SkewSymmetric([delta_tau_i delta_phi delta_kappa]); % scan angle errors
    Cla = Euler2Dcm(tau_i,0,0);
    if external_INS
        [Cbn,Cen,p_ned_delta] = INSfile(t,1/f_p);
        p_enu = p0_enu+Cned2enu*p_ned_delta;
    else
        Cbn = INS(t);
        Cen= Euler2Dcm(0,-pi,0);
        p_enu = GPS(t,Cned2enu*v_ned,p0_enu); % ENU
    end
    Rtag = Cned2enu*Cbn*Cab*Cla;          % from instantaneous beam direction to ENU
    ALS_loc = [ALS_loc p_enu];            % ENU
    c = Cned2enu*Cbn*t_LG+p_enu;
    [p s] = GetTrueFootprint(Rtag,c,surfaceDefinition);
    surface = [surface p];                % ENU
    pstar = Cned2enu*delta_Cbn*Cbn*(delta_Cab*Cab*delta_Cla*Cla*[0;0;(s+delta_r)]+t_LG+delta_t_LG)+p_enu;
    ALS_scan = [ALS_scan pstar];
end
ALS_err = ALS_scan-surface;
figure(1);
scatter3(surface(1,:),surface(2,:),surface(3,:),'.');hold on;
plot3(ALS_loc(1,:),ALS_loc(2,:),ALS_loc(3,:),'g');
scatter3(ALS_scan(1,:),ALS_scan(2,:),ALS_scan(3,:),'r','.');
xlabel('E'); ylabel('N'); zlabel('U');
legend({'surface','trajectory', 'scan'}); 

figure(2);
Scatter2Surf(ALS_scan(1,:),ALS_scan(2,:),ALS_scan(3,:));
hold on;
Scatter2Surf(surface(1,:),surface(2,:),surface(3,:));
xlabel('E'); ylabel('N'); zlabel('U');
legend({'scan','surface'}); 
