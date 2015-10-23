//
//  CameraView.h
//  Add hours II
//
//  Created by ThuyenBV on 12/18/14.
//  Copyright (c) 2014 ThuyenBV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, DevicePositon) {
    DevicePositonFront,
    DevicePositonBack
};

typedef void(^CaptureImage)(UIImage* image);

@interface CameraView : UIView

@property (nonatomic, retain) AVCaptureSession           *session;
@property (nonatomic, retain) AVCaptureDeviceInput       *input;
@property (nonatomic, retain) AVCaptureDevice            *device;
@property (nonatomic, retain) AVCaptureStillImageOutput  *imageOutput;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *preview;

- (void)setCameraInPosition:(DevicePositon)position;
- (void)captureImage:(CaptureImage)captureDone;
- (void)switchCameraDevice;
- (void)removeCamera;

@end
