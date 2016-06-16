//
//  ColorKeyAnimationViewController.m
//  CAMediaTimingFunction-14
//
//  Created by long on 6/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ColorKeyAnimationViewController.h"


@interface ColorKeyAnimationViewController ()
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation ColorKeyAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(100, 100, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (IBAction)animtionAction:(id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor,
                         ];
    
    // add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn,fn,fn];
    [self.colorLayer addAnimation:animation forKey:nil];
}


@end

