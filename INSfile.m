function [Cbn,Cen,p_ned_delta] = INSfile(t,dt)
persistent p flh euler v_ned p_ned;

if isempty(p)
    load data;
    flh = x_insP(1:3,:);
    p = repmat(flh(3,:),3,1).*[repmat(cos(flh(1,:)),2,1).*[cos(flh(2,:)) ;sin(flh(2,:))]; sin(flh(1,:))];
    v_ned = x_insP(4:6,:);
    euler = x_insP(7:9,:);
    p_ned = 0;
end

k = floor(t/0.01)+1;
Cbn = Euler2Dcm(euler(:,k));
Cen = Euler2Dcm(0,-pi/2-flh(1,k),flh(2,k));
p_ned = p_ned+v_ned(:,k)*dt;
p_ned_delta = p_ned;
