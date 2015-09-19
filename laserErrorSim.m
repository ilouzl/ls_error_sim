clearvars; close all; clc; clear INSfile.m;

% load configuration and parementes
systematic_errors;
LS_parameters;
surface_definition;
platform_parameters;

% local simulation parameters
external_INS = 1;
simulationLengthTime = 0.02; % [sec]
simulationLengthSamples = simulationLengthTime*f_p;


if external_INS
    p_enu = p0_enu;
end

Cned2enu = Euler2Dcm(pi,0,pi/2);
j = 1; % scan line
i = 0; % laser beam within scan
t=0;
[ins_euler,surface,ALS_loc,ALS_scan]=deal(zeros(3,simulationLengthSamples));
[rho] = deal(zeros(1,simulationLengthSamples));
for idx = 1:simulationLengthSamples
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
        [Cbn,Cen,v_ned] = INSfile(t);
        p_enu = p_enu+Cned2enu*v_ned/f_p;
    else
        Cbn = INS(t);
        Cen= Euler2Dcm(0,-pi,0);
        p_enu = GPS(t,Cned2enu*v_ned,p0_enu); % ENU
    end
    Rtag = Cned2enu*Cbn*Cab*Cla;          % from instantaneous beam direction to ENU  
    c = Cned2enu*Cbn*t_LG+p_enu;
    [p, s] = GetTrueFootprint(Rtag,c,surfaceDefinition);  % real surface
    pstar = Cned2enu*delta_Cbn*Cbn*(delta_Cab*Cab*delta_Cla*Cla*[0;0;(s+delta_r)]+t_LG+delta_t_LG)+p_enu; % measured surface
        
    ALS_loc(:,idx) = p_enu;            % ENU
    surface(:,idx) = p;                % ENU
    ALS_scan(:,idx) = pstar;
    ins_euler(:,idx) = Dcm2Euler(Cbn);
    ins_v_ned(:,idx) = v_ned;
    rho(idx) = s + delta_r;
end

ALS_err = ALS_scan-surface;
figure(1);
title('Scene');
scatter3(surface(1,:),surface(2,:),surface(3,:),'.');hold on;
plot3(ALS_loc(1,:),ALS_loc(2,:),ALS_loc(3,:),'g');
scatter3(ALS_scan(1,:),ALS_scan(2,:),ALS_scan(3,:),'r','.');
xlabel('E'); ylabel('N'); zlabel('U');
legend({'surface','trajectory', 'scan'}); 

figure(2);
title('ALS scan');
Scatter2Surf(ALS_scan(1,:),ALS_scan(2,:),ALS_scan(3,:));
hold on;
Scatter2Surf(surface(1,:),surface(2,:),surface(3,:));
xlabel('E'); ylabel('N'); zlabel('U');
legend({'scan','surface'}); 

figure(3);
title('Platform performance');
t = 0:1/f_p:(simulationLengthTime-1/f_p);
subplot(2,2,1:2);
plot3(ALS_loc(1,:),ALS_loc(2,:),ALS_loc(3,:),'g');
xlabel('E'); ylabel('N'); zlabel('U');
legend({'trajectory'}); 
subplot(2,2,3);
plot(t,ins_euler'*180/pi); 
legend({'\phi','\theta','\psi'}); 
xlabel('sec'); ylabel('deg');
subplot(2,2,4);
plot(t,ins_v_ned'); legend({'V_N','V_E','V_D'}); 
xlabel('sec'); ylabel('m/s');


biases = BiasesRecovery(ALS_loc,[1 surfaceDefinition],ins_euler,rho);
