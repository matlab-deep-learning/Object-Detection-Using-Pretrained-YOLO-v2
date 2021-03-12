classdef DownloadYolov2Fixture < matlab.unittest.fixtures.Fixture
    % DownloadYolov2Fixture   A fixture for calling downloadPretrainedYOLOv2 if
    % necessary. This is to ensure that this function is only called once
    % and only when tests need it. It also provides a teardown to return
    % the test environment to the expected state before testing.
    
    % Copyright 2021 The MathWorks, Inc
    
    properties(Constant)
        Yolov2DataDir = fullfile(getRepoRoot())
    end
    
    properties
        Darknet19VocExist (1,1) logical
        Darknet19CocoExist (1,1) logical
        TinyYolov2CocoExist (1,1) logical
    end
    
    methods
        function setup(this)            
            this.Darknet19VocExist = exist(fullfile(this.Yolov2DataDir,'darknet19-voc.mat'),'file')==2;
            this.Darknet19CocoExist = exist(fullfile(this.Yolov2DataDir,'darknet19-coco.mat'),'file')==2;
            this.TinyYolov2CocoExist = exist(fullfile(this.Yolov2DataDir,'tinyYOLOv2-coco.mat'),'file')==2;
            
            % Call this in eval to capture and drop any standard output
            % that we don't want polluting the test logs.
            if ~this.Darknet19VocExist
            	evalc('helper.downloadPretrainedYOLOv2(''darknet19-voc'');');                
            end
            if ~this.Darknet19CocoExist
            	evalc('helper.downloadPretrainedYOLOv2(''darknet19-coco'');');                
            end
            if ~this.TinyYolov2CocoExist
            	evalc('helper.downloadPretrainedYOLOv2(''tinyYOLOv2-coco'');');                
            end
        end
        
        function teardown(this)
            if ~this.Darknet19VocExist
            	delete(fullfile(this.Yolov2DataDir,'darknet19-voc.mat'));
            end
            if ~this.Darknet19CocoExist
            	delete(fullfile(this.Yolov2DataDir,'darknet19-coco.mat'));
            end
            if ~this.TinyYolov2CocoExist
            	delete(fullfile(this.Yolov2DataDir,'tinyYOLOv2-coco.mat'));
            end
        end
    end
end