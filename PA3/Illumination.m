%B3
%Function to find illumination
function [ avg_diff ] = Illumination(background)

%Image properties
num_rows = size(background,1);
num_cols = size(background,2);

%Testing Size
sq_size = 4;
total_size = sq_size*sq_size;

%Testing Area
row_test = num_rows - mod(num_rows,sq_size)
col_test = num_cols - mod(num_cols,sq_size)
row_iter = row_test/sq_size
col_iter = col_test/sq_size

subregions = cell(1);

%Apply test
for j = 1:sq_size
    for i = 1:sq_size
        row_start = (j-1)*row_iter+1;
        col_start = (i-1)*col_iter+1;
        subregions((j-1)*sq_size+i)= mat2cell(background(row_start:row_start+row_iter-1,col_start:col_start+col_iter-1),row_iter,col_iter)
    end
end

numregioncomparisons = nchoosek(total_size,2);
numofsigdifferences = 0;

for i = 1:total_size-1
    for j = i+1:total_size
        sr1 = subregions{i};
        sr2 = subregions{j};
        numofsigdifferences = numofsigdifferences + kstest2(sr1(:),sr2(:));
    end
end

avg_diff = numofsigdifferences/numregioncomparisons;

end