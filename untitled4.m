clearvars; close all;
[file,dir] = uigetfile('/Users/Liron/Desktop/IMU files/*.csv');
[t,a,g] = importIphoneImuFile([dir file]);
p = [0 0 0]';
v = [0 0 0]';
calib = [0.0078 -0.0086 -0.0164]';
for i=1:length(t)
    a_B = (a(i,2:4)'-calib)*9.81;
%     a_B = [0 0 -1]'*9.81;
    time2 = a(i,1);
    if i==1
        time1 = time2 - 0.1;
    else
        time1 = a(i-1,1);
    end
    [p_t v_t] = UpdatePosition(v(:,i), p(:,i), a_B, eye(3), time2-time1);
    p = [p p_t];
    v = [v v_t];
end
scatter3(p(1,:),p(2,:),p(3,:));