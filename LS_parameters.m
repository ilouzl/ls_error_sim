f_p = 5000; % [Hz] pulse rate
f_s = 100; %[Hz] scan rate
n = f_p/f_s;
tau = 30; % [deg] swath angle

% laser mounting
alpha = 0;
beta = 0;
gamma = 0;
R_M = Euler2Clb(0, -beta, 0);

t_G = [1;0;-1];         % GPS lever arm
t_L = [1;0;1];          % LS lever arm
t_LG = t_L + t_G;


