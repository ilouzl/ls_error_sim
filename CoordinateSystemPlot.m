function CoordinateSystemPlot(r,Cbn,Cbl)
clc; close all;
d2r = pi/180;

r = [[35 34]*d2r 120];
Cbn = Euler2Dcm(d2r*[15 -2 56]);
Clb = Euler2Dcm(d2r*[-10 0 0]);

figure;hold on;

axesm('globe')
gridm('GLineStyle','-','Gcolor',[.8 .7 .6],'Galtitude', 100)
load coast
plot3m(lat,long,100,'k')
view(3)
axis off; zoom(2)

% [X,Y,Z] = sphere(100);
% mesh(100*X,100*Y,100*Z);


I = 10*eye(3);
hlines = [];



Oe = [0,0,0]';
triad = I;
hlines = [hlines plotCoordinate(Oe,triad,'b')];

Cen = Euler2Dcm(0,-r(1)-pi/2,r(2));
On = r(3)*[cos(r(1))*[cos(r(2)) sin(r(2))] sin(r(1))]';
triad = Cen*I;
hlines = [hlines plotCoordinate(On,triad,'g')];

Ob = On;
triad = Cbn'*Cen*I;
hlines = [hlines plotCoordinate(Ob,triad,'r')];


Ol = On;
triad = Clb'*Cbn'*Cen*I;
hlines = [hlines plotCoordinate(Ol,triad,'k')];


xlabel('X'); ylabel('Y'); zlabel('Z');
% xlim([-10 130]); ylim([-10 130]); zlim([-10 130]);
legend(hlines,{'Earth','NED','BODY','ALS'});


function hline = plotCoordinate(O,triad,color)

O = repmat(O',3,1);
Otag = O+triad;
hline = plot3([O(1,1) Otag(1,1)], [O(1,2) Otag(1,2)],[O(1,3) Otag(1,3)],color);
plot3([O(2,1) Otag(2,1)], [O(2,2) Otag(2,2)],[O(2,3) Otag(2,3)],color);
plot3([O(3,1) Otag(3,1)], [O(3,2) Otag(3,2)],[O(3,3) Otag(3,3)],color);
scatter3(Otag(3,1), Otag(3,2), Otag(3,3),color);
