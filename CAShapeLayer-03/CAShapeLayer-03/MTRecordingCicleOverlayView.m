//
//  MTRecordingCicleOverlayView.m
//  CAShapeLayer-03
//
//  Created by long on 6/17/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTRecordingCicleOverlayView.h"


@interface MTRecordingCicleOverlayView ()
@property (nonatomic, strong) NSMutableArray *progressLayers;
@property (nonatomic, strong) UIBezierPath *circlePath;
@property  (nonatomic, assign,getter = isCircleComplete) BOOL circleComplete;

@property (nonatomic, strong) CAShapeLayer *currentProgressLayer;
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@end


@implementation MTRecordingCicleOverlayView


- (id)initWithFrame:(CGRect)frame strokeWith:(CGFloat)strokeWitdh insets:(UIEdgeInsets)insets{
    if (self = [self initWithFrame:frame]) {
        self.duration = 45.0f;
        self.strokeWitdh = strokeWitdh;
        self.progressLayers = [NSMutableArray array];
        
        CGPoint arcCenter = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidX(self.bounds));
        CGFloat radius = CGRectGetMidX(self.bounds) - insets.top - insets.bottom;
        
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:M_PI endAngle:-M_PI clockwise:NO];
        [self addBackgroundLayer];
        
    }
    return self;
}


- (void)addBackgroundLayer{
    self.backgroundLayer = [CAShapeLayer layer];
    self.backgroundLayer.path = self.circlePath.CGPath;
    self.backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    self.backgroundLayer.lineWidth = self.strokeWitdh;
    [self.layer addSublayer:self.backgroundLayer];
}

- (void)addNewLayer{
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.path = self.circlePath.CGPath;
    progressLayer.strokeColor = [self randomColor].CGColor;
    progressLayer.fillColor = [UIColor clearColor].CGColor;
    progressLayer.lineWidth = self.strokeWitdh;
    progressLayer.strokeEnd = 0.f;
    
    [self.layer addSublayer:progressLayer];
    [self.progressLayers addObject:progressLayer];
    self.currentProgressLayer = progressLayer;
}


- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.f];
}


- (void)updateAnimations{
    CGFloat duration = self.duration * (1.f - [[self.progressLayers firstObject] strokeEnd]);
    CGFloat strokeEndFinal = 1.f;
    
    for (CAShapeLayer *progressLayer  in self.progressLayers) {
        CABasicAnimation *strokeEndAnimation = nil;
        strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration = duration;
        strokeEndAnimation.fromValue = @(progressLayer.strokeEnd);
        strokeEndAnimation.toValue = @(strokeEndFinal);
        strokeEndAnimation.autoreverses = NO;
        strokeEndAnimation.repeatCount = 0.f;
        
        CGFloat previousStrokeEnd = progressLayer.strokeEnd;
        progressLayer.strokeEnd = strokeEndFinal;
        
        [progressLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
        
        strokeEndFinal -= (previousStrokeEnd - progressLayer.strokeStart);
        
        if (progressLayer != self.currentProgressLayer) {
            CABasicAnimation *strokeStartAnimation = nil;
            strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            strokeStartAnimation.duration = duration;
            strokeStartAnimation.fromValue = @(progressLayer.strokeStart);
            strokeStartAnimation.toValue = @(strokeEndFinal);
            strokeStartAnimation.autoreverses = NO;
            strokeStartAnimation.repeatCount = 0.f;
            
            progressLayer.strokeStart = strokeEndFinal;
            [progressLayer addAnimation:strokeStartAnimation forKey:@"strokeStartAnimation"];
        }
    }
    
    CABasicAnimation *backgourndLayerAnimation = nil;
    backgourndLayerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    backgourndLayerAnimation.duration = duration;
    backgourndLayerAnimation.fromValue = @(self.backgroundLayer.strokeStart);
    backgourndLayerAnimation.toValue = @(1.f);
    backgourndLayerAnimation.autoreverses = NO;
    backgourndLayerAnimation.repeatCount = 0.f;
    backgourndLayerAnimation.delegate = self;
    
    self.backgroundLayer.strokeStart = 1.0;
    [self.backgroundLayer addAnimation:backgourndLayerAnimation forKey:@"strokeStartAnimation"];
    
}

- (void)updateLayerModelsForPresentationState{
    for (CAShapeLayer *progressLayer in self.progressLayers) {
        progressLayer.strokeStart = [progressLayer.presentationLayer strokeStart];
        progressLayer.strokeEnd = [progressLayer.presentationLayer strokeEnd];
        [progressLayer removeAllAnimations];
    }
    self.backgroundLayer.strokeStart = [self.backgroundLayer.presentationLayer strokeStart];
    [self.backgroundLayer removeAllAnimations];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isCircleComplete == NO) {
        [self addNewLayer];
        [self updateAnimations];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isCircleComplete == NO) {
        [self updateLayerModelsForPresentationState];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.isCircleComplete == NO && flag) {
        self.circleComplete = flag;
    }
}
@end
