//
//  MTGradientProgressView.m
//  CAGradientLayer-06
//
//  Created by long on 6/17/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTGradientProgressView.h"


@interface MTGradientProgressView ()
@property (nonatomic, strong) CALayer *maskLayer;
@end

@implementation MTGradientProgressView

@synthesize progress;

#pragma mark -------------------
#pragma mark - LifyCircle

+ (Class)layerClass{
    return [CAGradientLayer class];
}

- (void)awakeFromNib{
    [self setup];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect maskRect = self.maskLayer.frame;
    maskRect.size.width = CGRectGetWidth(self.bounds) * progress;
    self.maskLayer.frame = maskRect;
}
#pragma mark -------------------
#pragma mark - methods

- (void)setup{
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    NSMutableArray *colors = [NSMutableArray array];
    for ( NSInteger deg = 0; deg <= 360; deg+=5) {
        UIColor *color = [UIColor colorWithHue:1.0 * deg / 360.0 saturation:1.0 brightness:1.0 alpha:1.0];
        [colors addObject:(__bridge id)color.CGColor];
    }
    
    gradientLayer.colors = [NSArray arrayWithArray:colors];
    
    
    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = CGRectMake(0, 0, 50, self.frame.size.height);
    self.maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    gradientLayer.mask = self.maskLayer;

    
}


- (NSArray *)shiftColors:(NSArray *)colors{
    NSMutableArray *mutable = [colors mutableCopy];
    id last = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:last atIndex:0];
    return [NSArray arrayWithArray:mutable];
}
#pragma mark -------------------
#pragma mark - Getting Setting
- (void)setProgress:(CGFloat)value{
    if (progress != value) {
        progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}


#pragma mark -------------------
#pragma mark - Animation
- (void)performAnimation{
    CAGradientLayer *gradiendLayer = (CAGradientLayer *)self.layer;
    NSArray *fromColors = gradiendLayer.colors;
    NSArray *toColors = [self shiftColors:fromColors];
    gradiendLayer.colors = toColors;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.fromValue = fromColors;
    animation.toValue = toColors;
    animation.duration = 0.08;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [gradiendLayer addAnimation:animation forKey:@"animateGradient"];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self isAnimating]) {
        [self performAnimation];
    }
}

#pragma mark -------------------
#pragma mark - Public
- (void)startAnimating{
    if (![self isAnimating]) {
        _animating = YES;
        [self performAnimation];
    }
}

- (void)stopAnimating{
    if ([self isAnimating]) {
        _animating = NO;
    }
}
@end
