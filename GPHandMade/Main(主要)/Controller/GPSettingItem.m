//
//  GPSettingItem.m
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSettingItem.h"

@implementation GPSettingItem
+ (instancetype)itemWithTitle:(NSString *)title
{
    GPSettingItem *item = [[self alloc] init];
    item.title = title;
    return item;
}
@end
