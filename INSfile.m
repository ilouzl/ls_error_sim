function [Cbn,Cen,GPSdelta] = INSfile(t,dt)
persistent p flh euler v GPS Cned2enu;

if isempty(p)
    load data;
    flh = x_insP(1:3,:);
    p = repmat(flh(3,:),3,1).*[repmat(cos(flh(1,:)),2,1).*[cos(flh(2,:)) ;sin(flh(2,:))]; sin(flh(1,:))];
    v = x_insP(4:6,:);
    euler = x_insP(7:9,:);
    GPS = 0;
    Cned2enu = Euler2Dcm(pi,0,pi/2);
end

k = floor(t/0.01)+1;
Cbn = Euler2Dcm(euler(:,k));
Cen = Euler2Dcm(0,-pi/2-flh(1,k),flh(2,k));
GPS = GPS+Cned2enu*v(:,k)*dt;
GPSdelta = GPS;
% GPS = p(1:3,k);
