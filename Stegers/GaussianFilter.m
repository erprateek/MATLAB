function [filter_image] = GaussianFilter(I,sigma,width)
    %==============================================%
    % Gaussian Mask
    sp = width;
    mask = zeros(2*sp+1,2*sp+1);
    for i = -sp:sp
        for j= -sp:sp
            mask(i+sp+1,j+sp+1)=exp(-(i^2+j^2)/(2*(sigma)^2));
        end
    end
    mask = mask/(sum(sum(mask)));
    filter_image = conv2(I,mask, 'same');
end