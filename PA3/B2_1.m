%Quetion B2.1
%Please run B2.m before

k_test = 0; %Keep track of normal distributions

for i = 1:length(images)
    curr_image = strcat('image_background\background', sprintf('%d', i),'.tif');
    background = double(imread(curr_image));
    k_test = k_test + kstest(background);
end

Percent_Normal_distributred = k_test/length(image_dir)*100


