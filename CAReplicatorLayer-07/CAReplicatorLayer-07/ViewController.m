//
//  ViewController.m
//  CAReplicatorLayer-07
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
//    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
//    [self setupReplicatorLayer];
}


- (void)setupReplicatorLayer{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:replicator];
    
    replicator.instanceCount = 10;
//    replicator.preservesDepth = YES;
    CATransform3D  transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0); // 位移
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1); // 空间旋转(弧度)
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    //通过逐步减少蓝色和绿色通道 , 将图层颜色转换成了红色
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(self.view.frame.size.width/2 , 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
}

@end
