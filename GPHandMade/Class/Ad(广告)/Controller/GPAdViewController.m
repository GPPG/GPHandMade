//
//  GPAdViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPAdViewController.h"
#import "GPTabBarController.h"

@interface GPAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@end

@implementation GPAdViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupAdimage];
}

- (void)setupAdimage
{
    self.adImageView.image = [UIImage imageNamed:@"ad"];
    
     [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeAdImageView) userInfo:nil repeats:NO];
}

-(void)removeAdImageView
{
    [UIView animateWithDuration:0.3f animations:^{
        self.adImageView.transform = CGAffineTransformMakeScale(1.5f,1.5f);
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        
         [UIApplication sharedApplication].keyWindow.rootViewController = [[GPTabBarController alloc]init];
    }];
    
}
@end
