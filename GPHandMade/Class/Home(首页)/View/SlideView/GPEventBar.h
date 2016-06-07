//
//  GPEventBar.h
//
//  Created by  on 16/6/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPEventBar : UIViewController
@property (nonatomic, strong) UIWindow *window_;

+ (instancetype)sharedInstace;
- (void)showCenter:(CGPoint) point cornerRadius:(CGFloat)cornerR;
- (void)ShowanimateCenter:(CGPoint) point duration:(CGFloat)duration;

@end
