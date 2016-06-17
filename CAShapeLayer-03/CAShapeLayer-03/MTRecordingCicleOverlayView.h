//
//  MTRecordingCicleOverlayView.h
//  CAShapeLayer-03
//
//  Created by long on 6/17/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTRecordingCicleOverlayView : UIView

@property (nonatomic, assign) CGFloat strokeWitdh;

@property (nonatomic, assign) CGFloat duration;

- (id)initWithFrame:(CGRect)frame strokeWith:(CGFloat)strokeWitdh insets:(UIEdgeInsets)insets;


@end
