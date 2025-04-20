%B2.2 Implementation
%Be sure to run B2_1.m first

%Compare 2 adjacent background images
k_test = 0;

for i = 1:length(images)-1
    %first image
    image_1 = double(imread(images{i}));
    image_1 = reshape(image_1,1,[]);
    
    %second image
    image_2 = double(imread(images{i+1}));
    image_2 = reshape(image_2,1,[]);
    
    k_test =  k_test + kstest2(image_1,image_2);
end

Change_in_distribution = k_test

