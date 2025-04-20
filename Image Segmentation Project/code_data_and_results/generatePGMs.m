function generatePGMs(path)
    % path = 'data1'
    cd(path);
    files = dir( fullfile('.','*.tif') );
    fnames = {files.name}';
    for i = 1:length(fnames)
        fname = fnames{i};
        cwd = pwd;
        fpath = strcat(cwd,'\',fname);
        [pathStr,name,ext] = fileparts(fpath);
        out_fname = strcat(name,'_out_resized.pgm');
        out_fname2 = strcat(name,'_out_resized.ppm');
        I = imread(fname);
        I = im2uint8(I);
        J = imresize(I, [100, NaN]);
        imwrite(J,out_fname,'pgm');
        imwrite(J,out_fname2,'ppm');
    end
    cd('../');
end