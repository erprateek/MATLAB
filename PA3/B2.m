%Question B2

%Paths for loading/saving images
path1 = 'microscope_char\';
path2 = 'DrosophilaVesicleTransport\';
path3 = 'image_background\';

%Create a dir of images
image_dir = dir([path1, path2,'*.tif']);

%Get initial ROI
initial_image = [path1, path2,  image_dir(1).name];
img = imread(initial_image);
figure
imshow(img, []);
rect = getrect(); %Choose ROI
close;

%Go through all images, crop and save
for i = 1:length(image_dir)
    
    %Read and crop images
    img_name = image_dir(i).name;
    curr_image = [path1,  path2,  img_name];
    img = imread(curr_image);
    ROI = imcrop(img, rect);
    
    %Saving cropped photo without compression
    savePath = [path3,  sprintf('background%d.tif', i)];
    imwrite(ROI, savePath, 'tiff', 'Compression', 'none')
    
end
