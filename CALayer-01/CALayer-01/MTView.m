//
//  MTView.m
//  CALayer-01
//
//  Created by long on 6/7/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTView.h"
#import "MTLayer.h"

/**
从下面的代码中可以看到：UIView在显示时其根图层会自动创建一个CGContextRef（CALayer本质使用的是位图上下文），
  同时调用图层代理（UIView创建图层会自动设置图层代理为其自身）的draw: inContext:方法并将图形上下文作为参数传递给这个方法。而在UIView的draw:inContext:方法中会调用其drawRect:方法，在drawRect:方法中使用UIGraphicsGetCurrentContext()方法得到的上下文正是前面创建的上下文。
 */
@implementation MTView

- (instancetype)initWithFrame:(CGRect)frame{
     NSLog(@"initWithFrame:");
    if (self = [super initWithFrame:frame]) {
        MTLayer *layer = [[MTLayer alloc] init];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        
        layer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        // 显示图层
        [layer setNeedsDisplay];
        [self.layer addSublayer:layer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    NSLog(@"2-drawRect:");
    NSLog(@"CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递的
    [super drawRect:rect];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"1-drawLayer:inContext:");
    NSLog(@"CGContext:%@",ctx);
    [super drawLayer:layer inContext:ctx];
}
@end
