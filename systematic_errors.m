d2r = pi/180;
% LASER ERRORS
%   RANGE
delta_r = 0.1;        % [m], range error
%   SCAN ANGLE
eps = 0*d2r;              % [rad] index error
delta_tau = 0*d2r;      % [rad] swath angle error
delta_phi = 0*d2r;      % [rad] scan plane error around y
delta_kappa = 0*d2r;    % [rad] scan plane error around z

% MOUNTING ERRORS
%   LASER
delta_alpha = 0*d2r;      % [rad] laser mounting error around x
delta_beta = 0*d2r;       % [rad] laser mounting error around y
delta_gamma = 0*d2r;      % [rad] laser mounting error around z
delta_Cab = eye(3) + ...
    SkewSymmetric([delta_alpha, delta_beta, delta_gamma]); % laser mounting error
delta_t_L = [0; 0; 0]; % [m] laser lever arm

%  GPS
delta_t_G = [0; 0; 0]; % [m] GPS lever arm

delta_t_LG = delta_t_G+delta_t_L; % [m] lever arm error

% INS ERRORS
delta_rho = 0*d2r;      % [rad] INS error around x
delta_p = 0*d2r;      % [rad] INS error around y
delta_h = 0*d2r;      % [rad] INS error around z
delta_Cbn =eye(3) + ...
    SkewSymmetric([delta_rho, delta_p, delta_h]);
 
 
 