//
//  RecordingCirleViewController.m
//  CAShapeLayer-03
//
//  Created by long on 6/17/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "RecordingCirleViewController.h"
#import "MTRecordingCicleOverlayView.h"

@implementation RecordingCirleViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    MTRecordingCicleOverlayView *recodingCircleOverlayView = [[MTRecordingCicleOverlayView alloc] initWithFrame:CGRectMake(50, 100, 350, 350) strokeWith:7.0f insets:UIEdgeInsetsMake(10, 0.f, 10.f, 0.f)];
    recodingCircleOverlayView.duration = 10.f;
    [self.view addSubview:recodingCircleOverlayView];
}


@end
