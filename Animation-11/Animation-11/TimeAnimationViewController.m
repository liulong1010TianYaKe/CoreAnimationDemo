//
//  TimeAnimationViewController.m
//  Animation-11
//
//  Created by long on 6/15/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "TimeAnimationViewController.h"


@interface TimeAnimationViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *hourHand;
@property (nonatomic, weak) IBOutlet UIImageView *minuteHand;
@property (nonatomic, weak) IBOutlet UIImageView *secondHand;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation TimeAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
     // adjust anchor points
    self.secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self updateHandsAnimated:NO];
}

- (void)tick{
    [self updateHandsAnimated:YES];
}

- (void)updateHandsAnimated:(BOOL)animated{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    [self setAngle:hourAngle forHand:self.hourHand animated:animated];
    [self setAngle:minuteAngle forHand:self.minuteHand animated:animated];
    [self setAngle:secondAngle forHand:self.secondHand animated:animated];
}

//- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated
//{
//    //generate transform
//    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
//    if (animated) {
//        //create transform animation
//        CABasicAnimation *animation = [CABasicAnimation animation];
//        [self updateHandsAnimated:NO];
//        animation.keyPath = @"transform";
//        animation.toValue = [NSValue valueWithCATransform3D:transform];
//        animation.duration = 0.5;
//        animation.delegate = self;
//        [animation setValue:handView forKey:@"handView"];
//        [handView.layer addAnimation:animation forKey:nil];
//    } else {
//        //set transform directly
//        handView.layer.transform = transform;
//    }
//}


- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated{
    
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [handView.layer.presentationLayer valueForKey:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        //apply animation
        handView.layer.transform = transform;
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        //set transform directly
        handView.layer.transform = transform;
    }
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    // set final position for hand view
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}
@end
