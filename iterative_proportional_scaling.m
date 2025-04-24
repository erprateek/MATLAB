% Solution to Question 6. - Implementing the
% Iterative proportion Scaling (IPS) algorithm.
% The function takes in a matrix as an argument and results the normalized
% form of the matrix as evaluated using the IPS algorithm.
% Example to run: 
% Declare a matrix as follows
% >> berkeleyData = [1198,1493; 557,1278];
% Run the IPS Algorithm
% >> [probabilities,counts] = RunIPS(berkeleyData);
% 
% Sample Output:
% [probabilities,fitted_counts] = RunIPS(mat)
% 
% probabilities =
% 
%     0.2305    0.3640
%     0.1572    0.2482
% 
% fitted_counts =
% 
%    1.0e+03 *
%     1.0435    1.6475
%     0.7115    1.1235
%

function [probabilities, store_G] = RunIPS(dataMatrix) 

%computing the overall sum
total = sum(sum(dataMatrix));

% Storing G so as not to change the original dataMatrix
store_G = dataMatrix;

%computing marginals
rowSum = sum(dataMatrix,2);
colSum = sum(dataMatrix); 

%mean of mean
store_G(:) = mean2(dataMatrix);

%looping through to repeatedly scale and compare the matrix row and column
%sum
%(matrix, 1) gives the rows and (matrix,2) gives the columns
%matrix(i,:) gives the ith row.
%matrix(:,j) gives the jth column
while( ~isequal(sum(store_G,2),rowSum) && ~isequal(sum(store_G,1),colSum))
    % for columns
    for i=1:size(store_G,1)
        store_G(i,:) = store_G(i,:) * rowSum(i) / sum(store_G(i,:));
    end
    % for columns
    for j=1:size(store_G,2)
        store_G(:,j) = store_G(:,j) * colSum(j) / sum(store_G(:,j));
    end
end
probabilities = store_G/total;
