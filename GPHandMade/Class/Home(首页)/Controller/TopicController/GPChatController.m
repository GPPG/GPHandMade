//
//  GPChatController.m
//  GPHandMade
//
//  Created by dandan on 16/6/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPChatController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "GPChatCell.h"
#import "GPChatData.h"
#import "GPFakeChatData.h"
#import "UIView+SDAutoLayout.h"
static NSString * const chatCell = @"chatCell";

@interface GPChatController ()
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GPChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtn];
    [self setupNav];
    
    [self setupDataWithCount:30];
    
}
- (void)setupNav
{
    self.tableView.contentInset = UIEdgeInsetsMake(SCREEN_HEIGHT * 0.02, 0, SCREEN_HEIGHT * 0.25, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[GPChatCell class] forCellReuseIdentifier:chatCell];
}
- (void)setupDataWithCount:(NSInteger)count
{
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray new];
    }
    for (int i = 0; i < count; i++) {
        GPChatData *model = [GPChatData new];
        model.messageType = arc4random_uniform(2);
        if (model.messageType) {
            model.iconName = [GPFakeChatData randomIconImageName];
            if (arc4random_uniform(10) > 5) {
                int index = arc4random_uniform(5);
                model.imageName = [NSString stringWithFormat:@"gao%d.jpg", index];
            }
        } else {
            if (arc4random_uniform(10) < 5) {
                int index = arc4random_uniform(5);
                model.imageName = [NSString stringWithFormat:@"gao%d.jpg", index];
            }
            model.iconName = @"005.jpg";
        }
        
        model.text = [GPFakeChatData randomMessage];
        [self.dataArray addObject:model];
    }
}
#pragma mark - tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPChatCell *cell = [tableView dequeueReusableCellWithIdentifier:chatCell];
    
    cell.model = self.dataArray[indexPath.row];
    
    [cell setDidSelectLinkTextOperationBlock:^(NSString *link, MLEmojiLabelLinkType type) {
        if (type == MLEmojiLabelLinkTypeURL) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
        }
    }];
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    ///////////////////////////////////////////////////////////////////////
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model" cellClass:[GPChatCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - 内部方法
- (void)addBtn
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor orangeColor]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.05);
    self.tableView.tableHeaderView = btn;
}
- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
