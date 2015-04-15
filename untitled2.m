syms x y
f = symfun(x^2 - y^2, [x y])
f(1,2)
syms a b c x y z s
eqn = z-a*x - b*y - c == 0
eqn1=subs(eqn,[x y z],[s+1 s+2 s+5])
solx = solve(eqn1, s)
