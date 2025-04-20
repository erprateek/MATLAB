function ncutMethod(imgname,original)
    close all;
    cwd = pwd;
    ncutpath = strcat(cwd,'\Ncut_9\');
    datapath = strcat(cwd, '\data1\');
    filepath = strcat(datapath, imgname);
    [pathStr,name,ext] = fileparts(filepath);
    ext2 = ext(2:end);
    outpath = strcat(cwd,'\data1\Ncut\');
    rows = 160;
    cols = 160;
    % If fine segmentation required on the original image
    if original == 1
        I1 = imread(filepath);
        [rows,cols] = size(I1);
    end
    cd(ncutpath);
    I = imread_ncut(filepath,rows,cols);
    %figure(1);clf; imagesc(I);colormap(gray);axis off;
    %disp('This is the input image to segment, press Enter to continue...');
    disp('Computing edges');

    %nbSegments = 8; %60
    nbSegments = 10;
    [SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges,dW]= NcutImage(I,nbSegments);
    %% display the segmentation
    figure(2);clf
    bw = edge(SegLabel,0.01);
    J1=showmask(I,imdilate(bw,ones(2,2))); imagesc(J1);axis off
    outfilename = strcat(name,'_',num2str(nbSegments),'_',num2str(dW.sampleRadius),'_',num2str(dW.sample_rate),'_',num2str(dW.edgeVariance),ext);
    outfilepath = strcat(outpath,outfilename);
    imwrite(J1,outfilepath,ext2);
    disp('This is the segmentation');
    disp('The segmented file is saved under data1/Ncut folder');
    disp(['Number of segments ' num2str(nbSegments) ]);
    cd('../');
end