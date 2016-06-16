//
//  DoorAnimationViewController.m
//  CAMediaTiming-13
//
//  Created by long on 6/15/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "DoorAnimationViewController.h"


@interface DoorAnimationViewController ()

@property (nonatomic, strong ) CALayer* doorLayer;

@end

@implementation DoorAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, 128, 256);
    self.doorLayer.position = CGPointMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"door"].CGImage;
    [self.view.layer addSublayer:self.doorLayer];
    
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    //add pan gesture recognizer to handle swipes
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    self.view.userInteractionEnabled = YES;
    // pasue all layer animation
    self.doorLayer.speed = 0.0;
    //apply swinging animation (which won't play because layer is paused)
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [self.doorLayer addAnimation:animation forKey:nil];
    


    
    
}

- (IBAction)startAnimationAction:(id)sender {
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    self.view.layer.sublayerTransform = perspective;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [self.doorLayer addAnimation:animation forKey:nil];
    
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    // get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    //convert from points to animation duration // using a reasonable scale factor
    x /= 200.f;
    // update timeoffset and clamp result
    CFTimeInterval timeoffset = self.doorLayer.timeOffset;
    timeoffset = MIN(0.999, MAX(0.0, timeoffset - x));
    self.doorLayer.timeOffset = timeoffset;
    // reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}
@end
