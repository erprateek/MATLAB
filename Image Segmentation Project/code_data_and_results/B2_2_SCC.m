%B2_2 (SCC)
close all;

%Load Files
%Paths for loading/saving images
path1 = 'Mito_GFP_a01\';
path2 = 'B2_2_SCC_Results\';
images = dir([path1,'*.tif']);

initial_image = [path1, images(1).name];
initial_img = imread(initial_image);
figure('Name', 'First image in Sequence to be segmented'), imshow(initial_img, []);

%SCC Parameters
x = 10;
y = 5;
z = 1;
param = [x y z];

x1 = 40;
y1 = 90;
z1 = 1;
seeds = [x1 y1 z1];

%Loop through all images in "Mito_GFP_a01
for i = 1:length(images)
    filename = [path1, images(i).name;];
    
    %%SCC
    Img = double(imread(filename));
    imgSize = size(Img);
    
    %Set up data for Matitk
    D = zeros(imgSize(1),imgSize(2),2);
    D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
    D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));
    
    %Run SSDLS
    b = matitk('SCC', param, double(D), double([]), seeds);
    
    savepath = [path2,  sprintf('SCC_Result_%d.tif', i)];
    imwrite(squeeze(b(:,:,1)), savepath, 'tiff', 'Compression','none');
end

