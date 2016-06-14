//
//  BasicAnimationViewController.m
//  Animation-11
//
//  Created by long on 6/14/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()
@property (nonatomic, weak) IBOutlet UIView *layerView;

@property (nonatomic, strong) CALayer *colorLayer;
- (IBAction)changeColor:(id)sender;

@end

@implementation BasicAnimationViewController


- (void)viewDidLoad{
    [super viewDidLoad];

    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50,50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
    
}

- (IBAction)changeColor:(id)sender {
    
   
    [self createBasicAnimationWithSetDelegate];

}


- (void)createBasicAnimation{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    // create a basic animation
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    //    basicAnimation.fromValue = (__bridge id)self.colorLayer.backgroundColor;
    //    self.colorLayer.backgroundColor = color.CGColor;
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.toValue = (__bridge id )(color.CGColor);
    // apply animation to layer
    //    [self.colorLayer addAnimation:basicAnimation forKey:nil];
    //    self.colorLayer.backgroundColor = color.CGColor;
    
    [self applyBasicAnimation:basicAnimation toLayer:self.colorLayer];
}

- (void)createBasicAnimationWithSetDelegate{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    // create a basic animation
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.toValue = (__bridge id )(color.CGColor);
    basicAnimation.delegate = self;
    // apply animation to layer
    [self.colorLayer addAnimation:basicAnimation forKey:nil];

    
//    [self applyBasicAnimation:basicAnimation toLayer:self.colorLayer];
}


/**
 *   禁止修改动画立刻恢复到原始状态
 *  @param animation <#animation description#>
 *  @param layer     <#layer description#>
 */
- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer{
    animation.fromValue = [layer.presentationLayer ? :layer valueForKeyPath:animation.keyPath];
    // update the property in advance
    // note: this approach will only work if toValue != nil
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; // 禁止隐式动画
    [layer  setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    // apply animation to layer
    [layer addAnimation:animation forKey:nil];
}

#pragma mark -------------------
#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animationDidStart %@",anim);
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    // set the backgoundColor property to match animation to Value
    NSLog(@"animationDidStop %@ %@",anim ,flag ? @"YES":@"NO");
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

@end
