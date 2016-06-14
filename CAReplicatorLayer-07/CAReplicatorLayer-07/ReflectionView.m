//
//  ReflectionView.m
//  CAReplicatorLayer-07
//
//  Created by long on 6/13/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView
+ (Class)layerClass{
    return [CAReplicatorLayer class];
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
    // configure
    CAReplicatorLayer *replciatorLayer = (CAReplicatorLayer *)self.layer;
    replciatorLayer.instanceCount = 2;
    
    // move reflection instance below original and flip vertically
    CATransform3D transform = CATransform3DIdentity;
    CGFloat  verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    replciatorLayer.instanceTransform = transform;
    replciatorLayer.instanceAlphaOffset = -0.6;
}

@end
