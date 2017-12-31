function rho = ScannerOutput(p,s,R)
if length(s) == 3
    s = [s(1); s(2); -1; s(3)];
end

n = s(1:3);
l0 = p;
l = R*[0;0;1];
p0 = [1;1;-(s(1)+s(2)+s(4))/s(3)];

rho = ((p0-l0)'*n)/(l'*n);