%% Configure Pretrained YOLO v2 Object Detector for Transfer Learning
% The following code demonstrates configuring a pretrained YOLO v2 network 
% for transfer learning on the custom dataset.
%% Download Pretrained Detector

modelName = 'tinyYOLOv2-coco';
helper.downloadPretrainedYOLOv2(modelName);
pretrained = load(modelName);
detector = pretrained.yolov2Detector;
%% Configure Pretrained Network
% To configure the YOLO v2 network for transfer learning, you should replace 
% the last convolutional layer and yolov2OutputLayer in the network obtained from 
% the pretrained detector.
% 
% *Replace Last Convolutional Layer*
% 
% Specify the class names for transfer learning, number of object classes to 
% detect, and number of prediction elements per anchor box. The number of predictions 
% per anchor box should be 5 plus the number of object classes. "5" denotes the 
% 4 bounding box attributes and 1 object confidence.
classNames = {'vehicle'};
numClasses = size(classNames, 2);
numPredictorsPerAnchor = 5 + numClasses;

% Create a new convolution layer with a filter size of [1, 1]. The number of 
% filters for the new convolution layer is a product of the number of anchor boxes 
% and the number of prediction elements per anchor box.
numAnchorBoxes = size(detector.AnchorBoxes,1);
numFilters = numAnchorBoxes * numPredictorsPerAnchor;
convLayer = convolution2dLayer(1,numFilters,'Name','conv2d','WeightsInitializer',"narrow-normal");

% Replace the last convolution layer in the pretrained network with the new 
% convolution layer.
lgraph = layerGraph(detector.Network);
lgraph = replaceLayer(lgraph,'conv2d_9',convLayer);

% Additionally, you should replace the yolov2TransfromLayer of the pretrained 
% network by creating a new yolov2TransfromLayer, if the number of anchor boxes 
% is different from the number of anchor boxes in the pretrained detector.
 
% Replace the YOLO v2 output layer of the pretrained network with a new yolov2OutputLayer 
% created using class names from the custom data.
yolov2OutLayer = yolov2OutputLayer(detector.AnchorBoxes,'Classes',classNames,'Name','yolov2Output');
lgraph = replaceLayer(lgraph,'yolov2Out',yolov2OutLayer);

% Use analyzeNetwork to visualize the new network.
analyzeNetwork(lgraph);

% You can pass the lgraph to trainYOLOv2ObjectDetector, to obtain 
% yolov2ObjectDetector object trained on the custom dataset.

% Copyright 2021 The MathWorks, Inc.
