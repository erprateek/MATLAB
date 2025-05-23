function [W,imageEdges,dataW] = ICgraph(I,dataW,dataEdgemap);
% [W,imageEdges] = ICgraph(I,dataW,dataEdgemap);
% Input:
% I = gray-level image
% optional parameters: 
% dataW.sampleRadius=10;
% dataW.sample_rate=0.3;
% dataW.edgeVariance = 0.1;
% 
% dataEdgemap.parametres=[4,3, 21,3];%[number of filter orientations, number of scales, filter size, elongation]
% dataEdgemap.threshold=0.02;
% 
% Output: 
% W: npixels x npixels similarity matrix based on Intervening Contours
% imageEdges: image showing edges extracted in the image
%
% Timothee Cour, Stella Yu, Jianbo Shi, 2004.

[p,q] = size(I);

if (nargin< 2) | isempty(dataW),
%     dataW.sampleRadius=15;  % 60
%     dataW.sample_rate=9.0;  % 60
%     dataW.edgeVariance = 0.019; %60
%     dataW.sampleRadius=10;  %blue
%     dataW.sample_rate=7.0;  %blue
%     dataW.edgeVariance = 0.05; %blue
    dataW.sampleRadius=10;  %mito
    dataW.sample_rate=6.0;  %mito
    dataW.edgeVariance = 0.5; %mito
end

if (nargin<3) | isempty(dataEdgemap),
    dataEdgemap.parametres=[4,3, 21,3];%[number of filter orientations, number of scales, filter size, elongation]
    dataEdgemap.threshold=0.02;
end


edgemap = computeEdges(I,dataEdgemap.parametres,dataEdgemap.threshold);
imageEdges = edgemap.imageEdges;
W = computeW(I,dataW,edgemap.emag,edgemap.ephase);
