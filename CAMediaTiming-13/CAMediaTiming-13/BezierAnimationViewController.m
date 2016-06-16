//
//  BezierAnimationViewController.m
//  CAMediaTiming-13
//
//  Created by long on 6/15/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "BezierAnimationViewController.h"


@interface BezierAnimationViewController ()
@property (nonatomic, weak) IBOutlet UILabel *lblTimeOffset;
@property (nonatomic, weak) IBOutlet UILabel *lblSpeed;
@property (nonatomic, weak) IBOutlet UISlider *sliderTimeOffset;
@property (nonatomic, weak) IBOutlet UISlider *sliderSpeed;

@property (nonatomic, strong) UIBezierPath *berzierPath;
@property (nonatomic, strong) CALayer *shipLayer;
@end

@implementation BezierAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.berzierPath = [[UIBezierPath alloc] init];
    [self.berzierPath moveToPoint:CGPointMake(100, 150)];
    [self.berzierPath addCurveToPoint:CGPointMake(400, 150) controlPoint1:CGPointMake(174, 0) controlPoint2:CGPointMake(300, 300)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.berzierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 40, 40);
    self.shipLayer.position = CGPointMake(100, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"ship"].CGImage;
    [self.view.layer addSublayer:self.shipLayer];
    
    [self updateSliders:nil];
    
    
}
- (IBAction)updateSliders:(id)sender {
    CFTimeInterval timeOffset = self.sliderTimeOffset.value;
    self.lblTimeOffset.text = [NSString stringWithFormat:@"%0.2f",timeOffset];
    float speed = self.sliderSpeed.value;
    self.lblSpeed.text = [NSString stringWithFormat:@"%0.2f",speed];
}

- (IBAction)payAction:(id)sender {
    

    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.timeOffset = self.sliderTimeOffset.value;
    animation.speed = self.sliderSpeed.value;
    animation.duration = 1.0;
    animation.path = self.berzierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.removedOnCompletion = NO;
    [self.shipLayer addAnimation:animation forKey:@"slide"];
}

@end
