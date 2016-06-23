//
//  GPLoginController.m
//  denglu
//
//  Created by dandan on 16/6/22.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPLoginController.h"
#import "UIView+GPExtension.h"
#import "GPEventBtn.h"

@interface GPLoginController ()
- (IBAction)loginBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *buble1;
@property (weak, nonatomic) IBOutlet UIImageView *buble3;
@property (weak, nonatomic) IBOutlet UIImageView *buble2;
@property (weak, nonatomic) IBOutlet UIImageView *buble4;
@property (weak, nonatomic) IBOutlet UIImageView *buble5;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *dot;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, weak) UIActivityIndicatorView * acView;
@property (nonatomic, weak) UIImageView *snipImageView;
@property (nonatomic, assign) CGPoint loginPoint;
@property (nonatomic, weak) GPEventBtn *eventBtn;

@end

@implementation GPLoginController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupAnimtion];
    [self addEventBar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self nextAnimtion];
}
#pragma mark - 初始化
- (void)setupView
{
    self.navigationController.navigationBarHidden = YES;
    UIActivityIndicatorView *acView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.acView = acView;
    
    UIImageView *snipImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Warning"]];
    snipImageView.hidden = YES;
    [self.view addSubview:snipImageView];
    self.snipImageView = snipImageView;
}
- (void)addEventBar
{
    GPEventBtn *eventBtn = [[GPEventBtn alloc]init];
    [eventBtn setImage:[UIImage imageNamed:@"activity_works_Btn"] forState:UIControlStateNormal];
    [eventBtn sizeToFit];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn showEventButCenter:CGPointMake(SCREEN_WIDTH * 0.5 , SCREEN_HEIGHT - GPEventScale * eventBtn.width)];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventBtn];
    [self.view bringSubviewToFront:eventBtn];
    eventBtn.hidden = YES;
    self.eventBtn = eventBtn;
}

#pragma mark - 动画
- (void)setupAnimtion
{
    self.buble1.transform = CGAffineTransformMakeScale(0, 0);
    self.buble2.transform = CGAffineTransformMakeScale(0, 0);
    self.buble3.transform = CGAffineTransformMakeScale(0, 0);
    self.buble4.transform = CGAffineTransformMakeScale(0, 0);
    self.buble5.transform = CGAffineTransformMakeScale(0, 0);
    self.logo.centerX-= self.view.width;
    self.dot.centerX -= self.view.width/2;
    
    UIView *paddingUserView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, self.userName.height)];
    self.userName.leftView = paddingUserView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingPassView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, self.password.height)];
    self.password.leftView = paddingPassView;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIImageView *userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User"]];
    userImageView.x = 5;
    userImageView.y = 5;
    [self.userName addSubview:userImageView];
    
    UIImageView *passImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Key"]];
    passImageView.x = 5;
    passImageView.y = 5;
    [self.password addSubview:passImageView];
    
    self.userName.centerX -= self.view.width;
    self.password.centerX -= self.view.width;
    self.loginBtn.centerX -= self.view.width;
    
 
}

- (void)nextAnimtion
{
    [UIView animateWithDuration:0.3 delay:0.3 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.buble1.transform = CGAffineTransformMakeScale(1, 1);
        self.buble2.transform = CGAffineTransformMakeScale(1, 1);
        self.buble3.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.buble4.transform = CGAffineTransformMakeScale(1, 1);
        self.buble5.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.logo.centerX += self.view.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.userName.centerX += self.view.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.password.centerX += self.view.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginBtn.centerX += self.view.width;
    } completion:nil];
    
    [UIView animateWithDuration:3 delay:1 usingSpringWithDamping:0.1 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.dot.centerX += self.view.width * 0.4;
    } completion:nil];
    

}
#pragma mark - 内部方法
- (IBAction)loginBtnClick:(UIButton *)sender {
    
    self.loginBtn.enabled = NO;
    self.acView.center = CGPointMake(0, 0);
    [self.acView startAnimating];
    [self.loginBtn addSubview:self.acView];
    self.snipImageView.center = self.loginBtn.center;
    self.loginPoint = self.loginBtn.center;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.loginBtn.centerX -= 30;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.loginBtn.centerX += 30;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.loginBtn.centerY += 90;
                [self.acView removeFromSuperview];
            }completion:^(BOOL finished) {
                [UIView transitionWithView:self.snipImageView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                    self.snipImageView.hidden = NO;
                }completion:^(BOOL finished) {
                        [UIView transitionWithView:self.snipImageView duration:3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                            self.snipImageView.hidden = YES;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.2 animations:^{
                                self.loginBtn.center = self.loginPoint;
                            }completion:^(BOOL finished) {
                                self.loginBtn.enabled = YES;
                            }];
                        }];
                }];
            }];
        }];
    }];
}
- (void)dismissVc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.loginBtn removeFromSuperview];
    [UIView transitionWithView:self.eventBtn duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.eventBtn.hidden = NO;
    } completion:nil];
}
@end
