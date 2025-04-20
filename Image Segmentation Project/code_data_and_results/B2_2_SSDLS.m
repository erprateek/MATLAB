%B2_2 (SSDLS)
close all;

%Load Files
%Paths for loading/saving images
path1 = 'Mito_GFP_a01\';
path2 = 'B2_2_SSDLS_Results\';
images = dir([path1,'*.tif']);

initial_image = [path1, images(1).name];
initial_img = imread(initial_image);
figure('Name', 'First image in Sequence to be segmented'), imshow(initial_img, []);

%SSDLS Parameters
x = 1;
y = 1;
z = 0.02;
w = 1;
param = [x y z w];

%Loop through all images in "Mito_GFP_a01
for i = 1:length(images)
    filename = [path1, images(i).name;];
    
    %%SSDLS
    Img = double(imread(filename));
    imgSize = size(Img);
    
    %Set up data for Matitk
    D = zeros(imgSize(1),imgSize(2),2);
    D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
    D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));
    
    [gradx,grady] = gradient(D);
    DG = gradx+grady;
    
    %Run SSDLS
    b = matitk('SSDLS', param, uint8(D), uint8(DG), []);
    
    savepath = [path2,  sprintf('SSDLS_Result_%d.tif', i)];
    imwrite(squeeze(b(:,:,1)), savepath, 'tiff', 'Compression','none');
end

