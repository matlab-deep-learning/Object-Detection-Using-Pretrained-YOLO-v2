classdef(SharedTestFixtures = {DownloadYolov2Fixture}) tdownloadPretrainedYOLOv2 < matlab.unittest.TestCase
    % Test for downloadPretrainedYOLOv2
    
    % Copyright 2021 The MathWorks, Inc.
    
    % The shared test fixture DownloadYolov2Fixture calls
    % downloadPretrainedYOLOv2. Here we check that the downloaded files
    % exists in the appropriate location.
    
    properties        
        DataDir = fullfile(getRepoRoot());
    end
    
     
    properties(TestParameter)
        Model = {'darknet19-voc','darknet19-coco','tinyYOLOv2-coco'};
    end
    
    methods(Test)
        function verifyDownloadedFilesExist(test,Model)
            dataFileName = [Model,'.mat'];
            test.verifyTrue(isequal(exist(fullfile(test.DataDir,dataFileName),'file'),2));
        end
    end
end
