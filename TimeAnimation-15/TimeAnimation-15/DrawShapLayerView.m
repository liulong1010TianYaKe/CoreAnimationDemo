//
//  DrawShapLayerView.m
//  TimeAnimation-15
//
//  Created by long on 6/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "DrawShapLayerView.h"



@interface DrawShapLayerView ()
@property (nonatomic, strong)  UIBezierPath *path;
@end


@implementation DrawShapLayerView

+ (Class)layerClass{
    return [CAShapeLayer class];
}

- (void)awakeFromNib{
    [self setup];
}


- (void)setup{
    self.path = [[UIBezierPath alloc] init];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5.0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:point];
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}
@end
