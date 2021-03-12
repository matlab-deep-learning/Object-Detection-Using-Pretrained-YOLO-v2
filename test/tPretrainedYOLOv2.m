classdef(SharedTestFixtures = {DownloadYolov2Fixture}) tPretrainedYOLOv2 < matlab.unittest.TestCase
    % Test for PretrainedYOLOv2
    
    % Copyright 2021 The MathWorks, Inc.
    
    % The shared test fixture downloads the model. Here we check the
    % detections of each models.
    properties        
        RepoRoot = getRepoRoot;
    end
    
    properties(TestParameter)
        Model = iGetDifferentModels();
    end
    methods(Test)
        function exerciseDetection(test,Model)            
            detector = load(fullfile(test.RepoRoot,Model.dataFileName));
            image = imread(fullfile(test.RepoRoot,'images','results.jpg'));
            [bboxes, scores, labels] = detect(detector.yolov2Detector, image);
            test.verifyEqual(bboxes, Model.expectedBboxes);
            test.verifyEqual(double(scores), Model.expectedScores,'AbsTol',1e-4);
            test.verifyEqual(labels, Model.expectedLabels);            
        end       
    end
end

function Model = iGetDifferentModels()
% Load darknet19-voc
dataFileName = 'darknet19-voc.mat';

% Expected detection results.
expectedBboxes = [107, 14, 209, 191];
expectedScores = [0.9547];
expectedLabels = categorical({'dog'});
detectorDarknetVoc = struct('dataFileName',dataFileName,...
    'expectedBboxes',expectedBboxes,'expectedScores',expectedScores,...
    'expectedLabels',expectedLabels);

% Load darknet19-coco
dataFileName = 'darknet19-coco.mat';

% Expected detection results.
expectedBboxes = [113, 7, 198, 175; 2, 26, 282, 179];
expectedScores = [0.6153; 0.5];
expectedLabels = categorical({'dog';'sofa'});
detectorDarknetCoco = struct('dataFileName',dataFileName,...
    'expectedBboxes',expectedBboxes,'expectedScores',expectedScores,...
    'expectedLabels',expectedLabels);

% Load tinyYOLOv2-coco
dataFileName = 'tinyYOLOv2-coco.mat';

% Expected detection results.
expectedBboxes = [97,14,223,181];
expectedScores = [0.6987];
expectedLabels = categorical({'dog'});
detectorTinyYoloCoco = struct('dataFileName',dataFileName,...
    'expectedBboxes',expectedBboxes,'expectedScores',expectedScores,...
    'expectedLabels',expectedLabels);

 Model = struct(...
    'detectorDarknetVoc', detectorDarknetVoc,'detectorDarknetCoco',detectorDarknetCoco,'detectorTinyYoloCoco',detectorTinyYoloCoco);  
end