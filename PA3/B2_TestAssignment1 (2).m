%B2_Assignment 1 test

%Question 2
Img_01 = double(imread('image01.tiff'));
figure;
imshow(Img_01, []);
rect = getrect();
background_1 = imcrop(Img_01, rect);
Question2 = kstest(background_1);
close all;

%Question 3
Img_02a = double(imread('image02.tiff',1));
Img_02b = double(imread('image02.tiff',2));

figure;
imshow(Img_02a, []);
rect = getrect();
background_2a = imcrop(Img_02a, rect);
background_2b = imcrop(Img_02b, rect);
Question2a = kstest(background_2a);
Question2b = kstest(background_2b);

close all;

Question2
Question2a
Question2b