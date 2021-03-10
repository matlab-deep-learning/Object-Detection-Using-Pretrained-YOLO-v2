%% Object Detection Using YOLO v2 Object Detector
% The following code demonstrates running prediction on a pre-trained YOLO v2 
% network, trained on COCO dataset.
%% *Download the pre-trained network*

modelName = 'tinyYOLOv2-coco';
helper.downloadPretrainedYOLOv2(modelName);

pretrained = load(modelName);
detector = pretrained.yolov2Detector;

% Detect Objects using YOLO v2 Object Detector
% Read test image.
img = imread('sherlock.jpg');

% Detect objects in test image.
[boxes, scores, labels] = detect(detector, img);

% Visualize detection results.
img = insertObjectAnnotation(img,'rectangle',boxes,labels);
figure, imshow(img)


% Copyright 2021 The MathWorks, Inc.
