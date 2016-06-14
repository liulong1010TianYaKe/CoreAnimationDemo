//
//  FireViewController.m
//  CAEmitterLayer-10
//
//  Created by long on 6/14/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "FireViewController.h"

@implementation FireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:emitterLayer];
    
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width / 2.0, emitterLayer.frame.size.height / 2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"Spark"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4; //粒子的透明度每过一秒就是减少0.4
    cell.velocity = 50;
    cell.emissionRange = M_PI * 2.0;
    emitterLayer.emitterCells = @[cell];
}


@end
