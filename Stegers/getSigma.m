function [sigma] = getSigma(I)
    % STEP 0: Identify maximal line width. Filter image with a
    % Gaussian kernel whose size satisfies: sigma >= width/sqrt(3)
    % Get the max width line region and crop it
    figure('Name', 'Please select the region with the thickest line in this image.')
    imshow(I, [])
    rect = getrect();
    croppedRegion = imcrop(I, rect);
    figure('Name', 'Please select the tight square around the widest curve in this image.')
    imshow(croppedRegion, [])

    data = [];
    % crop the line width for 3 times and calculate the average
    for i = 1:3
        rect = getrect();
        area = imcrop(croppedRegion, rect);
        s = size(area);
        data = [data s(1)];
    end

    % get the average of line width
    width=mean(data);
    % get sigma
    sigma=width/sqrt(3);
end