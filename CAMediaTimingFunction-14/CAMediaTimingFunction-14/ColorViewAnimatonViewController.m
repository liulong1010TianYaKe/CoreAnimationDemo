//
//  ColorViewAnimatonViewController.m
//  CAMediaTimingFunction-14
//
//  Created by long on 6/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ColorViewAnimatonViewController.h"


@interface ColorViewAnimatonViewController ()
@property (nonatomic, strong) UIView *colorView;
@end

@implementation ColorViewAnimatonViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.colorView  = [[UIView alloc] init];
    self.colorView.bounds = CGRectMake(0, 0, 100, 100);
    self.colorView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    self.colorView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.colorView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // perform the animation
//    [UIView setAnimationsEnabled:NO];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationWillStartSelector:@selector(willStartAnimation)];
//    [UIView setAnimationDidStopSelector:@selector(stopDidAnimation)];
////    [UIView setAnimationRepeatCount:2];
//    [UIView setAnimationDuration:2.0];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationRepeatAutoreverses:YES];
//    [UIView performWithoutAnimation:^{
//            self.colorView.center = [[touches anyObject] locationInView:self.view];
//            self.colorView.backgroundColor = [UIColor yellowColor];
//    }];
//    
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.colorView.center = [[touches anyObject] locationInView:self.view];
        self.colorView.backgroundColor = [UIColor yellowColor];
    } completion:^(BOOL finished) {
        NSLog(@"finshed animation : %@",finished ? @"YES": @"NO");
    }];
}

- (void)willStartAnimation{
    NSLog(@"======== willStartAnimation ======");
}


- (void)stopDidAnimation{
     NSLog(@"======== stopDidAnimation ======");
}
@end
