function[u, v, worldPoints] = calibration_intrinsic_final(image, wx, wy, wz, thx, thy, thz, camx, camy, camz, f)
%----------------------
%Calculate Intrisic Camera Parameters, such as u,v vectors of corresponding
%Image Points to Camera Points from known world Points, FOVx, FOVy factors
%(a,b,c,d)
%
%Example 1: picturesxoli.jpg
%World points:
% wx = [-28, -166, -305, -9, -9, -28, -166, -305, -9, -9];
% wy = [9, 9, 9, 20, 145, 9, 9, 9, 20, 145];
% wz = [13, 13, 13, 13, 13, 102, 102, 102, 102, 102];
% worldPoints = [wx(:),wy(:),wz(:)];
%Camera Location:
% camx = 83;
% camy = -155;
% camz = 83;
%Rotation
% thx = 0;
% thy =0;
% thz=deg2rad(41.8)
%----------------------

worldPoints = [wx(:),wy(:),wz(:)];
%----------------------
%Load image
p1  = double(rgb2gray(imread(image)));
figure(1), imagesc(p1); colormap(gray); title('picture1');
axis equal;
hold on;
if (image == 'picturesxoli.jpg')
    load first_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
elseif (picture == 'picturesxoli2.jpg')
    load second_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
elseif (picture == 'picturesxoli3.jpg')
    load third_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
elseif (picture == 'picturesxoli4.jpg')
    load fourth_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
elseif (picture == 'picturesxoli5.jpg')
    load fifth_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
elseif (picture == 'picturesxoli6.jpg')
    load sixth_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
elseif (picture == 'picturesxoli7.jpg')
    load seventh_image_points;
    jgt = first_image_points(:,1)';
    igt = first_image_points(:,2)';
end



[Nx,Ny] = size(wx);
Pt = [wx(:),wy(:),wz(:),ones(size(wx(:)))]';

%----------------------
%Obtain Coordinates of point for a Rotated coordinate system
Rx = [1,0,0,0;...
        0,cos(thx),-sin(thx),0;...
        0,+sin(thx),cos(thx),0;...
        0,0,0,1];
Ry = [cos(thy),0,-sin(thy),0;...
        0,1,0,0;...
        sin(thy),0,cos(thy),0;...
        0,0,0,1];
Rz = [cos(thz),+sin(thz),0,0;...
        -sin(thz),cos(thz),0,0;...
        0,0,1,0;...
        0,0,0,1];    
T = [1,0,0,-camx;0,1,0,-camy;0,0,1,-camz;0,0,0,1];
Rot = Rx*Ry*Rz;%Given Rotation Matrix
cam_rotated = Rot*[camx;camy;camz;1];%Rotated camera transposision
T_camrotated = eye(4,4); 
T_camrotated(:,4) = -cam_rotated;
P1 = T_camrotated*Rot;
UV = (T*Rot)*Pt;
Pim = P1*Pt;
u1 = Pim(1,:)*f./(Pim(2,:));%Image point Coordinates
v1 = Pim(3,:)*f./(Pim(2,:));

%----------------------
%Calculate a, b, c, d and compute camera u,v vectors
V = [v1(:), ones(size(v1(:)))];
CD = V\[igt(:)];
U = [u1(:), ones(size(u1(:)))];
AB = U\[jgt(:)];
i1 = V*CD;
j1 = U*AB;
u = (jgt-AB(2))/AB(1);
v = (igt-CD(2))/CD(1);
plot(u,v,'+');
