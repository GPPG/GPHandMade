//
//  GPTabBarController.m
//  GPHandMade
//
//  Created by dandan on 16/5/10.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTabBarController.h"
#import "GPHomController.h"
#import "GPHandTableViewController.h"
#import "GPFairTableViewController.h"
#import "GPMyTableViewController.h"
#import "GPTutorialTableViewController.h"
#import "GPNavgationController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface GPTabBarController ()
@property (nonatomic, strong) UIViewController *vc;
@end

@implementation GPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self addChildsVc];
    
}
- (void)addChildsVc
{
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"GPHomController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"icon_jiaocheng_",
                                   kSelImgKey : @"icon_jiaocheng_s"},
                                 
                                 @{kClassKey  : @"GPTutorialTableViewController",
                                   kTitleKey  : @"教程",
                                   kImgKey    : @"icon_ketang_",
                                   kSelImgKey : @"icon_ketang_s"},
                                 
                                 @{kClassKey  : @"GPHandTableViewController",
                                   kTitleKey  : @"手工圈",
                                   kImgKey    : @"icon_shougongquan_",
                                   kSelImgKey : @"icon_shougongquan_s"},
                                 
                                 @{kClassKey  : @"GPFairTableViewController",
                                   kTitleKey  : @"市集",
                                   kImgKey    : @"icon_shiji_",
                                   kSelImgKey : @"icon_shiji_s"},
                                 
                                 @{kClassKey  : @"GPMyTableViewController",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"icon_wode_",
                                   kSelImgKey : @"icon_wode_s"}];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
      
        self.vc = [[NSClassFromString(dict[kClassKey]) alloc]init];
       self.vc.title = dict[kTitleKey];
        GPNavgationController *nav = [[GPNavgationController alloc] initWithRootViewController:self.vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
        
    }];
    
}

@end
