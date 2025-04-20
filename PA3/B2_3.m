%Question B2.3 
%Please run B2.m first

rand = randi(length(image_dir));
image_cell = cell(1,5);
random_image = [path1, path2, image_dir(rand).name];
test_image = imread(random_image);

for i = 1:5
    figure;
    imshow(test_image,[]);
    rect = getrect();
    background = imcrop(test_image, rect);
    image_cell{i} = background;
    close all;
end

k_test = 0; %Tracker to see if there are changes

for i = 1:4
    image_1 = double(image_cell{i});
    image_1 = reshape(image_1,1,[]);
    image_2 = double(image_cell{i+1});
    image_2 = reshape(image_2,1,[]);
    k_test = k_test + kstest2(image_1, image_2);
end

Changes_over_space = k_test