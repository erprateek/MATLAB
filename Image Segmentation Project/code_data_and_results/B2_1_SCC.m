%B2_1 (SCC)
close all;

%Choose image file
filename = 'Blue0001.tif';
%filename = '60x_02.tif';

%%SCC
Img = double(imread(filename));
imgSize = size(Img);
figure; imagesc(Img); colormap gray; axis off; axis equal;

%Set up data for Matitk
D = zeros(imgSize(1),imgSize(2),2);
D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

%SCC Parameters
x = 4;
y = 5;
z = 1;
param = [x y z];

%SCC Seed Parameters
[rows cols numberOfColorChannels] = size(Img);
x1 = cols/2;
y1 = rows/2;
z1 = 1;
seeds = [x1 y1 z1];

%Run SCC
b = matitk('SCC', param, double(D), double([]), seeds);
figure; imagesc(squeeze(b(:,:,2))); colormap gray; axis off; axis equal;

