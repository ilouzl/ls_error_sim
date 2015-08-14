d2r = pi/180;
f_p = 5000;                     % [Hz] pulse rate
f_s = 100;                      % [Hz] scan rate
n = f_p/f_s;                    % pulses per scan
tau = 30*d2r;                   % [rad] swath angle

% laser mounting angles
alpha = 0*d2r;                  % [rad] 
beta = 0*d2r;                   % [rad] 
gamma = 0*d2r;                  % [rad] 
R_M = Euler2Dcm(alpha, beta, gamma);

t_G = [1;0;-1];                 % [m] GPS lever arm
t_L = [1;0;1];                  % [m] LS lever arm
t_LG = t_L + t_G;


