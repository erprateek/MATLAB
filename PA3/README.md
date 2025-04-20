# Microscope Characterization & Curvilinear Feature Detection

## Overview

This project showcases advanced techniques in image processing and bioimage analysis, with a focus on microscope system characterization and the implementation of a state-of-the-art algorithm for detecting curvilinear structures in microscopy data. It includes both quantitative analysis and algorithmic implementation.

The project is divided into two parts:

1. **Microscope Characterization**
2. **Curvilinear Feature Detection using Steger’s Algorithm**

---

## Part I: Microscope Characterization

### Tools and Environment
- MATLAB
- Microscopy image datasets (provided as `.rar` archives)

### Objectives

#### 1. Background Noise Analysis
- Crop and save a large background region from a time series of fluorescence microscopy images.
- Analyze spatial and temporal characteristics of background noise.
- Assess the noise distribution (e.g., normality, whiteness).
- Investigate spatial and temporal noise variation.

#### 2. Illumination Uniformity
- Develop and implement quantitative metrics to evaluate uniformity of illumination across the field of view.
- Focus on background areas devoid of biological structures.

#### 3. Pixel Calibration
- Perform manual/interactive pixel size calibration using micrometer images.
- Implement an automated or semi-automated method for calibration.
- Use known micrometer slide specifications (TedPella No. 2280-16).

#### 4. (Optional Extension) Directional Anisotropic Filtering
- Implement non-iterative anisotropic Gaussian filtering as described by Geusebroek et al.
- Apply directional filters at multiple orientations (30° to 150°).
- Visualize and compare the results for enhanced directional features.

---

## Part II: Curvilinear Feature Detection

### Data
- Microscopy test images: `curv_det_01.tif`, `curv_det_02.tif`, `curv_det_03.tif`

### Objectives

#### 1. Steger’s Curvilinear Detection Algorithm
- Implement the algorithm for detecting pixels on curvilinear structures.
- Focus on the symmetric contrast case.
- Identify and visualize the curvilinear structures.

#### 2. (Optional Extension) Pixel Linking
- Implement a pixel-linking strategy to connect detected points into continuous curves.

---

## Deliverables

- **MATLAB Code** for all modules (background noise analysis, calibration, detection)
- **Plots and Visualizations** of results, including:
  - Noise distribution plots
  - Illumination maps
  - Calibration curves
  - Curvilinear feature overlays
- **Report** outlining:
  - Methodology and algorithmic details
  - Experimental observations
  - References and citations

---

## Skills Demonstrated

- Fluorescence microscopy system characterization
- Noise and illumination profiling
- Spatial calibration using micrometer slides
- Implementation of Steger’s algorithm for curvilinear detection
- Directional filtering with anisotropic Gaussian kernels
- Data visualization and algorithm evaluation in MATLAB

---

## Reference

- C. Steger, *An unbiased detector of curvilinear structures*, IEEE Trans. Pattern Analysis and Machine Intelligence, vol. 20, pp. 113–125, 1998.
- J.-M. Geusebroek et al., *Fast anisotropic Gaussian filtering*, IEEE Trans. Image Processing, vol. 12, no. 8, pp. 938–943, 2003.

---

## Acknowledgments

Originally developed as part of coursework at Carnegie Mellon University. Adapted for professional demonstration in bioimage analysis and image processing.

