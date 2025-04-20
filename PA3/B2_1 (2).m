%Path of background images
%Please run B2.m before

%Put all images in a vector
images = cell(1);

for i = 1:length(image_dir)
    images{i} = strcat('image_background\background', sprintf('%d', i),'.tif');
end

%B2.1 Implementation
k_test = 0;


for i = 1:length(images)
    background = double(imread(images{i}));
    k_test = k_test + kstest(background);
end

Percent_Normal_distributred = k_test/length(image_dir)*100


