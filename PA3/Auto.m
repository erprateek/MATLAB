function Auto(calib_image)

%Display image
path = ['microscope_char\',calib_image];
image = double(imread(path));
figure
imshow(image, [])


[x_pixel, y_pixel] = ginput(1);
x_pixel = round(x_pixel);
y_pixel = round(y_pixel);

mean_pixel = mean(impixel(image,x_pixel,y_pixel));


curr_pixel = mean_pixel;

while (curr_pixel <= mean_pixel + (mean_pixel/3))
    x_pixel = x_pixel + 1;
    curr_pixel = mean(impixel(image,x_pixel,y_pixel));
end

pixels = 0;

while(curr_pixel >= mean_pixel + (mean_pixel/3))
    x_pixel = x_pixel + 1;
    curr_pixel = mean(impixel(image,x_pixel,y_pixel));
    pixels = pixels + 1;
end

close all;

pixelsize = 1/pixels