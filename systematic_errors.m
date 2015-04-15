% LASER ERRORS
%   RANGE
delta_r = 0;        % [m], range error
%   SCAN ANGLE
eps = 0;              % [deg] index error
delta_tau = 0;      % [deg] swath angle error
delta_phi = 0;      % [deg] scan plane error around y
delta_kappa = 0;    % [deg] scan plane error around z

% MOUNTING ERRORS
%   LASER
delta_alpha = 0;      % [deg] laser mounting error around x
delta_beta = 0;       % [deg] laser mounting error around y
delta_gamma = 0;      % [deg] laser mounting error around z
delta_R_M = eye(3) + ...
    SkewSymmetric([delta_alpha, delta_beta, delta_gamma]*pi/180); % laser mounting error
delat_t_L = [0; 0; 0]; % [m] laser lever arm

%  GPS
delat_t_G = [0; 0; 0]; % [m] GPS lever arm

delta_t_LG = delat_t_G+delat_t_L; % [m] lever arm error

% INS ERRORS
delta_rho = 0;      % [deg] INS error around x
delta_p = 0;      % [deg] INS error around y
delta_h = 0;      % [deg] INS error around z
delta_R_N =eye(3) + ...
    SkewSymmetric([delta_rho, delta_p, delta_h]*pi/180);
 
 
 