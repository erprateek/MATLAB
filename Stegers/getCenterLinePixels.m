function [ detected_pixels ] = getCenterLinePixels(img, E, noiseMat, H)

[m,n] = size(img);
detected_pixels = zeros(m,n);
[fx,fy] = gradient(img);
I = zeros(m,n);
imshow(I,[])

hold on

for i = 1:m
    for j = 1:n
        e = E{i,j};
        h = H{i,j};

        f = zeros(2,1);
        N = zeros(1,2);

        f(1,1) = fx(i,j);
        f(2,1) = fy(i,j);
        N(1,1) = e(1);
        N(1,2) = e(2);
        
        first_derivative = N*f;
        second_derivative = N*h*e;

        local_max = -first_derivative/second_derivative;
        detected_pixels(i,j) = local_max;
        
        % this step is to check whether x_star is within [-0.5,0.5] and its
        % not noise
        % have to change this
        if ((-0.5<=local_max && local_max<=0.5)==1 && (noiseMat(i,j) ~= 1))
            plot(j,i,'red');
        end
    end
end
hold off