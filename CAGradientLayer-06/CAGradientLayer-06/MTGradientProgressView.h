//
//  MTGradientProgressView.h
//  CAGradientLayer-06
//
//  Created by long on 6/17/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTGradientProgressView : UIView

@property (nonatomic, readonly, getter=isAnimating) BOOL animating;
@property (nonatomic,assign) CGFloat progress;


- (void)startAnimating;
- (void)stopAnimating;

@end
