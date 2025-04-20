function DRLSE(imgname)
%clear all;
close all;

drlsePath = 'C:\Users\Prateek\Documents\MATLAB\Project 4\DRLSE_v0';
cwd = pwd;
datapath = strcat(cwd, '\data1\');
filepath = strcat(datapath, imgname);
foutpath = 'C:\Users\Prateek\Documents\MATLAB\Project 4\data1\DRLSE';

Img=imread(filepath);
Img=double(Img(:,:,1));

%% parameter setting
timestep=5;  % time step
mu=0.2/timestep;  % coefficient of the distance regularization term R(phi)
iter_inner=5;
iter_outer=60;
lambda=5; % coefficient of the weighted length term L(phi)
alfa=-1.5;  % coefficient of the weighted area term A(phi)
epsilon=1.7; % papramater that specifies the width of the DiracDelta function

sigma=0.9;    % scale parameter in Gaussian kernel
G=fspecial('gaussian',15,sigma); % Caussian kernel
Img_smooth=conv2(Img,G,'same');  % smooth image by Gaussiin convolution
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;
g=1./(1+f);  % edge indicator function.

% initialize LSF as binary step function
c0=2;
initialLSF = c0*ones(size(Img));
% % generate the initial region R0 as 4 rectangles
%   initialLSF(48:100,1:55)=-c0;    % for Blue0001
%   initialLSF(1:40,1:45)=-c0; %Blue
%   initialLSF(45:100,75:133)=-c0; %Blue
%   initialLSF(20:50,60:90)=-c0; %Blue


initialLSF(90:95,130:138)=-c0;
initialLSF(90:95,150:157)=-c0;
initialLSF(70:75,130:138)=-c0;
initialLSF(70:75,150:157)=-c0;

initialLSF(10:40,40:70)=-c0;
initialLSF(10:40,220:260)=-c0;
initialLSF(125:155,40:70)=-c0;
initialLSF(125:155,220:260)=-c0;
  
phi=initialLSF;

figure(1);
mesh(-phi);   % for a better view, the LSF is displayed upside down
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
title('Initial level set function');
view([-80 35]);

figure(2);
imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
title('Initial zero level contour');
pause(0.5);

potential=2;  
if potential ==1
    potentialFunction = 'single-well';  % use single well potential p1(s)=0.5*(s-1)^2, which is good for region-based model 
elseif potential == 2
    potentialFunction = 'double-well';  % use double-well potential in Eq. (16), which is good for both edge and region based models
else
    potentialFunction = 'double-well';  % default choice of potential function
end  

cd(drlsePath);
% start level set evolution
%phi = 0;
for n=1:iter_outer
    phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    if mod(n,2)==0
        figure(2);
        imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');

    end
end

fname = strcat(foutpath,'\',imgname,'_DRLSE_out.tif');
imwrite(phi, fname, 'tif');



% refine the zero level contour by further level set evolution with alfa=0
alfa=0;
iter_refine = 10;
phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
cd('../');

finalLSF=phi;
figure(2);
imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
hold on;  contour(phi, [0,0], 'r');
str=['Final zero level contour, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);

figure;
mesh(-finalLSF); % for a better view, the LSF is displayed upside down
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
view([-80 35]);
str=['Final level set function, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);
axis on;

end