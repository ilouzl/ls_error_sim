%% by Woodman 2009  
function [p v] = UpdatePosition(v_0, p_0, a_B, R_N, delta_t)
a_N = R_N*a_B+[0;0;9.81];
v = v_0 + delta_t*a_N;
% p = p_0 + delta_t*v; 
p = p_0 + delta_t*v_0+0.5*a_N*delta_t^2; % not by Woodman