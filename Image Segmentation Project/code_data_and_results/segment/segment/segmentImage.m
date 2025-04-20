% imgName can be the whole path of the file
function segmentImage(segpath,imgName, sigma, K, min)
    [pathStr, name, ext] = fileparts(imgName);
    [I, map]= imread(imgName);
    % preparing a ppm file from regular file
    extension = 'ppm';
    outfile = strcat(name,'_out.',extension);
    writepath = strcat(pathStr, '\',outfile);
    imwrite(I, outfile, extension);
    % paths for segmentation output and segment.exe
    segoutfile = strcat(name,'_segmented.',extension);
    outpath = strcat(pathStr, '\', segoutfile);
    segmentpath = strcat(writepath,'\segment.exe');
    % if path is not specified then take the default path else replace
    if strcmp(segpath, '') == 0
        segmentpath = segpath;
    end
    %prepare command
    command = strcat('segment.exe',32,int2str(sigma),32,int2str(K),32,int2str(min),32,outfile,32,segoutfile);
    %perform segmentation by calling dos command
    [status,cmdout] = dos(command);
    % add condition for status == 0
    % execution shpould take place only if the command succeeded
    I2 = imread(segoutfile, extension);
    imwrite(I2, strcat(name,'_segmented.jpg'));
    [I3,map3] = imread(strcat(name,'_segmented.jpg'));
    % show images side by side
    subplot(1,2,1), imshow(I, map)
    subplot(1,2,2), imshow(I3,map3)
end
