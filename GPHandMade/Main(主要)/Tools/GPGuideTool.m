//
//  GPGuideTool.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPGuideTool.h"
#import "GPNewFeatureController.h"
#import "GPAdViewController.h"
#define GPVersionKey @"curVersion"

#define GPUserDefaults [NSUserDefaults standardUserDefaults]
@implementation GPGuideTool
// 加载哪个控制器
+ (UIViewController *)chooseRootViewController
{
    UIViewController *rootVc = nil;

    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
    
    // 获取最新的版本号
    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    
    // 获取上一次的版本号
    NSString *lastVersion = [GPUserDefaults objectForKey:GPVersionKey];
    
    // 之前的最新的版本号 lastVersion
    if ([curVersion isEqualToString:lastVersion]) {
        // 版本号相等
        rootVc = [[GPAdViewController alloc]init];
    }else{ // 有最新的版本号
        // 保存到偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:GPVersionKey];
        rootVc = [[GPNewFeatureController alloc]init];
    }
    return rootVc;
}
@end
