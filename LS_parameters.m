d2r = pi/180;
f_p = 5000;                     % [Hz] pulse rate
f_s = 100;                      % [Hz] scan rate
n = f_p/f_s;                    % pulses per scan
tau = 0*d2r;                   % [rad] swath angle

% laser mounting angles
alpha = 0*d2r;                  % [rad] 
beta = 0*d2r;                   % [rad] 
gamma = 0*d2r;                  % [rad] 
Cab = Euler2Dcm(alpha, beta, gamma); % from a (ALS) to b (body)

t_G = [0;0;0];                 % [m] GPS lever arm
t_L = [0;0;0];                  % [m] LS lever arm
t_LG = t_L + t_G;


