function [ curveImage ] = Stegers(img_path)

% Read the Image into double format
img = imread(img_path);
I=double(img);
[m,n] = size(I);

% STEP 0: Get sigma and apply gaussian filter
sigma = getSigma(I);
width = ceil(3*sigma);
filter_image = GaussianFilter(I,sigma, width);
imshow(filter_image, [])

%STEP 1: Hessian and Eigen Matrix
H = getHessianMatrix(filter_image,width,sigma);
[eigMat, noiseMat] = getEigFromHess(H);

%STEP 2, 3, 4
curveImage = getCenterLinePixels(filter_image, eigMat, noiseMat, H);