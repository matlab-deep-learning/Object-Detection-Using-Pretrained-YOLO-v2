# Pretrained YOLO v2 For Object Detection

This repository implements pretrained YOLO v2 [1] object detectors in MATLAB.

Requirements
------------  

- MATLAB R2020a or later
- Deep Learning Toolbox
- Computer Vision Toolbox

Overview
--------

This repository implements three variants of the YOLO v2 object detector: 
- darknet19-voc: Darknet-19 base network trained on VOC dataset. 
- darknet19-coco: Darknet-19 base network trained on COCO dataset.
- tinyYOLOv2-coco: Smaller base network trained on COCO dataset. 

The pretrained networks are trained to detect different object categories including person, car, traffic light, etc. These networks are trained using either COCO 2017 [2] or PASCAL VOC [3] datasets which have 80 and 20 different object categories, respectively.

YOLO v2 is a popular single stage object detectors that performs detection and classification using CNNs. The YOLO v2 network is composed of a backbone feature extraction network and a detection head for the localization of objects in an image. For more information about YOLO v2, see [Getting Started with YOLO v2](https://www.mathworks.com/help/vision/ug/getting-started-with-yolo-v2.html). 

![alt text](https://www.mathworks.com/help/vision/ug/yolo_model.png) 

Getting Started
---------------

Download or clone this repository to your machine and open it in MATLAB.

### Download the pretrained network
Use the below helper to download the pretrained network. Specify “darknet19-voc" or “darknet19-coco" or “tinyYOLOv2-coco” to download the required pretrained network.  

`detector = helper.downloadPretrainedYOLOv2('tinyYOLOv2-coco');`

Detect Objects Using Pretrained YOLO v2
---------------------------------------

```
% Read test image.
img = imread('sherlock.jpg');

% Detect objects in the test image.
[boxes, scores, labels] = detect(detector, img);

% Visualize detection results.
img = insertObjectAnnotation(img, 'rectangle', bboxes, scores);
figure, imshow(img)
```
![alt text](images/results.jpg?raw=true)

Choosing a Pretrained YOLO v2 Object Detector
---------------------------------------------

You can choose the ideal YOLO v2 object detector for your application based on the below table:

| Model | mAP | Size (MB) | Classes | Speed in Frames Per Second (FPS) |
| ------ | ------ |  ------ | ------ | ------ |
| Darknet19-VOC | 75.4 | 180 | [voc class names](+helper/pascal-voc-classes.txt) | 19 |
| Darknet19-COCO | 28.7 | 181 | [coco class names](+helper/coco-classes.txt) | 17.8 |
| Tiny-YOLO_v2-COCO | 10.5 | 40 | [coco class names](+helper/coco-classes.txt) | 32 |

- Performance (in FPS) is measured on a TITAN-XP machine using:
    - 416x416 image for Darknet19-VOC.
    - 608x608 image for Darknet19-COCO.
    - 416x416 image for Tiny-YOLO_v2-COCO.
- mAP for models trained on the COCO dataset is computed as average over IoU of .5:.95.

Train Custom YOLO v2 Detector Using Transfer Learning
------------------------------------------------------------

Transfer learning enables you to adapt a pretrained YOLO v2 object detector to your dataset. Create a custom YOLO v2 network for transfer learning with a new set of classes using the configureYOLOv2TransferLearn.mlx example. For more information about training a YOLO v2 object detector, see [Object Detection using YOLO v2 Deep Learning Example](https://www.mathworks.com/help/vision/ug/train-an-object-detector-using-you-only-look-once.html).

Code Generation
---------------

Code generation enables you to generate code and deploy YOLO v2 on multiple embedded platforms. For more information about generating CUDA® code using the YOLO v2 object detector see [Code Generation for Object Detection by Using YOLO v2](https://www.mathworks.com/help//deeplearning/ug/code-generation-for-object-detection-using-yolo-v2.html)

References
-----------

[1] Redmon, Joseph, and Ali Farhadi. "YOLO9000: better, faster, stronger." Proceedings of the IEEE conference on computer vision and pattern recognition. 2017.

[2] Lin, T., et al. "Microsoft COCO: Common objects in context. arXiv 2014." arXiv preprint arXiv:1405.0312 (2014).

[3] The PASCAL Visual Object Classes Challenge: A Retrospective Everingham, M., Eslami, S. M. A., Van Gool, L., Williams, C. K. I., Winn, J. and Zisserman, A. International Journal of Computer Vision, 111(1), 98-136, 2015.


Copyright 2021 The MathWorks, Inc.
