function [Hessian] = getHessianMatrix(img, width, sigma)

img=double(img);
% get image size
[m,n]=size(img);

% get the range of convolve
[x,y]=meshgrid(-width:width,-width:width);

% second derivative of Guassian
Gxx=((1/(2*pi*sigma^4))*(x.^2/sigma^2-1)).*exp(-(x.^2+y.^2)/(2*sigma^2));   
Gyy=((1/(2*pi*sigma^4))*(y.^2/sigma^2-1)).*exp(-(x.^2+y.^2)/(2*sigma^2));
Gxy=(1/(2*pi*sigma^6))*(x.*y).*exp(-(x.^2+y.^2)/(2*sigma^2));

% convolve
Ixx=conv2(img,Gxx,'same');
Iyy=conv2(img,Gyy,'same');
Ixy=conv2(img,Gxy,'same');

% construct hessian matrix for each pixel
Hessian=cell(m,n);
for i=1:m
   for j=1:n 
       Hessian{i,j}=[Ixx(i,j) Ixy(i,j);Ixy(i,j) Iyy(i,j)];    
   end
end