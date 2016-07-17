//
//  GPMyTableViewController.m
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPMyTableViewController.h"
#import "GPMyHeadView.h"


@interface GPMyTableViewController ()

@end

@implementation GPMyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeadView];

    [self setUpGroup0];
    
    [self setUpGroup1];
    
    [self setUpGroup2];
}

- (void)setupHeadView
{
    GPMyHeadView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GPMyHeadView class]) owner:nil options:nil].lastObject;
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    self.tableView.tableHeaderView = headView;
    headView.BtnClick = ^{
    };
}
// 第0组
- (void)setUpGroup0
{
    // 创建组模型
    GPSettingGroup *group = [[GPSettingGroup alloc] init];
    group.items = [NSMutableArray array];

    group.header = @"消息通知";
    NSArray *zeroSection = @[@"评论",@"回复",@"@我",@"私信",@"手工圈"];
    for (int i = 0; i < zeroSection.count; i ++) {
        // 创建行模型
        GPSettingItem *item = [GPSettingArrowItem itemWithTitle:zeroSection[i]];
        item.operation = ^(NSIndexPath *indexPath){
            [self openUrl:Blog];
        };
        [group.items addObject:item];
    }
    [self.groups addObject:group];
    
}
- (void)setUpGroup1
{
    // 创建组模型
    GPSettingGroup *group = [[GPSettingGroup alloc] init];
    group.items = [NSMutableArray array];

    group.header = @"订单";
    NSArray *oneSection = @[@"市集订单",@"教程订单",@"线下课订单",@"我的优惠券"];
    for (int i = 0; i < oneSection.count; i ++) {
        // 创建行模型
        GPSettingItem *item = [GPSettingArrowItem itemWithTitle:oneSection[i]];
        item.operation = ^(NSIndexPath *indexPath){
            [self openUrl:Github];
        };
        [group.items addObject:item];
    }
    [self.groups addObject:group];

    
}
- (void)setUpGroup2
{

    // 创建组模型
    GPSettingGroup *group = [[GPSettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.header = @"个人设置";
    NSArray *theerSection = @[@"个人资料",@"等级与积分",@"修改密码",@"清除缓存",@"帮助中心",@"新消息通知",@"意见反馈",@"关于手功课",@"关于手工课微信",@"喜欢手工课"];
    for (int i = 0; i < theerSection.count; i ++) {
        // 创建行模型
        GPSettingItem *item = [GPSettingArrowItem itemWithTitle:theerSection[i]];
        item.operation = ^(NSIndexPath *indexPath){
            [self openUrl:Blog];
        };
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}
#pragma mark - 内部方法
- (void)openUrl:(NSString *)urlStr
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

@end
