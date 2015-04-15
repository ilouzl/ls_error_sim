function [p,s] = GetTrueFootprint1(Rtag,C,g)
% syms z x y s R13 R23 R33 C1 C2 C3 
% a = surface(1);
% b = surface(2);
% c = surface(3);
% eq = z-a*x - b*y - c;
% eq=subs(eq,[x y z],[R13*s+C1 R23*s+C2 R33*s+C3]); 
% eq = solve(eq,s);
% f = symfun(eq,[C1 C2 C3 R13 R23 R33]);
s = g(C(1), C(2), C(3), Rtag(1,3), Rtag(2,3), Rtag(3,3));
p = Rtag*[0;0;s]+C;



