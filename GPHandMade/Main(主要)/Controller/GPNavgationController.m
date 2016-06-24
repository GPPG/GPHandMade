//
//  GPNavgationController.m
//  GPHandMade
//
//  Created by dandan on 16/5/10.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNavgationController.h"
@interface GPNavgationController ()

@end

@implementation GPNavgationController

- (void)viewDidLoad {

    [UINavigationBar appearance].barTintColor = GPBgColor;
}

// 重写push方法,方便统一处理返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 判断下是否是根控制器
    
    if (self.childViewControllers.count != 0) { // 非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条左边的按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Image"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

// 返回到上一个界面
- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
