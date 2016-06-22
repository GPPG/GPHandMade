//
//  GPTimeLineEventCell.h
//  GPHandMade
//
//  Created by dandan on 16/6/20.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPTimeLineData;
@interface GPTimeLineEventCell : UITableViewCell
@property (nonatomic, strong) GPTimeLineData *lineData;
@property (nonatomic,copy) void(^EventBtnClick)();
@end
