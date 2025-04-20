% Project Assignment #3
%===============================================================================
% B.4 : Using cropped background and cropped image for calibration
%===============================================================================
% User's image location settings
clear all, close all

outputDir = 'CroppedImages';

%Adjust the ratio value here, like 2 for 20x, 6 for 60x, 10 for 100x
ratio = 10;

%We count the pixel number within the black line
%20 works for 60x, 30 works for 100x, 10 works for 10x and 20x
distance = 30;

imagePath = '100X_calib.tif'; % Path format in Windows
%imagePath = '2/images/001_a5_002_t001.tif'; % Path format in OSX/Linux


Img = imread(imagePath);
figure, imshow(Img,[])
disp('Please select image area:')
rect = getrect();
I=imcrop(Img,rect);

disp(I);

% Create directory if doesn't exist
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

filenameOut = ['cropped_', imagePath];
filePathOut = [outputDir, filesep, filenameOut];
imwrite(I, filePathOut, 'tif', 'Compression','none');






[bgMean, bgSD] = getbackgroundinfo(imagePath);
disp('Done: getbackgroundinfo')

gaussMask = getguasskernalmask(1.18);
disp('Done: getguasskernalmask')

I2 = conv2(double(I), gaussMask, 'same'); % To Do: change I to double(I) in all functions
disp('Done: conv2 Image with gaussMask')
% Comparing the gaussMark with sig=1 vs. sig=10 vs. sig=100, there is no
% change in the number of local maxima or local minima or triangles.

di=size(I2);
ro=di(1);
co=di(2);

figure, imshow(I2,[])

[localMax, localMin] = detectlocalmaxmin(I2, 5);
disp('Done: detectlocalmaxmin')



[DT,x,y] = triangulationproject(localMin);
disp('Done: triangulationproject')

%figure, triplot(DT)

[ newlocalmin ] = tTest(I2, localMin, localMax, bgSD, -5.0 );  % Q = 10.0
disp('Done: T-test Filtering of maxima')



figure,
imshow(I,[])
hold on
X=[];
Y=[];
for i =1:ro
    for j=1:co
        if newlocalmin(i,j)==1
            Y=[Y,i];
            X=[X,j];
        end
    end
end
plot(X, Y,'green+');

%imshow(newlocalmax,[])
hold off

X = sort(X)
base = X(1);
tmp = [base];
tmp2 = [];
sizeX = size(X);
for i = 2:sizeX(2)
    
    if(abs(X(i)-base) < distance)  % distance is the line width of black line
        %disp('entering if case');
        tmp = [tmp X(i)];
        %disp('if case above');
    else
        %disp('entering else case');
        tmpmean = mean(tmp);
        %disp(tmp);
        tmp2 = [tmp2 tmpmean];
        base = X(i);
        tmp = [X(i)];
    end
        
end
       
%disp(tmp2)

tmpDistance = [];
size2 = size(tmp2);
for i = 2:size2(2)
    tmpDistance = [tmpDistance (tmp2(i) - tmp2(i-1))];
        
end

%disp(tmpDistance);

result = 0.01*10^-3/mean(tmpDistance);

result = result *ratio;

disp(result);






%imshow(I);
disp('FINISHED!')