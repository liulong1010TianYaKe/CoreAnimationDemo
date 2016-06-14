//
//  MTScrollView.m
//  CAScrollLayer-08
//
//  Created by long on 6/13/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTScrollView.h"

@implementation MTScrollView
+ (Class)layerClass{
    return [CAScrollLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    self.layer.masksToBounds = YES;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:recognizer];
    
    CAScrollLayer *scollLayer = (CAScrollLayer *)self.layer;
    scollLayer.scrollMode = kCAScrollBoth;
//    [scollLayer scrollToRect:CGRectMake(200, 300, 100, 100)];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint offset  = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollPoint:offset];
    [recognizer setTranslation:CGPointZero inView:self];
}
@end
