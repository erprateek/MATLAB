image = imread('33705-WTyeast.tif');
imshow(image, []);
imageData = double(image);
intensity_min = min(min(imageData));
intensity_max = max(max(imageData));
intensity_range = intensity_max - intensity_min;

[imgHeight, imgWidth] = size(image);

noise_level = 0.2 * intensity_range;
noise2D = randn(imgHeight, imgWidth) * noise_level;

imageDataNoiseAdded = imageData+ noise2D;
subplot(2,3,1);
imshow(imageData, []);
subplot(2,3,2);
imshow(imageDataNoiseAdded, []);

filtered_image_sigma_1 = Gauss2D(imageDataNoiseAdded, 1);
filtered_image_sigma_2 = Gauss2D(imageDataNoiseAdded, 2);
filtered_image_sigma_5 = Gauss2D(imageDataNoiseAdded, 5);
filtered_image_sigma_10 = Gauss2D(imageDataNoiseAdded, 10);

subplot(2,3,3);
imshow(filtered_image_sigma_1, []);
subplot(2,3,4);
imshow(filtered_image_sigma_2, []);
subplot(2,3,5);
imshow(filtered_image_sigma_5, []);
subplot(2,3,6);
imshow(filtered_image_sigma_10, []);
