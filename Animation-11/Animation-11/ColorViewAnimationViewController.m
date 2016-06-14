//
//  ColorViewAnimationViewController.m
//  Animation-11
//
//  Created by long on 6/14/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ColorViewAnimationViewController.h"

@interface ColorViewAnimationViewController ()
@property (nonatomic, weak) IBOutlet UIView *layerView;

@property (nonatomic,strong) CALayer *colorLayer;
- (IBAction)changeColor:(id)sender;

@end
@implementation ColorViewAnimationViewController


- (void)viewDidLoad{
    [super viewDidLoad];

//    [self createColorLayer];
//    [self testActionForLayer];
    
//    [self CreateColorLayerWithaddCustomAction];
    
    [self createColorLayerTestPresentationLayer];
}

- (void)createColorLayer{
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 70, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}


- (void)CreateColorLayerWithaddCustomAction{
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 70, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    // add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};
    // add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
}



- (void)createColorLayerTestPresentationLayer{
    // create a red layer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height /2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }else{
        // otherwise (slowly) move the layer to new positon
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}
- (IBAction)changeColor:(id)sender {
    
//    [self animtionChangeColor];
    [self animationChangeColorWithTime:2];
//    [self animationChangeColorWithView];
//    [self animationChangeLayerView];

}

/**
 *  隐式动画 默认时间为 0.25s
 */
- (void)animtionChangeColor{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

/**
 *  设置动画时间  注意旋转动画要比颜色渐变快得多，这是因为完成块是在颜色渐变的事务提交并出栈之后才被执行，于是，用默认的事务做变换，默认的时间也就变成了0.25秒
 */
- (void)animationChangeColorWithTime:(NSTimeInterval)time{
    // begin a new transaction
    [CATransaction begin];
    //set animation duartion to 1 second
    [CATransaction setAnimationDuration:time];
    // randomize the layer background color
    
    // add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    [CATransaction commit];
}

- (void)animationChangeColorWithView{
    [UIView animateWithDuration:10.f animations:^{
        [self animtionChangeColor];
    }];
}

/**
 *  UIView 禁止了隐式动画 可以看到到 图层的颜色瞬间切换到新的值
 */
- (void)animationChangeLayerView{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    [CATransaction commit];
}

/**
 *      图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
 
        如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
 
        如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
 
        最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
 */

- (void)testActionForLayer{
    // test Layer action when outside of animation block
    NSLog(@"Outside: %@",[self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    // begin animation block
    [UIView beginAnimations:nil context:nil];
    // test layer action when inside of animation block
    NSLog(@"Inside: %@",[self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    // end animation block
    [UIView commitAnimations];
}
@end
