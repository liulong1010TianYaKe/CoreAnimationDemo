//
//  ShipAnimationViewConroller.m
//  CAMediaTiming-13
//
//  Created by long on 6/15/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ShipAnimationViewConroller.h"

@interface ShipAnimationViewConroller ()
@property (nonatomic, weak) IBOutlet UITextField *durationField;
@property (nonatomic, weak) IBOutlet UITextField *repeatField;
@property (nonatomic, weak) IBOutlet UIButton *startButton;

@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation ShipAnimationViewConroller

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 128, 128);
    self.shipLayer.position = self.view.center;
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"ship"].CGImage;
    [self.view.layer addSublayer:_shipLayer];
    self.durationField.text = @"2.0";
    self.repeatField.text = @"3.5";
}

- (IBAction)startAnimationAction:(id)sender {
    
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeatCount = [self.repeatField.text floatValue];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 2);
    animation.autoreverses = YES;
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    
    [self setControlsEnabled:NO];
}


- (void)setControlsEnabled:(BOOL)enabled{
    for (UIControl *control in @[self.durationField,self.repeatField,self.startButton]) {
        control.enabled = enabled;
        control.alpha  = enabled ? 1.0:0.25f;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self setControlsEnabled:YES];
}

@end
