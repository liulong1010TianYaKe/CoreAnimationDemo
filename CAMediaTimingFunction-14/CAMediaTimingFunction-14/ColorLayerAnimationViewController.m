//
//  ColorLayerAnimationViewController.m
//  CAMediaTimingFunction-14
//
//  Created by long on 6/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ColorLayerAnimationViewController.h"



@interface ColorLayerAnimationViewController ()
@property (nonatomic, strong)  CALayer *colorLayer;
@end

@implementation ColorLayerAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    [CATransaction commit];
}


@end
