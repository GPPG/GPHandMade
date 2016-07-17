//
//  GPSettingCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSettingCell.h"
#import "GPSettingItem.h"
#import "GPSettingArrowItem.h"

@implementation GPSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle
{
    static NSString *ID = @"cell";
    GPSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:ID];
    }
    return cell;
}
- (void)setItem:(GPSettingItem *)item
{
    _item = item;
    
    [self setUpData];
    
    [self setUpAccessoryView];
}
// 设置数据
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subtitle;
}
// 设置右边的辅助视图
- (void)setUpAccessoryView
{
    if ([_item isKindOfClass:[GPSettingArrowItem class]]) { // 箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end
