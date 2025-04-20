function [EigMat,NoiseMat] = getEigFromHess(H)
[rows,cols] = size(H);
EigMat = cell(rows,cols);
NoiseMat = zeros(rows,cols);
for i = 1:rows
    for j=1:cols
        [V,D]=eig(H{i,j});
        D = diag(D);
        % find the position of max eigen value
        [max_val,index] = max(D);
        %if the eigval is smaller than 0, it may be a noise and we mark it
        NoiseMat(i,j) = (max_val <= 0);
        % find the corresponding eigen vector for this max eigen value
        EigMat{i,j} = V(:,index);
    end
end
