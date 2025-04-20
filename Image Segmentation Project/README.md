# Image Segmentation Project

## Overview

This project demonstrates the application and comparison of advanced **image segmentation algorithms** on biological microscopy datasets. It explores both classical and modern approaches using open-source tools and integrates C++-based algorithms into a MATLAB environment.

The project is divided into two parts:

1. **Segmentation using ITK via MATITK (MATLAB interface)**
2. **Segmentation using Graph-Cut and Active Contour methods**

---

## Part I: Image Segmentation using MAT-ITK

### Tools and Libraries
- **MATLAB**
- **MAT-ITK**: A MATLAB interface to the Insight Segmentation and Registration Toolkit (ITK)

### Data
- Static microscopy images: `60x_02.tif`, `Blue0001.tif`
- Time-lapse image sequence: Mitochondrial transport in Drosophila segmental nerves

### Tasks
- Apply two image segmentation algorithms via MATITK to both static and time-lapse images
- Generate AVI visualizations to demonstrate segmentation results
- Provide theoretical explanation of the chosen algorithms
- Optimize segmentation by tuning algorithm parameters and applying image morphology operations

---

## Part II: Segmentation using Graph-Cut and Active Contour Methods

### Tools and Resources
- Public implementations from:
  - Graph-Cut:
    - http://www.cis.upenn.edu/~jshi/software/
    - http://cs.brown.edu/~pff/segment/
  - Active Contour:
    - http://www.iacl.ece.jhu.edu/static/gvf/
    - http://www.imagecomputing.org/~cmli/DRLSE/

### Tasks
- Select two graph-cut and two active contour segmentation algorithms
- Apply these algorithms to the same datasets from Part I
- Tune parameters for improved segmentation performance
- Compare segmentation results qualitatively and quantitatively with those from Part I
- Summarize theoretical foundations for each approach

---

## Deliverables

- **Comprehensive Report** covering:
  - Methodology
  - Algorithmic theory
  - Parameter tuning
  - Visual and analytical comparison of results
- **MATLAB Code** used for all segmentation experiments
- **AVI videos** showing dynamic segmentation of time-lapse sequences
- **Figures and plots** highlighting segmentation accuracy and visual quality

---

## Example: Using MATITK in MATLAB

```matlab
% Load and convert 2D image to 3D for MATITK
filename = 'Blue0001.tif';
Img = double(imread(filename));
imgSz = size(Img);
D = zeros(imgSz(1), imgSz(2), 2);
D(:, :, 1) = Img;
D(:, :, 2) = Img;

% Apply Otsu's thresholding
b = matitk('SOT', [max(D(:))], double(D));
figure; imagesc(squeeze(b(:,:,1))); colormap gray; axis off; axis equal;
```
