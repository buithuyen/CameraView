//
//  BVViewController.m
//  CameraView
//
//  Created by ThuyenBV on 10/23/2015.
//  Copyright (c) 2015 ThuyenBV. All rights reserved.
//

#import "BVViewController.h"
#import <CameraView/CameraView.h>

@interface BVViewController ()

@property (weak, nonatomic) IBOutlet CameraView *camera;

@end

@implementation BVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.camera setCameraInPosition:DevicePositonFront];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
