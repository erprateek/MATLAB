%Question B2.2 
%Be sure to run B2.m first

%Compare 2 adjacent background images

k_test = 0; %Tracker for images with different distributions

for i = 1:length(images)-1
    curr_image = strcat('image_background\background', sprintf('%d', i),'.tif');
    curr_image2 = strcat('image_background\background', sprintf('%d', i+1),'.tif');
    
    %first image
    image_1 = double(imread(curr_image));
    image_1 = reshape(image_1,1,[]);
    
    %second image
    image_2 = double(imread(curr_image2));
    image_2 = reshape(image_2,1,[]);
    
    k_test =  k_test + kstest2(image_1,image_2);
    
end

Change_in_distribution = k_test

