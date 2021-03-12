classdef(SharedTestFixtures = {DownloadYolov2Fixture}) tload < matlab.unittest.TestCase
    % Test for loading the downloaded models.
    
    % Copyright 2021 The MathWorks, Inc.
    
    % The shared test fixture DownloadYolov2Fixture calls
    % downloadPretrainedYOLOv2. Here we check the properties of
    % downloaded models.
    
    properties        
        DataDir = fullfile(getRepoRoot());
        ExpectedFields = {'ModelName','Network','TrainingImageSize','AnchorBoxes','ClassNames'};
    end
    
     
    properties(TestParameter)
        Model = iGetDifferentModels();       
    end
    
    methods(Test)
        function verifyModelAndFields(test,Model)
            % Test point to verify the fields of the downloaded models are
            % as expected.
            
            import matlab.unittest.constraints.IsSameSetAs;           
            expectedModelName = 'importedNetwork';
            loadedModel = load(fullfile(test.DataDir,Model.dataFileName));
            
            test.verifyClass(loadedModel.yolov2Detector,'yolov2ObjectDetector');
            test.verifyEqual(loadedModel.yolov2Detector.ModelName,expectedModelName);
            test.verifyThat(fieldnames(loadedModel.yolov2Detector),IsSameSetAs(test.ExpectedFields));
            test.verifyEqual(loadedModel.yolov2Detector.AnchorBoxes,Model.expectedAnchorBoxes);
            test.verifyEqual(loadedModel.yolov2Detector.ClassNames,Model.expectedClasses);
        end        
    end
end
function Model = iGetDifferentModels()
% Load darknet19-voc
dataFileName = 'darknet19-voc.mat';

% Expected anchor boxes and classes.
expectedAnchorBoxes = [55,42; 128,102; 259,162; 155,303; 320,360];
expectedClasses = categorical({'aeroplane',	'bicycle',	'bird',	'boat',	'bottle'	,'bus',	'car'	,'cat'	,'chair',	'cow',	'diningtable',	'dog',...
    'horse'	,'motorbike',	'person', 'pottedplant'	,'sheep'	,'sofa'	,'train',	'tvmonitor'});
detectorDarknetVoc = struct('dataFileName',dataFileName,...
    'expectedAnchorBoxes',expectedAnchorBoxes,'expectedClasses',expectedClasses);

% Load darknet19-coco
dataFileName = 'darknet19-coco.mat';

% Expected anchor boxes and classes.
expectedAnchorBoxes = [22,18; 66,60; 175,107;113,252;293,313];
expectedClasses = categorical({'person', 	'bicycle', 	'car', 	'motorbike', 	'aeroplane', 	'bus', 	'train', 	'truck', 	'boat', 	'traffic light', 	'fire hydrant', 	'stop sign', 	'parking meter', 	'bench',...
	'bird', 	'cat', 	'dog', 	'horse', 	'sheep', 	'cow', 	'elephant', 	'bear', 	'zebra', 	'giraffe', 	'backpack', 	'umbrella', 	'handbag', 	'tie', 	'suitcase',...
 	'frisbee', 	'skis', 	'snowboard', 	'sports ball', 	'kite', 	'baseball bat', 	'baseball glove', 	'skateboard', 	'surfboard', 	'tennis racket', 	'bottle', 	'wine glass',...
 	'cup', 	'fork', 	'knife', 	'spoon', 	'bowl', 	'banana', 	'apple', 	'sandwich', 	'orange', 	'broccoli', 	'carrot', 	'hot dog', 	'pizza', 	'donut', 	'cake', 	'chair', 	'sofa', ...
	'pottedplant', 	'bed', 	'diningtable', 	'toilet', 	'tvmonitor', 	'laptop', 	'mouse', 	'remote', 	'keyboard', 	'cell phone', 	'microwave', 	'oven', 	'toaster', 	'sink',...
 	'refrigerator', 	'book', 	'clock', 	'vase', 'scissors', 'teddy bear',	'hair drier',	'toothbrush'});

detectorDarknetCoco = struct('dataFileName',dataFileName,...
    'expectedAnchorBoxes',expectedAnchorBoxes,'expectedClasses',expectedClasses);
% Load tinyYOLOv2-coco
dataFileName = 'tinyYOLOv2-coco.mat';

% Expected anchor boxes and classes.
detectorTinyYoloCoco = struct('dataFileName',dataFileName,...
    'expectedAnchorBoxes',expectedAnchorBoxes,'expectedClasses',expectedClasses);

 Model = struct(...
     'detectorDarknetVoc', detectorDarknetVoc,'detectorDarknetCoco',detectorDarknetCoco,'detectorTinyYoloCoco',detectorTinyYoloCoco);
end