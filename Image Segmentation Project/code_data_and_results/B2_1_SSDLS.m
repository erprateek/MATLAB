%B2_1 (SSDLS)
close all;

%Choose image file
filename = 'Blue0001.tif';
%filename = '60x_02.tif';

%%SSDLS
Img = double(imread(filename));
imgSize = size(Img);
figure; imagesc(Img); colormap gray; axis off; axis equal;

%Set up data for Matitk
D = zeros(imgSize(1),imgSize(2),2);
D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

%Calculate Gradient
[gradx,grady] = gradient(D);
DG = gradx+grady;

%SSDLS Parameters
x = 1;
y = 1;
z = 0.02;
w = 1;
param = [x y z w];

%Run SSDLS
b = matitk('SSDLS', param, uint8(D), uint8(DG), []);
figure; imagesc(b(:,:,1)); colormap gray; axis off; axis equal;
