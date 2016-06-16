//
//  KeyAnimationViewController.m
//  Animation-11
//
//  Created by long on 6/14/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "KeyAnimationViewController.h"

@interface KeyAnimationViewController ()
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) CALayer *shipLayer;
@end

@implementation KeyAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [self createColorLayer];
    
//    [self createKeyFameAnimation];
//    [self creatShipAnimation];
    [self createGroupAnimations];

}

- (void)createColorLayer{
    // create a colorlayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(200, 200, 100, 100);
    [self.view.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
}

- (void)createKeyFameAnimation{
    //  create a path
    UIBezierPath *berizerPath = [[UIBezierPath alloc] init];
    [berizerPath moveToPoint:CGPointMake(100, 150)];
    [berizerPath addCurveToPoint:CGPointMake(400, 150) controlPoint1:CGPointMake(175, 0) controlPoint2:CGPointMake(325, 300)];
    // draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = berizerPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [self.view.layer addSublayer:pathLayer];
    
    // add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(100, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"ship"].CGImage;
    shipLayer.affineTransform = CGAffineTransformMakeRotation(M_PI/4);
    [self.view.layer addSublayer:shipLayer];
    self.shipLayer = shipLayer;

    // create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = berizerPath.CGPath;
//    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
}


- (IBAction)startAnimation:(id)sender {
  
    
}

- (void)createColorKeyAnimation{
    // create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor];
    // apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)creatShipAnimation{
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(250, 250);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:animation forKey:nil];
}

/**
 *  组合动画
 */
- (void)createGroupAnimations{
    UIBezierPath *berizerPath = [[UIBezierPath alloc] init];
    [berizerPath moveToPoint:CGPointMake(150, 100)];
    [berizerPath addCurveToPoint:CGPointMake(400, 150) controlPoint1:CGPointMake(175, 0) controlPoint2:CGPointMake(325, 300)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = berizerPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [self.view.layer addSublayer:pathLayer];
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(150, 100);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = berizerPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CATransition *animation3 = [CATransition animation];
    animation3.type = kCATransitionPush;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1,animation2,animation3];
    groupAnimation.duration = 4.0;
    
   
    [colorLayer addAnimation:groupAnimation forKey:nil];
}
@end
