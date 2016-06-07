//
//  ViewController.m
//  CALayer-01
//
//  Created by long on 6/6/16.
//  Copyright © 2016 long. All rights reserved.
// http://www.cocoachina.com/ios/20141022/10005.html

#import "ViewController.h"
#import "MTView.h"

#define MWIDTH 50
#define MPHOTO_HEIGHT 150

@interface ViewController ()

@property (nonatomic, weak) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self drawMyLayer];
//    
//    [self drawLayerWithCALayerDelegate];
//    
//    [self drawLayerWithShadow];
    
    [self drawWithMTView];
    
    
}

- (void)drawWithMTView{
    MTView *view = [[MTView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    
    
    [self.view addSubview:view];
}

#pragma mark -------------------
#pragma mark -  绘制图层
- (void)drawMyLayer{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CALayer *layer = [[CALayer alloc] init];
    // 设置背景颜色，由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, MWIDTH, MWIDTH);
    layer.cornerRadius = MWIDTH/2;
    
    // 设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    layer.shadowOffset = CGSizeMake(4, 4);
    layer.shadowOpacity = 0.8;
    //阴影半径，默认3
    layer.shadowRadius = MWIDTH/2 + 2;
    // 涉及到离屏渲染 只要你提前告诉CoreAnimation你要渲染的View的形状Shape,就会减少离屏渲染计算 只要你提前告诉CoreAnimation你要渲染的View的形状Shape,就会减少离屏渲染计算
    CGRect showRect = CGRectMake(0, 0, MWIDTH/2 + 5, MWIDTH/2 + 5);
    layer.shadowPath =  [UIBezierPath bezierPathWithRoundedRect:showRect cornerRadius:CGRectGetWidth(showRect)/2].CGPath;
    
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CALayer *layer = self.layer;
    CGFloat witdh = layer.bounds.size.width;
    if (witdh == MWIDTH) {
        witdh = MWIDTH * 4;
    }else{
        witdh = MWIDTH;
    }
    layer.bounds = CGRectMake(0, 0, witdh, witdh);
    layer.cornerRadius = witdh/2;
    layer.shadowPath =  [UIBezierPath bezierPathWithRoundedRect:layer.bounds cornerRadius:layer.cornerRadius].CGPath;
    layer.position = [touch locationInView:self.view];
   
}

#pragma mark -------------------
#pragma mark -  通过图层代理drawLayer: inContext:方法绘制
/**
 *  图层绘图有两种方法 ,不管使用哪种方法绘制完必须调用图层的setNeedDisplay方法
 *      通过图层代理drawLayer: inContext:方法绘制
 *      通过自定义图层drawInContext:方法绘制
 */


- (void)drawLayerWithCALayerDelegate{ // 不带阴影效果
    CGSize size = [UIScreen mainScreen].bounds.size;
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, MPHOTO_HEIGHT, MPHOTO_HEIGHT);
    layer.position = CGPointMake(size.width/2, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = MPHOTO_HEIGHT/2;
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds = YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
//        layer.shadowColor=[UIColor grayColor].CGColor;
//        layer.shadowOffset=CGSizeMake(2, 2);
//        layer.shadowOpacity=1;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;
    
    //设置图层代理
    layer.delegate=self;
    
    [self.view.layer addSublayer:layer];
    NSLog(@"--%@",layer);
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];

//    [layer display]; // 这个方法只会调用 下面displayLayer:(CALayer *)layer代理

}

- (void)drawLayerWithShadow{ // 带阴影效果
    CGSize  size = [UIScreen mainScreen].bounds.size;
    CGPoint position = CGPointMake(size.width/2, 600);
    CGRect  bounds = CGRectMake(0, 0, MPHOTO_HEIGHT, MPHOTO_HEIGHT);
    CGFloat cornerRadius = MPHOTO_HEIGHT/2;
    CGFloat borderWithd = 2;
    
    //阴影图层
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds   = bounds;
    layerShadow.position = position;
    layerShadow.cornerRadius = cornerRadius;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = borderWithd;
    [self.view.layer  addSublayer:layerShadow];
    
    // 图形图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds   = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = cornerRadius;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2;
    
    
//    UIImage *image = [UIImage imageNamed:@"photo"];
//    // 这种方式 不会发生形变
//    [layer setContents:(id)image.CGImage];
    
    layer.delegate  = self;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];

    
}
#pragma mark --

//- (void)displayLayer:(CALayer *)layer{
//     NSLog(@"displayLayer--%@",layer);
//}

/**
 *  绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
 *  注意：[layer setNeedsDisplay];之后  如果实现了 displayLayer:协议 就不会调用drawLayer:inContext
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"drawLayer:inContext--%@",layer);
    // 保存当前图形上下文
    CGContextSaveGState(ctx);
    //图形上下文形变，解决图片倒立的问题
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -MPHOTO_HEIGHT);
    
    struct CGImage *image = [UIImage imageNamed:@"photo.png"].CGImage;
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, MPHOTO_HEIGHT, MPHOTO_HEIGHT), image);
//        CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
//        CGContextDrawPath(ctx, kCGPathFillStroke);
    // 恢复图形上下文
    CGContextRestoreGState(ctx);
    // 用KVC 解决形变 问题
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
}



@end
