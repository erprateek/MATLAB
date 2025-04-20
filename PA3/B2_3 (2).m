%B2_3
%Please run B2.m first
%Change over space

rand = randi(length(image_dir));
samples = cell(1,5);
random_image = [path1, path2, image_dir(rand).name];
test_image = double(imread(random_image));

k_test = 0;

for i = 1:5
    figure;
    imshow(test_image,[]);
    rect = getrect();
    background = imcrop(test_image, rect);
    k_test = k_test + kstest(background);
    close all;
end

Changes_over_space = 5 - k_test