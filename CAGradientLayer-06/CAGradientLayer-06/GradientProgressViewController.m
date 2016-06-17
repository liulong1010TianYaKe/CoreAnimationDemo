//
//  GradientProgressViewController.m
//  CAGradientLayer-06
//
//  Created by long on 6/17/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "GradientProgressViewController.h"
#import "MTGradientProgressView.h"

@interface GradientProgressViewController ()

@property (nonatomic, strong) MTGradientProgressView *gradientProgressView;

@end


@implementation GradientProgressViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.gradientProgressView = [[MTGradientProgressView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 2.0f)];
    [self.view addSubview:self.gradientProgressView];

}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.gradientProgressView startAnimating];
    [self simulateProgress];
}


- (void)simulateProgress{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat increment = ( arc4random() % 5 ) / 10.0f + 0.1;
        CGFloat progress = self.gradientProgressView.progress + increment;
        self.gradientProgressView.progress = progress;
        if (progress < 1.0) {
            [self simulateProgress];
        }
    });
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


@end
