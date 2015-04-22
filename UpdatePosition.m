function [p v] = UpdatePosition(v_0, p_0, a_B, R_N, delta_t)
a_N = R_N*a_B;
v = v_0 + delta_t*(a_N+[0;0;9.81]);
p = p_0 + delta_t*v;