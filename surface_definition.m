syms z x y s R13 R23 R33 C1 C2 C3 
a = 1;
b = 1;
c = 1;
eq = z-a*x^2 - b*y - c;
eq=subs(eq,[x y z],[R13*s+C1 R23*s+C2 R33*s+C3]); 
eq = solve(eq,s);
f = symfun(eq,[C1 C2 C3 R13 R23 R33]);
surfaceFuction = matlabFunction(f);
clearvars a b c z x y s R13 R23 R33 C1 C2 C3 eq f