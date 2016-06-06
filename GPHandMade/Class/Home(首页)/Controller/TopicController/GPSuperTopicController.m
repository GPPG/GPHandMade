//
//  GPSuperTopicController.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSuperTopicController.h"

@interface GPSuperTopicController ()

@end

@implementation GPSuperTopicController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    if (self.navigationController) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    // 如果有tabBarController，底部需要添加额外滚动区域
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH, 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
