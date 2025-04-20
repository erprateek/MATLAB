% imagefilename is the input filename of image, like '10x_calib.tif'
% num is the number of divisions chosen for calibration
% k is the number of loop to crop the input image
function [ meanval ] = Manual(imagefilename, num, k)

%vector to store the pixel size calculated from one cropped are
data = [];

imagePath = ['microscope_char\',imagefilename];
I = imread(imagePath);
I=double(I);
figure('Name', 'Please select the background of this image'), imshow(I, [])

for i = 1:k
    rect = getrect();
    croppedarea = imcrop(I, rect);
    s = size(croppedarea);
    % pixel number along x axis
    N = s(2);
    disp(N);
    % num is the number of divisions for cropped area
    pixelsize = num*0.01/(1000*N);
    data = [data pixelsize];
end

disp(data);

% average pixel size
meanval = mean(data);
disp(meanval);

% standard deviation of pixel size
stdval = std(data);
disp(stdval);