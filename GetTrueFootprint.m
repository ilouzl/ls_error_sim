function [p,s] = GetTrueFootprint(Rtag,C,surface)
a = surface(1);
b = surface(2);
c = surface(3);
s = (a*C(1)+b*C(2)+c-C(3))/(Rtag(3,3) - a*Rtag(1,3)-b*Rtag(2,3));
p = Rtag*[0;0;s]+C;