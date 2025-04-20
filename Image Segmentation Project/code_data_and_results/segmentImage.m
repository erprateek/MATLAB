% imgName can be the whole path of the file
% How to use:
% fpath = 'C:\Users\Prateek\Documents\MATLAB\Project 4\images\grain.gif'
% segmentImage('',fpath,0.5, 1000, 100)
function segmentImage(segpath,imgName, sigma, K, min)
    close all;
    cwd = pwd;
    [pathStr, name, ext] = fileparts(imgName);
    I= imread(imgName);
    I = im2uint8(I);
    % preparing a ppm file from regular file
    extension = 'ppm';
    outfile = strcat(name,'_',num2str(sigma),'_',num2str(K),'_',num2str(min),'_out.',extension);
    writepath = strcat(pathStr, '\Segment\',outfile);
    imwrite(I, writepath, extension);
    % paths for segmentation output and segment.exe
    segoutfile = strcat(name,'_',num2str(sigma),'_',num2str(K),'_',num2str(min),'_segmented.',extension);
    segoutpath = strcat(pathStr, '\Segment\', segoutfile);
    segmentpath = ['"',strcat(cwd,'\segment\segment\segment.exe'),'"'];
    % if path is not specified then take the default path else replace
    if strcmp(segpath, '') == 0
        segpath = ['"',segpath,'"'];
        segmentpath = segpath;
    end
    %prepare command
    stringoutpath = ['"',writepath,'"'];
    stringsegoutpath = ['"',segoutpath,'"'];
    command = strcat(segmentpath,32,num2str(sigma),32,num2str(K),32,num2str(min),32,stringoutpath,32,stringsegoutpath);
    %perform segmentation by calling dos command
    cd('data1');
    [status,cmdout] = dos(command);
    cd('../');
    % add condition for status == 0
    % execution shpould take place only if the command succeeded
    I2 = imread(segoutpath, extension);
    segjpg = strcat(pathStr,'\Segment\',name,'_',num2str(sigma),'_',num2str(K),'_',num2str(min),'_segmented.jpg');
    imwrite(I2, segjpg);
    I3 = imread(segjpg);
    % show images side by side
    subplot(1,2,1), imshow(I,[])
    subplot(1,2,2), imshow(I3,[])
end