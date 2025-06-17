---
layout: page
title: Hole Detection in Robotics
description: Computer vision system for automated hole detection in manufacturing robotics at Microsoft.
summary: Sophisticated machine vision system leveraging deep learning and computer vision techniques for automated hole detection, surface defect inspection, and quality control in manufacturing environments. The project employs convolutional neural networks (CNNs), advanced image processing algorithms, and real-time analysis to identify, classify, and measure holes, surface defects, and manufacturing anomalies with sub-millimeter precision. Designed for industrial quality control applications in automotive, aerospace, and precision manufacturing industries where component integrity is critical.
img: assets/img/microsoft.png
redirect: https://github.com/nanaimi/HoleDet
importance: 2
category: work
date: 2023-09-01
technologies:
  - Python
  - PyTorch
  - Computer Vision
  - YOLO
  - OpenCV
  - Manufacturing
---

## Project Overview

The HoleDet project represents a cutting-edge approach to automated quality inspection in manufacturing environments, specifically focusing on hole detection and surface defect analysis using advanced computer vision and deep learning techniques. Developed during my tenure at Microsoft, this system addresses critical challenges in industrial quality control where precision and reliability are paramount.

## Technical Architecture

### Core Vision System
The system employs a sophisticated optical measurement framework designed for fine hole inspection with diameters ranging from 4mm to 6mm and depths up to 47mm. The architecture includes:

- **Sight-pipe Technology**: Custom optical system that imports external illumination into narrow spaces while simultaneously exporting high-resolution images
- **Flexible LED Array**: Adaptive lighting system designed for uniform illumination in confined spaces
- **High-Precision Imaging**: Sub-millimeter accuracy with measurement standard deviations under 10μm

### Deep Learning Models
The project implements multiple state-of-the-art deep learning architectures:

- **YOLOv8 Variants**: Including YOLOv8n-seg, YOLOv8s-seg, and YOLOv8m-seg for real-time defect detection
- **Mask R-CNN**: For precise instance segmentation of complex defects
- **Custom CNN Architectures**: Tailored for hole detection and classification tasks
- **Multi-scale Feature Extraction**: Enabling detection of defects ranging from 0.1mm to several millimeters

## Key Features

### Automated Defect Detection
- **Surface Anomaly Identification**: Detection of pits, bumps, cracks, scratches, and other surface defects
- **Hole Classification**: Automated identification and measurement of circular defects and holes
- **Real-time Processing**: Sub-10 minute inspection cycles for complex components
- **High Accuracy**: Achieved 97.30% accuracy with 2.67% wrong classification rate

### Advanced Image Processing
- **Arc Surface Projection Correction**: Compensates for cylindrical surface distortions
- **Template Matching**: Robust pattern recognition for standardized hole types
- **Blob Detection**: Precise identification of irregular defects
- **Error Compensation**: Algorithms to correct for manufacturing and assembly tolerances

### Manufacturing Integration
- **Robotic Compatibility**: Seamless integration with industrial robotic systems
- **Real-time Quality Control**: Inline inspection capabilities for production environments
- **Multi-axis Motion Control**: Coordinated movement systems for comprehensive surface coverage
- **Data Logging**: Comprehensive tracking and reporting of inspection results

## Performance Metrics

The system demonstrates exceptional performance across multiple benchmarks:

- **Defect Detection**: 98.10% recall rate for critical defects
- **Measurement Accuracy**: Standard deviation of ~10μm for hole diameter measurements
- **Processing Speed**: Complete inspection in under 10 minutes per component
- **Size Range**: Effective detection of defects from 0.1mm to 0.4mm
- **Working Distance**: Inspection capability up to 47mm depth

## Applications

### Industrial Use Cases
- **Automotive Manufacturing**: Engine block inspection, transmission component analysis
- **Aerospace Components**: Critical part validation for safety-critical applications
- **Precision Machining**: Quality control for high-tolerance manufacturing
- **Assembly Line Integration**: Automated pass/fail decision making

### Technical Benefits
- **Cost Reduction**: Minimizes manual inspection labor and associated errors
- **Consistency**: Eliminates operator variability in quality assessment
- **Traceability**: Comprehensive documentation of inspection results
- **Scalability**: Adaptable to various component sizes and types

## Innovation Highlights

### Novel Approaches
- **Hybrid Inspection Method**: Combines structured light and vision-based techniques
- **Adaptive Illumination**: Dynamic lighting adjustment for optimal defect visibility
- **Multi-modal Analysis**: Integration of geometric and appearance-based features
- **Edge Computing**: Real-time processing capabilities for production environments

### Research Contributions
- **Algorithm Development**: Novel CNN architectures optimized for manufacturing inspection
- **Optical System Design**: Custom sight-pipe technology for confined space imaging
- **Error Analysis**: Comprehensive study of manufacturing and assembly error compensation
- **Performance Validation**: Extensive benchmarking against precision measurement standards

This project represents a significant advancement in automated quality inspection technology, demonstrating how modern computer vision and deep learning techniques can be successfully applied to solve real-world manufacturing challenges with industrial-grade precision and reliability.

