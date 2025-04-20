function Manual(imagefilename)

path = ['microscope_char\',imagefilename];
I = double(imread(path));
figure
imshow(I, [])

%Vector to store pixel sizes
pixel = [];

%Please Select 5mm increments in the xaxis
for i = 1:3
    rect = getrect();
    selection = imcrop(I, rect);
    xAxisPixels = size(selection, 2);
    pixelsize = 5/xAxisPixels;
    pixel = [pixel, pixelsize];
end

close all;

%In mm
AveragePixelSize = mean(pixel)


