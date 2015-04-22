clearvars; close all;
[file,dir] = uigetfile('/Users/Liron/Desktop/IMU files/*.csv');
[t,a,g] = importIphoneImuFile([dir file]);
p = [0 0 0]';
v = [0 0 0]';
C = eye(3);
a_calib = [0.0078 -0.0086 -0.0164]';
g_calib = [0.0731 -0.0046 -0.0139]';
for i=1:length(t)
    time2 = g(i,1);
    if i==1
        time1 = time2 - 0.1;
    else
        time1 = g(i-1,1);
    end
    C = UpdateR_N(C,g(i,2:4)'-g_calib,time2-time1);
%     [al bet gam] = Clb2Euler(C)
%     plot3([0 C(1,3)],[0 C(2,3)],[0 C(3,3)]);
%     xlim([-1 1]); ylim([-1 1]); zlim([-1 2]); 
    a_B = (a(i,2:4)'-a_calib)*9.81;
    time2 = a(i,1);
    if i==1
        time1 = time2 - 0.1;
    else
        time1 = a(i-1,1);
    end
    [p_t v_t] = UpdatePosition(v(:,i), p(:,i), a_B, C, time2-time1);
    p = [p p_t];
    v = [v v_t];
end
scatter3(p(1,:),p(2,:),p(3,:));