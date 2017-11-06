clear all;
close all;
clc;
wxn = [-9, -9,-28, -166, -305, -305, -166, -28,-9, -9];
wyn = [145, 20, 9, 9, 9, 9, 9, 9, 20, 145];
wzn = [13, 13, 13, 13, 13, 102, 102, 102, 102, 102];
wx = [-28, -166, -305, -9, -9, -28, -166, -305, -9, -9];
wy = [9, 9, 9, 20, 145, 9, 9, 9, 20, 145];
wz = [13, 13, 13, 13, 13, 102, 102, 102, 102, 102];
camx = 36;
camy = -187;
camz = 83;
thx = pi/2;
thy = pi/2;
thz = -pi/5;
% iangle = 41.8;
% thz=deg2rad(iangle);
Rx = [1,0,0;...
    0,cos(thx),-sin(thx);...
    0,sin(thx),cos(thx);];
Ry = [cos(thy),0,-sin(thy);...
    0,1,0;...
    sin(thy),0,cos(thy)];
Rz = [cos(thz),-sin(thz),0;...
    sin(thz),cos(thz),0;...
    0,0,1];
Rot = Rx*Ry*Rz;
t = [camx,camy,camz];
figure(); hold on
plot3(wxn,wyn,wzn);
plot3(wx,wy,wz,'r+');
thx2 = pi/2;
thy2 = pi/2;
thz2 = -pi/6;
% iangle = 41.8;
% thz=deg2rad(iangle);
Rx2 = [1,0,0;...
    0,cos(thx2),-sin(thx2);...
    0,sin(thx2),cos(thx2);];
Ry2 = [cos(thy2),0,-sin(thy2);...
    0,1,0;...
    sin(thy2),0,cos(thy2)];
Rz2 = [cos(thz2),-sin(thz2),0;...
    sin(thz2),cos(thz2),0;...
    0,0,1];
Rot2 = Rx2*Ry2*Rz2;
thx3 = pi/2;
thy3 = pi/2;
thz3 = -pi/3.5;
% iangle = 41.8;
% thz=deg2rad(iangle);
Rx3 = [1,0,0;...
    0,cos(thx3),-sin(thx3);...
    0,sin(thx3),cos(thx3);];
Ry3 = [cos(thy3),0,-sin(thy3);...
    0,1,0;...
    sin(thy3),0,cos(thy3)];
Rz3 = [cos(thz3),-sin(thz3),0;...
    sin(thz3),cos(thz3),0;...
    0,0,1];
Rot3 = Rx3*Ry3*Rz3;
thx4 = pi/2;
thy4 = pi/2;
thz4 = -pi/3.8;
% iangle = 41.8;
% thz=deg2rad(iangle);
Rx4 = [1,0,0;...
    0,cos(thx4),-sin(thx4);...
    0,sin(thx4),cos(thx4);];
Ry4 = [cos(thy4),0,-sin(thy4);...
    0,1,0;...
    sin(thy4),0,cos(thy4)];
Rz4 = [cos(thz4),-sin(thz3),0;...
    sin(thz4),cos(thz4),0;...
    0,0,1];
Rot4 = Rx4*Ry4*Rz4;
plotCamera('location', [83,-155,83], 'orientation', Rot,'visible',1, 'Size',3);
plotCamera('location', [110,-120,83], 'orientation', Rot,'visible',1, 'Size',3);
plotCamera('location', [126,-90,83], 'orientation', Rot4,'visible',1, 'Size',3);
plotCamera('location', [126,-62,83], 'orientation', Rot3,'visible',1, 'Size',3);
plotCamera('location', [130,-167,83], 'orientation', Rot4,'visible',1, 'Size',3);
plotCamera('location', [53,-187,83], 'orientation', Rot2,'visible',1, 'Size',3);
plotCamera('location', [36,-187,83], 'orientation', Rot2,'visible',1, 'Size',3);
camx = [83,110,126,126,130,53,36];
camy = [-155,-120,-90,-62,-167,-187,-187];
camz = [83,83,83,83,83,83,83];
camxn = [83,110,126,126,130,53,36];
camyn = [-155,-120,-90,-62,-167,-187,-187];
camzn = [0,0,0,0,0,0,0];
plot3(camx,camy,camzn);
plot(camxn,camyn,'b*');
title('Πορεία κάμερας');
text(88,-154,'1');text(118,-121,'2');text(130,-91,'3');text(130,-63,'4');
text(135,-168,'5');text(58,-188,'6');text(40,-186,'7');
hold on;
for i2=1:7
        plot3([camx(i2),camxn(i2)],[camy(i2),camyn(i2)],[camz(i2),camzn(i2)],'-');
end