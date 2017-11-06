function[R, Trans_final, final_focal] = calibration_extrinsic_final(u,v, worldPoints)
%----------------------
%Calculate Extrinsic Parameters of Camera such as Camera Pose, Camera
%Translation and compute final estimation for focal point
%----------------------

%----------------------
%Compute Homogenous Overdetermined System
H(:,1) = v'.*wx(:);
H(:,2) = v'.*wy(:);
H(:,3) = v'.*wz(:);
H(:,4) = v';
H(:,5) = -u'.*wx(:);
H(:,6) = -u'.*wy(:);
H(:,7) = -u'.*wz(:);
H(:,8) = -u';
G = H'*H;
[V,D] = eig(G);

%Scale factor
scale = 1/sqrt(V(1:3,1)'*V(1:3,1));

%----------------------
%Decompose vectors from min value of diag(D)
%Find first Rotation
a = V(1:3,1);
a1 = a/norm(a);
b = V(5:7,1);
b1 = b/norm(b);
a1 = a1';
b1 = b1';
R = [a1;cross(a1,b1);b1];
k = (-1/2).*a*b';

%----------------------
%Find Translation
tx = V(4,1)*scale;
tz = V(8,1)*scale;

%----------------------
%Finalize Rotation and Translation
if tz>0
    R=-R;
    tx=-tx;
    tz=-tz;
end

%----------------------
%Find ty and f 2x2 lin eq system
BB(1:2:20,1) = R(1,1).*wx(:)+R(1,2).*wy(:)+R(1,3).*wz(:)+tx;
BB(1:2:20,2) = -u(:);
BB(2:2:20,1) = R(3,1).*wx(:)+R(3,2).*wy(:)+R(3,3).*wz(:)+tz;
BB(2:2:20,2) = -v(:);
CC(1:2:20,1) = (R(2,1).*wx(:)+R(2,2).*wy(:)+R(2,3).*wz(:)).*u(:);
CC(2:2:20,1) = (R(2,1).*wx(:)+R(2,2).*wy(:)+R(2,3).*wz(:)).*v(:);
DD = BB\CC;
ty = DD(2);

%----------------------
%Recover Final Focal Point
final_focal = DD(1);


%----------------------
%Recover Final Translation
Trans = [tx;ty;tz];
Trans_final = (R^-1)*(-Trans);