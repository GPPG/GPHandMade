//
//  GPSettingController.m
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSettingController.h"
#import "GPSettingGroup.h"
#import "GPSettingItem.h"
#import "GPSettingArrowItem.h"
#import "GPSettingCell.h"

@interface GPSettingController ()

@end

@implementation GPSettingController


- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
// 返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

// 返回每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 获取当前的组模型
    GPSettingGroup *group = self.groups[section];
    
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    GPSettingCell *cell = [GPSettingCell cellWithTableView:tableView style:UITableViewCellStyleValue1];

    // 获取对应的组模型
    GPSettingGroup *group = self.groups[indexPath.section];
    
    // 获取对应的行模型
    GPSettingItem *item = group.items[indexPath.row];
    
    // 2.给cell传递模型
    cell.item = item;
    
    return cell;
}

// 返回每一组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 获取组模型
    GPSettingGroup *group = self.groups[section];
    
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // 获取组模型
    GPSettingGroup *group = self.groups[section];
    
    return group.footer;
}

// 选中cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出对应的组模型
    GPSettingGroup *group = self.groups[indexPath.section];
    
    // 取出对应的行模型
    GPSettingItem *item = group.items[indexPath.row];
    
    if (item.operation) {
        
        item.operation(indexPath);
        return;
    }
    // 判断下是否需要跳转
    if ([item isKindOfClass:[GPSettingArrowItem class]]) {
        
        // 箭头类型,才需要跳转
        
        GPSettingArrowItem *arrowItem = (GPSettingArrowItem *)item;
        
        if (arrowItem.destVcClass == nil) return;
        
        // 创建跳转控制器
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
