function [out,M]=Gauss2D(image, sigma);
% Gauss2D: filter an image using a 2D isotropic Gaussian filter
%
%    out = Gauss2D(x,sigma);
%
%    INPUT: x      image
%           sigma  of gauss filter
%
%    OUTPUT: out   filtered image
%            M     gaussian mask
%
% 
R = ceil(3 * sigma);   % cutoff radius of the gaussian kernel
M = zeros(2 * R + 1); 
for i = -R:R,
   for j = -R:R,
      M(i + R + 1,j + R + 1) = exp(-(i*i + j*j)/2.0/sigma/sigma);
   end
end
M = M/sum(M(:));   % normalize the gaussian mask so that the sum is
                   % equal to 1
                   
out=filter2(M, image);

