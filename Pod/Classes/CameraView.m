//
//  CameraView.m
//  Add hours II
//
//  Created by ThuyenBV on 12/18/14.
//  Copyright (c) 2014 ThuyenBV. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView {
    DevicePositon positionCam;
}

- (void)drawRect:(CGRect)rect {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setCameraInPosition:(DevicePositon)position {
#if TARGET_IPHONE_SIMULATOR
    
// TODO: Alert here
    
#else
    
    self.session = [AVCaptureSession new];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    NSArray *devices = [NSArray new];
    devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (position == DevicePositonBack) {
            if ([device position] == AVCaptureDevicePositionBack) {
                _device = device;
                positionCam = DevicePositonBack;
                break;
            }
        }else {
            if ([device position] == AVCaptureDevicePositionFront) {
                _device = device;
                positionCam = DevicePositonFront;
                break;
            }
        }
    }
    
    NSError *error;
    
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:&error];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    } else {
        // TODO: Alert here
    }
    
    self.imageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [self.imageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.imageOutput];
    self.preview = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preview setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self removeCamera];
    [self.layer addSublayer:self.preview];
    
    [self.session startRunning];
    
    self.session = [AVCaptureSession new];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
#endif
}

- (void)switchCameraDevice {
#if TARGET_IPHONE_SIMULATOR
    
    // TODO: Alert here
    
#else
    if (!self.session) {
        return;
    }
    
    if ([self.device position] == AVCaptureDevicePositionBack) {
        [self setCameraInPosition:DevicePositonFront];
    } else if ([self.device position] == AVCaptureDevicePositionFront) {
        [self setCameraInPosition:DevicePositonBack];
    }
#endif
}

- (void)captureImage:(CaptureImage)captureDone {
#if TARGET_IPHONE_SIMULATOR
    
    // TODO: Alert here
    
#else
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.imageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                  completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                      
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
                            
         captureDone(image);
    }];
#endif
}

- (void)removeCamera {
    NSArray *arrSubLayer = [self.layer sublayers];
    for (CALayer *layer in arrSubLayer) {
        if (layer == self.preview) {
            [layer removeFromSuperlayer];
        }
    }
}

@end
