%B3
%Characterizing Illumination Uniformity

I = double(imread(random_image));
figure
imshow(I, []);
rect = getrect();
background = imcrop(I, rect);
close;

Illumination_Diff = Illumination(background)
Illumination_Uniformity = 1-Illumination_Diff