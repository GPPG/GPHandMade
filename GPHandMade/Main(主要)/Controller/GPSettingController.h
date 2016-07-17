//
//  GPSettingController.h
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSettingGroup.h"
#import "GPSettingItem.h"
#import "GPSettingArrowItem.h"
#import "GPSettingCell.h"

@interface GPSettingController : UITableViewController
@property (nonatomic, strong) NSMutableArray *groups;

@end
