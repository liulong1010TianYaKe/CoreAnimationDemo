//
//  ViewController.m
//  CAGradientLayer-06
//
//  Created by long on 6/13/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self  createGradientLayer];
    [self createGradientLayer2];
}


- (void)createGradientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 200, 200);
    [self.view.layer  addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

- (void)createGradientLayer2{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 350, 200, 200);
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    gradientLayer.locations = @[@0.0, @0.35, @0.8];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:gradientLayer];
}
@end
