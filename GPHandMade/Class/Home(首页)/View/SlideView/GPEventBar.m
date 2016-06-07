//
//  GPEventBar.m
//
//  Created by dandan on 16/6/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEventBar.h"

@interface GPEventBar ()
@end

@implementation GPEventBar

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - 单例
static id instance_;
+ (instancetype)sharedInstace
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance_;
}

#pragma mark - window相关处理
- (void)showCenter:(CGPoint) point cornerRadius:(CGFloat)cornerR
{
    // 添加 Window
    CGFloat R = 2 * cornerR;
    _window_ = [[UIWindow alloc] init];
    _window_.centerX = point.x - cornerR;
    _window_.centerY = point.y - cornerR;
    _window_.width = R;
    _window_.height = R;
    _window_.layer.cornerRadius = cornerR;
    _window_.backgroundColor = [UIColor orangeColor];
    _window_.hidden = NO;
    _window_.windowLevel = UIWindowLevelAlert;
    
    // 添加文字
    UILabel *label = [self addLael];
    label.x = 0;
    label.y = R * 0.22;
    label.width = R;
    label.height = cornerR;
    [_window_ addSubview:label];

    _window_.rootViewController = [[GPEventBar alloc] init];
}
- (void)ShowanimateCenter:(CGPoint) point duration:(CGFloat)duration
{
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        _window_.center = point;
    } completion:nil];
}
- (UILabel *)addLael
{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"参加";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


@end
